//
//  DayViewController.h
//  Carleton NSW
//
//  Created by Stephen Grinich on 8/11/15.
//  Copyright (c) 2015 BTIN. All rights reserved.
//

#import "BaseNSWTableViewController.h"
#import "NSWEvent.h"


@protocol DayViewControllerDelegate;

@interface DayViewController : UITableViewController{
    NSString* day;
}


@property NSMutableArray *listItems;

-(void)setVCArrayToDataSourceArray:(NSArray *)dataSourceEventList;
- (id)initWithDate:(NSDate *)date;
-(void)getEventsFromCurrentDate;

@property (nonatomic, weak) id <DayViewControllerDelegate> delegate;


@end

@protocol DayViewControllerDelegate <NSObject>
- (void)addItemViewController:(DayViewController *)controller didFinishEnteringItem:(NSWEvent *)event;
@end


