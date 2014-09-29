//
// Created by Alex Simonides on 5/16/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSWConstants : NSObject

//Time Constants: NSTimeInterval are a double of seconds, so we want to be able to easily convert to seconds
typedef enum {
    secondsPerMinute = 60,
    secondsPerHour = 3600,
    secondsPerDay = 86400, // = 60 * 60 * 24
} secondsPer;

+(NSTimeZone *)northfieldTimeZone;
+(NSDate *) firstDayOfNSW;
+(NSDate *) lastDayOfNSW;

@end