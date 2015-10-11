//
// Created by Alex Simonides on 5/15/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import "BaseNSWDataSource.h"
#import "FLDownloader.h"
#import "EventListViewController.h"
#import "DayViewController.h"

@interface BaseNSWDataSource ()
@property (nonatomic, strong) NSDictionary *urlMap;
@end

@implementation BaseNSWDataSource

static NSString *genericRawFilePath;
static NSString *genericSafeFilePath; //location of the data that has been translated to UTF-8
static BOOL dataIsReady;
@synthesize localData;
@synthesize dataList;

// Maps what URL corresponds to which local file name
- (id)urlMap {
    if (!_urlMap) {
        NSArray *fileNames = @[@"events.ics", @"contacts.html", @"terms.json", @"faq.html",@"StudentProfiles.txt"];
        
        NSArray *urls = @[[NSURL URLWithString:@"https://apps.carleton.edu/newstudents/events/?start_date=2015-08-05&format=ical"],
                [NSURL URLWithString:@"https://apps.carleton.edu/newstudents/contact/"],
                [NSURL URLWithString:@"http://sgrinich.github.io/speak_carleton.json"],
                [NSURL URLWithString:@"http://apps.carleton.edu/newstudents/contact/faq/#site_index"],
                [NSURL URLWithString:@"http://sgrinich.github.io/StudentProfiles.txt"]];
        
        _urlMap = [NSDictionary dictionaryWithObjects:urls forKeys:fileNames];
        if (_urlMap.count != urls.count) {
            NSLog(@"Have %d URLs, but have %d entries in urlMap", urls.count, _urlMap.count);
        }
    }
    return _urlMap;
}


- (id)initPrivate {
    self.downloadStarted = [NSDate date];
    dataIsReady = NO;
    return [super init];
}

- (id)initWithDataFromFile:(NSString *)localName {
    self = [self initPrivate];
    if (self) {
        myTableViewController = nil;
        NSURL *remoteURL = [self.urlMap objectForKey:localName];
        [self getLocalFile:localName orDownloadFromURL:remoteURL];
    }

    return self;
}

// Attaches a TableViewController to send the data to once it has been loaded
- (void)attachVCBackref:(BaseNSWTableViewController *)tableViewController {
    myTableViewController = tableViewController;
    
    // If data is ready, send it to tableViewController. Otherwise the data is still 
    // being retrieved and will be sent when it's ready.
    if (dataIsReady) {
        // EventListViewController only wants the list for today
        if ([tableViewController isKindOfClass:[EventListViewController class]]) {
            [(EventListViewController *) myTableViewController getEventsFromCurrentDate];
        } else {
            [myTableViewController setVCArrayToDataSourceArray:self.dataList];
        }
    } else {
        NSLog(@"Data is still being retrieved.");
    }
}

// Attaches a TableViewController to send the data to once it has been loaded
- (void)attachDayVCBackref:(DayViewController *)tableViewController {
    myDayViewController = tableViewController;
    
    // If data is ready, send it to tableViewController. Otherwise the data is still
    // being retrieved and will be sent when it's ready.
    if (dataIsReady) {
        // EventListViewController only wants the list for today
        if ([tableViewController isKindOfClass:[DayViewController class]]) {
            [(DayViewController *) myTableViewController getEventsFromCurrentDate];
        } else {
            [myTableViewController setVCArrayToDataSourceArray:self.dataList];
        }
    } else {
        NSLog(@"Data is still being retrieved.");
    }
}

