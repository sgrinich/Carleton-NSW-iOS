//
//  EventDataSource.m
//  NSW
//
//  Created by Stephen Grinich on 5/9/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "EventDataSource.h"
#import "NSWEvent.h"
#import "NSWConstants.h"


@implementation EventDataSource

// All the parsed NSWEvent objects
@synthesize fullEventList;


- (id)init {
    self = [super initWithDataFromFile:@"events.ics"];
    
    return self;
}


- (void)parseLocalData{
    [self parseDataIntoEventList];
    [super parseLocalData];
}

- (void)parseDataIntoEventList {
    
    // This ASCII can't handle the typographical apostrophe. Unicode gives us Chinese, UTF-8 gives us nil. What do we do?
    NSString *rawICSString = [[NSString alloc] initWithData:self.localData encoding:NSUTF8StringEncoding]; //NSUTF8StringEncoding];

    NSArray *splitEventStrings = [rawICSString componentsSeparatedByString:@"BEGIN:VEVENT"];

    //NSLog(@"%@", splitEventStrings[1]);

    self.fullEventList = [[NSMutableArray alloc] init];
    for (NSUInteger i = 1; i < splitEventStrings.count-1; i++) {
        NSWEvent *currentEvent = [self parseEventFromString:splitEventStrings[i]];
        [self.fullEventList addObject:currentEvent];
    }

    // Send the data to the view controller if there's one linked, otherwise 
    // copy it into self.dataList to be retrieved once a VC has been linked
    if (myTableViewController != nil) {
        [(EventListViewController *) myTableViewController getEventsFromCurrentDate];
    } else {
        self.dataList = fullEventList;
    }
}


// Called by the ViewController to only get the events for one day
- (void)getEventsForDate:(NSDate *)currentDate {

    NSDateComponents *currentDateComps = [NSWEvent getDateComponentsFromDate:currentDate];
    NSString *predicateFormat = [NSString stringWithFormat: @"startDateComponents.day = %i && startDateComponents.month == %i && startDateComponents.year == %i",
                    currentDateComps.day, currentDateComps.month, currentDateComps.year];
    NSLog(@"Current Date Comps: %@", currentDateComps);
    NSPredicate *dateMatchesCurrent = [NSComparisonPredicate predicateWithFormat:predicateFormat];
    NSArray *todaysEvents = [fullEventList filteredArrayUsingPredicate:dateMatchesCurrent];

    [myTableViewController setVCArrayToDataSourceArray:[self eventsSortedByTime:todaysEvents]];
}

//Sorts the input array of NSWEvents by their startDateTime attribute
-(NSArray *)eventsSortedByTime:(NSArray *)unsortedEvents {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startDateTime"
                                                 ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    NSArray *sortedEvents = [unsortedEvents sortedArrayUsingDescriptors:sortDescriptors];
    return sortedEvents;
}

//Returns an NSDate for exactly 1 day before the input
+ (NSDate *)oneDayBefore:(NSDate *) currentDate{
    
    if ([[NSDate dateWithTimeInterval:(-1 * secondsPerDay) sinceDate:currentDate] timeIntervalSinceDate:[NSWConstants firstDayOfNSW]] < 0){
         NSLog(@"too soon");
        return currentDate;
    }
    else{
        return [NSDate dateWithTimeInterval:(-1 * secondsPerDay) sinceDate:currentDate];
    }
}

//Returns an NSDate for exactly 1 day after the input
+ (NSDate *)oneDayAfter:(NSDate *) currentDate{
    if ([[NSDate dateWithTimeInterval:(secondsPerDay) sinceDate:currentDate] timeIntervalSinceDate:[NSWConstants lastDayOfNSW]] > 0){
        NSLog(@"too soon");
        return currentDate;
    }
    else{
        return [NSDate dateWithTimeInterval:(secondsPerDay) sinceDate:currentDate];
    }
}


// ----------------------------------------------------------------------------
#pragma mark Parsing methods
// ----------------------------------------------------------------------------

