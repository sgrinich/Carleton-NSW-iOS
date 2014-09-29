//
//  EventDataSource.h
//  NSW
//
//  Created by Stephen Grinich on 5/9/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventListViewController.h"
#import "BaseNSWDataSource.h"

@interface EventDataSource : BaseNSWDataSource {
}

@property NSMutableArray *fullEventList;

-(void)getEventsForDate:(NSDate *) currentDate;
+(NSDate *)oneDayBefore:(NSDate *) currentDate;
+(NSDate *)oneDayAfter:(NSDate *) currentDate;

- (NSDate *)parseDateTimeFromICSString:(NSString *)rawStartDateTime;

@end