// Create the directories that the data files will be stored in 
// if it hasn't already been created
- (void)createLocalDataDirectoryIfNoneExists {
    genericRawFilePath = [[[FLDownloader sharedDownloader] defaultFilePath] stringByAppendingPathComponent:@"RawData"];
    genericSafeFilePath = [[[FLDownloader sharedDownloader] defaultFilePath] stringByAppendingPathComponent:@"SafeData"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *filePaths = @[genericRawFilePath, genericSafeFilePath];
    for (NSString *filePath in filePaths) {
        BOOL isDir;
        BOOL locationExists = [fileManager fileExistsAtPath:filePath
                                                isDirectory:&isDir];
        // isDir will be changed to whether the genericRawFilePath is a directory. 
        // It's how locationExists is able to "return" 2 values
        if (!locationExists) {
            NSError *error;
            [fileManager createDirectoryAtPath:filePath
                   withIntermediateDirectories:NO
                                    attributes:nil
                                         error:&error];
            if (error) {
                NSLog(@"%@", error);
            }
        } else if (!isDir) {
            NSLog(@"%@ exists but isn't a directory", filePath);
        }
    }
}

// If the file exists locally, load it into self.localData (using getRawDataFromURL)
// Otherwise, download it to local storage THEN load it into self.localData
- (void)getLocalFile:(NSString *)fileName orDownloadFromURL:(NSURL *)URL {
    [self createLocalDataDirectoryIfNoneExists];
    NSString *pathToRawFile = [genericRawFilePath stringByAppendingPathComponent:fileName];
    
    //A block to "download" the data file from the file system into self.localData
    void (^onCompletion)(BOOL, NSError *) = ^(BOOL success, NSError *error) {
        if (success) {
            [self loadUTF8Data:fileName];
            [self parseLocalData];
            //[self getRawDataFromURL:[NSURL fileURLWithPath:pathToRawFile]];
            if(error) {
                NSLog(@"Error copying file to string:\n  %@", error);
            }
        } else {
            NSLog(@"Error downloading %@: %@", fileName, error);
        }
    };
    
    //Set up a FLDownloadTask to download the source from the URL, but don't start yet
    FLDownloadTask *downloadTask = [[FLDownloader sharedDownloader] downloadTaskForURL:URL];
    [downloadTask setFileName:fileName];
    [downloadTask setDestinationDirectory:genericRawFilePath];
    [downloadTask setCompletionBlock:onCompletion];

    if ([[NSFileManager defaultManager] fileExistsAtPath:pathToRawFile]){
        onCompletion(YES, nil);
        //TODO check how old the local data is, Then reload if more than a day
    } else {
        [downloadTask start];
    }
    
}

/** Carleton's event database stores UTF-8 data. However, we are accessing it through an iCal export, 
  * which breaks any string greater than 76 bytes across multiple lines. In rare cases, this break can 
  * occur in the middle of a multi-byte character (such as the typographical apostrophe ’), which leaves 
  * us with 3 bytes (separated by a line break + a space) that aren't valid UTF-8 characters, so the 
  * raw ics file cannot be decoded as UTF-8.
  * 
  * In this method, we fix the logn strings by getting rid of the line breaks in them, thus rejoining the 
  * broken multi-bit characters :-D
*/
- (void)loadUTF8Data:(NSString *)fileName {
    NSError *error;
    //try to load the UTF-8 local data
    NSString *utfString = [NSString stringWithContentsOfFile:[genericSafeFilePath stringByAppendingPathComponent:fileName] 
                                                    encoding:NSUTF8StringEncoding 
                                                       error:&error];

    
    // i.e. the data wasn't there or couldn't be loaded as UTF-8
    if (!utfString) {
        NSLog(@"Could not load %@ as UTF-8 from location:\n  %@\n  Error: %@\n  Will try %@", 
                fileName, genericSafeFilePath, error.description, genericRawFilePath);
        // Clear error for reuse
        error = nil;
        NSData *originalData = [NSData dataWithContentsOfFile:[genericRawFilePath stringByAppendingPathComponent:fileName] 
                                                      options:0
                                                        error:&error];
        
        if (!error) {
            char utf8BOM[] = {0xEF, 0xBB, 0xBF}; //These 3 bytes represent the BOM for a UTF-8 text file
            NSMutableData *utf8Data = [NSMutableData dataWithBytes:utf8BOM length:3];
            [utf8Data appendData:originalData];
            
            NSData *lineBreakAndSpace = [@"\r\n " dataUsingEncoding:NSUTF8StringEncoding];
            // The original iCal file has CRLF line endings and all continuation lines start with a space to 'indent' them
            NSData *crEnding = [@"\r" dataUsingEncoding:NSUTF8StringEncoding];
            
            //Remove a lineBreakAndSpace byte sequences
            utf8Data = [self dataByReplacingSubData:lineBreakAndSpace inData:utf8Data withData:nil];
            
            //Remove the \r from every CRLF line ending, leaving just \n
            utf8Data = [self dataByReplacingSubData:crEnding inData:utf8Data withData:nil];

            BOOL success = [utf8Data writeToFile:[genericSafeFilePath stringByAppendingPathComponent:fileName] atomically:YES];
            if (success) {

                self.localData = utf8Data;
            }
            //TODO save localData to file
        } else {
            NSLog(@"%@", error.description);
        }
    } else {
        self.localData = [utfString dataUsingEncoding:NSUTF8StringEncoding];
    }
}

// Replaces any existing occurences of dataToReplace with dataToPut
- (NSMutableData *)dataByReplacingSubData:(NSData *)dataToReplace
                                   inData:(NSData *)fullData
                                 withData:(NSData *)dataToPut {
    
    NSMutableData *mutableData = [fullData mutableCopy];
    
    // Initial values to be replaced if dataToPut is non-null
    NSUInteger numberOfReplacementBytes = 0;
    const char *bytesToPut = NULL;
    if(dataToPut) {
        numberOfReplacementBytes = dataToPut.length;
        bytesToPut = dataToPut.bytes;
    }
    NSLog(@"size to put: %i", numberOfReplacementBytes);
    
    NSRange rangeToReplace = NSMakeRange(0, 0);
    while (rangeToReplace.location != NSNotFound){
        [mutableData replaceBytesInRange:rangeToReplace withBytes:bytesToPut length:numberOfReplacementBytes];
        rangeToReplace = [mutableData rangeOfData:dataToReplace options:0 range:NSMakeRange(0, mutableData.length)];
    }

    return mutableData;
}

- (void)parseLocalData {
    // Extended in subclasses
    [self logDownloadTime];
}

// Log how long it took to retrieve the download
- (void)logDownloadTime {
    dataIsReady = YES;
    NSDate *downloadFinished = [NSDate date];
    NSLog(@"Download took %.6f seconds", [downloadFinished timeIntervalSinceDate:self.downloadStarted]);
}

/* Convenience/readability wrapper for a very unwieldily-named function
 * Which splits a string between any of the characters listed in splitCharacters
 */
+ (NSArray *)splitString:(NSString *)wholeString atCharactersInString:(NSString *)splitCharacters{
    return [wholeString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:splitCharacters]];
}

@end