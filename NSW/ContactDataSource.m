//
//  ContactDataSource.m
//  
//
//  Created by Evan Harris on 5/11/14.
//  Added functionality by Stephen Grinich
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "ContactDataSource.h"
#import "Contact.h"
#import "ContactTableViewController.h"

@implementation ContactDataSource

NSMutableArray *parsedContacts;


- (id)init {
    self = [super initWithDataFromFile:@"contacts.html"];

    return self;
}

- (void)parseLocalData {
    [self parseContactsFromHTML];
    [super parseLocalData];
}

- (void)parseContactsFromHTML{
    
    parsedContacts = [[NSMutableArray alloc] init];
    NSString *rawHTML = [[NSString alloc] initWithData:self.localData encoding:NSUTF8StringEncoding];

    /* get the chunk of html code that contains contact info
        add each 'contact' chunk into a temporary list, splitHTMLContacts */

    // Throw away everything before "<hr/>" ...
    NSString *afterHR = [rawHTML componentsSeparatedByString:@"<hr />\n"][1];
    // ... And after "</main>"
    NSString *pertinentContent = [afterHR componentsSeparatedByString:@"\n</main>"][0];

    // Each 'contact' on the page (except the first) starts like this
    NSString *contactPrefix = @"<p class=\"contentMain\"><strong>";
    NSMutableArray *splitHTMLContacts = (NSMutableArray *) [pertinentContent componentsSeparatedByString:contactPrefix];
    //[splitHTMLContacts removeObjectsInRange:NSMakeRange(0, 3)];

    // The first 'contact' is a special case because its <p> doesn't have a class, so we fix it
    NSString *firstContact = splitHTMLContacts[0];
    NSString *normalizedFirst = [firstContact componentsSeparatedByString:@"<p><strong>"][1];
    splitHTMLContacts[0] = normalizedFirst;
    
    
    
    
    /* loop through parse each each section of HTML into a new Contact
        add each instance created into global parsedContacts variable
     */
    for (id obj in splitHTMLContacts){
        Contact *currentContact = [self parseContactFromString:obj];
        [parsedContacts addObject:currentContact];
    }

    // Send the data to the view controller if there's one linked, otherwise 
    // copy it into self.dataList to be retrieved once a VC has been linked
    if (myTableViewController != nil){
        [myTableViewController setVCArrayToDataSourceArray:parsedContacts];
    } else {
        self.dataList = [NSArray arrayWithArray:parsedContacts];
    }
}

- (Contact *)parseContactFromString:(NSString *) htmlContact {

    //Strip out any special html characters
    htmlContact = [htmlContact stringByReplacingOccurrencesOfString:@"&nbsp;"
                                                         withString:@""];
    htmlContact = [htmlContact stringByReplacingOccurrencesOfString:@"&amp;"
                                                         withString:@"and"];
    //Handle typos on the webpage
    htmlContact = [htmlContact stringByReplacingOccurrencesOfString:@"<br /></strong>"
                                                         withString:@"</strong><br />\n"];

    NSArray *contactLines = [htmlContact componentsSeparatedByString:@"<br />\n"];

    NSString *title = [self parseTitleLine:contactLines[0]];
    NSString *phone = [self parsePhoneNumberFromLine:contactLines[1] withPrefix:@"Phone:"];
    NSString *fax = nil;
    NSString *email = nil;
    

    // Some contacts don't have a fax number
    if (contactLines.count == 3) {
        email = [self parseEmailLine:contactLines[2]];
        
        // Handles case where HTML of data source is formatted weirdly and email doesn't contain @carleton.edu
        if([email rangeOfString:@"@carleton.edu"].location == NSNotFound){
            email = [email stringByAppendingString:@"@carleton.edu"];
        }
        
    
    }
    
    else if (contactLines.count == 4) {
        fax = [self parsePhoneNumberFromLine:contactLines[2] withPrefix:@"Fax:"];
        email = [self parseEmailLine:contactLines[3]];
    }
    
    // We do this because the SAO sometimes has bugs in their email formatting. So, whenever you get a phone or email crash it's probably because of this. 
    if([title isEqualToString:@"OneCard"]){
        email = @"onecard@carleton.edu";
    }
    
    if([title isEqualToString:@"Student Health Insurance"]){
        email = @"ckoen@carleton.edu";
    }

    if([title isEqualToString:@"Athletics"]){
        email = @"athlete@carleton.edu";
    }
    
    if([title isEqualToString:@"Human Resources"]){
        email = @"hr@carleton.edu";
    }
    
    return [[Contact alloc] initWithTitle:title Phone:phone Fax:fax Email:email];
}

- (NSString *)parseTitleLine:(NSString *)titleLine {
    NSString *title;
    title = [titleLine componentsSeparatedByString:@"</strong>"][0];
    // Some of the titles have subtitles that we are discarding for now
    //NSArray *splitTitleLine = [titleLine componentsSeparatedByString:@"</strong>"];
    //NSString *title = splitTitleLine[0];
    //NSString *subtitle = splitTitleLine[1];
    return title;
}

- (NSString *)parsePhoneNumberFromLine:(NSString *)line withPrefix:(NSString *)prefix{
    //find the fax number for the current Contact
    NSString *phone = nil;
    if ([line hasPrefix:prefix]){
        phone = [line componentsSeparatedByString:@": "][1];
    }
    return phone;
}

- (NSString *)parseEmailLine:(NSString *)emailLine {
    //find the email address for the current Contact
    NSString *email = nil;
    if ([emailLine hasPrefix:@"Email:"]){
        NSArray *splitEmailLine = [BaseNSWDataSource splitString:emailLine
                                            atCharactersInString:@"<>"];
        // The actual email address ends up being the third item in this array
        email = splitEmailLine[2];
    }
    return email;
}


@end