/* Builds a NSWEvent from a given ics-formatted event
example ICS event:
    UID:20100804115306-653193@carleton.edu
    SUMMARY:NSW Parent Information Session: The First Year at Carleton
    DESCRIPTIONT:he beginning of a college career brings momentous transitions to students
    and their families. At this session, staff and faculty will describe the va
    rious resources for guidance and assistance available to Carleton students
    and make some suggestions about parents’ roles in a liberal arts educatio
    n.
    LOCATION:Concert Hall
    LAST-MODIFIED:20120726T151934
    CREATED:20100804T115306
    DTSTART:20120904T150000
    DURATION:PT0H45M0S
    END:VEVENT
*/
- (NSWEvent *)parseEventFromString:(NSString *) icsFormattedEvent {
    //First break the string into lines
    NSArray *lines = [icsFormattedEvent componentsSeparatedByString:@"\n"];

    // get UID portion
    NSString *id_ = [self parseID:lines[1]];
    
    // get summary
    NSMutableString *title_ = [[self parseSimpleICSAttribute:lines[2]] mutableCopy];
    NSMutableString *desc_ = [@"" mutableCopy];
    NSString *loc_;
    NSDate *start_;
    NSTimeInterval dur_ = 0;


    BOOL inTitle = YES;
    BOOL inDescription = NO;
    //We can confidently assume the first two lines, (and usually the third, but not always) but beyond those the
    // description lasts an arbitrary number of lines and there are optional attributes that prevent us from reverse-indexing
    for (NSUInteger i = 3; i < lines.count-1; i++) {
        NSMutableString *currentLine = lines[i];
        
        

        // Descriptions and titles longer than 76 characters are more than one line and have a blank
        // space at the beginning of subsequent lines to indent them slightly
        if ([currentLine hasPrefix:@" "]) {
            if (inDescription) {
                [desc_ appendString: [currentLine substringFromIndex:1]];
                
                // handles line breaks present in raw event description
                desc_ = [[desc_ stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n\n"] mutableCopy];

                
            }
            // Almost no titles are this long, but there are some
            else if (inTitle){
                [title_ appendString: [currentLine substringFromIndex:1]];
                
            }
        }

        else {
            inTitle = NO;
            inDescription = NO;
            
            // This section causes errors when descriptions include something like "3:00pm".
            
            // This pattern will only match ':' symbols with a capital letter on the left side of the ':'s.
            //NSString *pattern = @"(?<=[^0-9]):";
            
            //[NDYLT] used to be [A-Z], but this appears to fix a problem
            NSString *pattern = @"(?<=[NDYLT]):";
            NSString *dummy =  @" NEVERSEETHIS ";
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
            NSRange range = NSMakeRange(0, [currentLine length]);
            NSString *modified = [regex stringByReplacingMatchesInString:currentLine options:0 range:range withTemplate:dummy];
 
            NSArray *splitLine = [modified componentsSeparatedByString:dummy];
            

            NSString *attributeTitle = splitLine[0];
            
            if ([attributeTitle isEqual:@"DESCRIPTION"]) {
                [desc_ appendString:splitLine[1]];
                
                // handles line breaks present in raw event description
                desc_ = [[desc_ stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n\n"] mutableCopy];
                
                inDescription = YES;
            }
            else if ([attributeTitle isEqual:@"LOCATION"]){
                loc_ = splitLine[1];
            }
            else if ([attributeTitle isEqual:@"DTSTART"]){
                start_ = [self parseDateTimeFromICSString:splitLine[1]];
            }
            else if ([attributeTitle isEqual:@"DURATION"]){
                dur_ = [self parseDurationFromICSString:splitLine[1]];
            }
        }
        
        // this is needed to put URL in description, since the raw data says "here" where "here" links to a URL on the NSW website
        if ([title_ isEqualToString:@"NSW: Music Auditions"]) {
            desc_ = [@"Please refer to the Department of Music website here: https://apps.carleton.edu/curricular/musc/newstudents/schedule/ for additional information." mutableCopy];
        }
        
        // this location is too long, so shorten it
        if([title_ isEqualToString:@"NSW: Career Center Welcome Reception"]){
            loc_ = @"Sayles, 2nd Floor Balcony";
        }
        
        if([title_ isEqualToString:@"NSW: Language Placement"]){
            loc_ = @"LDC Classrooms";
        }
        
        if([title_ isEqualToString:@"NSW: Meaning, Music & Muffins"]){
            loc_ = @"Chapel Lobby (Street Side)";
        }
        
        if([title_ isEqualToString:@"NSW: Rainbow Reception"]){
            loc_ = @"GSC, Ground Scoville";
        }
        
        
        
        
    }
    /*
    if (id_ == nil || title_ == nil || desc_ == nil || loc_ == nil || start_ == nil || dur_ == 0){
        //TODO Handle Errors
    }
    */
    return [[NSWEvent alloc] initWithID:id_
                                  Title:title_
                            Description:desc_
                               Location:loc_
                                  Start:start_
                               Duration:dur_];
}

- (NSString *)parseID:(NSString *) idLine{
    NSArray *lineComponents = [EventDataSource splitString:idLine atCharactersInString:@"-@"];
    //The unique ID is the part between the "-" and the "@"
    return lineComponents[1];
}

// Most of the attributes are of the form "ATTRIBUTENAME:data-we-care-about"
- (NSString *)parseSimpleICSAttribute:(NSString *) fullLine{
    NSMutableArray *lineComponents = (NSMutableArray *) [fullLine componentsSeparatedByString:@":"];
    NSLog(@"Line components: %@",lineComponents);

    if (lineComponents.count == 2){
        return lineComponents[1];
    }
    else {
        // Remove the attribute title then put back any other :s we removed
        [lineComponents removeObjectAtIndex:0];
        return [lineComponents componentsJoinedByString:@":"];
    }
}


// Takes a start time string in the ICS format and translates it into an NSDate object
- (NSDate *)parseDateTimeFromICSString:(NSString *)rawStartDateTime {
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil){
        dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];

        [dateFormatter setLocale:enUSPOSIXLocale];
        [dateFormatter setDateFormat:@"yyyyMMdd'T'HHmmss"];
        [dateFormatter setTimeZone:[NSWConstants northfieldTimeZone]]; // US Central time
    }

    // Convert raw string to an NSDate.
    NSDate *convertedDate = [dateFormatter dateFromString:rawStartDateTime];
    NSLog(@"Current date: %@", convertedDate);
    return convertedDate;
}

// Create a NSTimeInterval from an ICS-formatted DURATION
- (NSTimeInterval)parseDurationFromICSString:(NSString *)rawDuration {
    // Split a string that looks like "PT##H##M##S" into the array ['P', # of hours, # of minutes, # of seconds, '']
    NSArray *matches = [EventDataSource splitString:rawDuration atCharactersInString:@"THMS"];

    NSNumber *hours = matches[1];
    NSNumber *minutes = matches[2];
    NSNumber *seconds = matches[3];

    return ([hours doubleValue]*secondsPerHour +
            [minutes doubleValue]*secondsPerMinute +
            [seconds doubleValue]);
}




@end
