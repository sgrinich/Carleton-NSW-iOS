//
//  NSWEvent.m
//  NSW
//
//  Created by Alex Simonides on 5/10/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "NSWEvent.h"


@implementation NSWEvent
@synthesize calendarID;
@synthesize title;
@synthesize theDescription;
@synthesize location;
@synthesize startDateTime;
@synthesize duration;

- (id)init {
    self = [super init];
    if (self) {
        // initialization happens here.
    }
    
    return self;
}

-(id)initWithID:(NSString *) id_
          Title:(NSString *)title_
    Description:(NSString *)desc_
       Location:(NSString *)location_
          Start:(NSDate *)start_
       Duration:(NSTimeInterval)duration_
{
    self = [super init];
    if (self) {
        self.calendarID = id_;
        self.title = title_;
        self.theDescription = desc_;
        self.location = location_;
        self.startDateTime = start_;
        self.startDateComponents = [NSWEvent getDateComponentsFromDate:start_];
        self.duration = duration_;
        self.endDateTime = [self setEndDateTime];
    }
    return self;
}

// This is a built-in function that's called when you try print an NSWEvent (like toString() in Java)
-(NSString *) description {
    return [NSString stringWithFormat: @"NSWEvent: Title=%@, Description=%@, Location=%@, Start=%@, Duration=%f seconds.",
                    title, theDescription, location, startDateTime, duration];
}

+(NSDateComponents *)getDateComponentsFromDate:(NSDate *) date{
    NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;

    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal components:unitFlags fromDate:date];
    return comps;
}


-(NSDate *) setEndDateTime{
    return [NSDate dateWithTimeInterval:duration sinceDate:startDateTime];
}


@end
