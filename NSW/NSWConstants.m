//
// Created by Alex Simonides on 5/16/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import "NSWConstants.h"


@implementation NSWConstants {

}
//shared date formatter
static NSDateFormatter *dateFormatter;

// Returns the date for a given string 
+ (NSDate *)dateFor:(NSString *)dateString {
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    }
    return [dateFormatter dateFromString:dateString];
}

+ (NSTimeZone *)northfieldTimeZone {
    return [NSTimeZone timeZoneForSecondsFromGMT: -5 * secondsPerHour];
}

+ (NSDate *) firstDayOfNSW {
    return [NSWConstants dateFor:@"08-09-2015"];
}

+ (NSDate *) lastDayOfNSW {
    return [NSWConstants dateFor:@"13-09-2015"];
}


@end