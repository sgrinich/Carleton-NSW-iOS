//
//  DayViewController.m
//  Carleton NSW
//
//  Created by Stephen Grinich on 8/11/15.
//  Copyright (c) 2015 BTIN. All rights reserved.
//

#import "DayViewController.h"
#import "DataSourceManager.h"
#import "EventTableViewCell.h"
#import "EventDataSource.h"
#import "NSWEvent.h"
#import "NSWStyle.h"
#import  "QuartzCore/QuartzCore.h"
#import "EventDetailViewController.h"
#import "AppDelegate.h"
#import "KLCPopup.h"
#import "ScheduleViewController.h"



@interface DayViewController ()<UINavigationControllerDelegate>{
    EventDataSource *myEventDS;
    NSDate *currentDate;
}

@end


@implementation DayViewController

@synthesize delegate;


- (id)initWithDate:(NSDate *)day
{
    if(self = [super init]) {
        currentDate = day;
    }
    return self;
}

-(void)viewDidLoad{
    
    
    self.view.backgroundColor =[NSWStyle oceanBlueColor];
    self.parentViewController.view.backgroundColor = [NSWStyle oceanBlueColor];
    self.tableView.layer.borderWidth = 4.0;
    self.tableView.layer.cornerRadius = 15.0;
    self.tableView.layer.borderColor = [NSWStyle oceanBlueColor].CGColor;
   // [self.tableView setContentInset:UIEdgeInsetsMake(15,0,0,0)];
    
    myEventDS = [[DataSourceManager sharedDSManager] getEventDataSource];
    
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    [comps setDay:8];
//    [comps setMonth:9];
//    [comps setYear:2015];
//    NSCalendar *gregorian = [[NSCalendar alloc]
//                             initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDate *startDate = [gregorian dateFromComponents:comps];
//    
//    NSDateComponents *comps2 = [[NSDateComponents alloc] init];
//    [comps2 setDay:14];
//    [comps2 setMonth:9];
//    [comps2 setYear:2015];
//    NSDate *endDate = [gregorian dateFromComponents:comps2];
//    
//    NSDate *now = [NSDate date];
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
//    NSDate *today = [calendar dateFromComponents:components];
//    
//    if (([startDate compare:today] == NSOrderedAscending) && ([endDate compare:today] == NSOrderedDescending)) {
//        currentDate = today;
//    }
//    
//    else{
//        currentDate = startDate;
//    }
//    
//
    [myEventDS attachVCBackref:self];
    [self getEventsFromCurrentDate];

    

    
}

// Called by the DataSource when it's ready to update the VC with its objects
- (void)setVCArrayToDataSourceArray:(NSArray *)dataSourceObjects {
    self.listItems = [[NSMutableArray alloc] initWithArray:dataSourceObjects];
    [self.tableView reloadData];
}

// Updates the event list to the events for currentDate
-(void)getEventsFromCurrentDate {
    [myEventDS getEventsForDate:currentDate];
}



- (EventTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" ];
    EventTableViewCell *cell = [[EventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    

    NSWEvent *event = self.listItems[(NSUInteger) indexPath.row];
    NSDateFormatter *time = [[NSDateFormatter alloc] init];
    [time setDateFormat:@"hh:mm a"];
    NSString *startTime = [time stringFromDate:event.startDateTime];
    NSString *endTime = [time stringFromDate:event.endDateTime];
    
    if ([[startTime substringToIndex:1] isEqualToString:@"0"]){
        startTime = [startTime substringFromIndex:1];
    }
    
    if ([[endTime substringToIndex:1] isEqualToString:@"0"]){
        endTime = [endTime substringFromIndex:1];
    }
    
    // Removes end time if start time and end time are the same. Also adds hyphen accordingly.
    NSString *startEnd;
    if ([startTime isEqualToString:endTime]) {
        endTime = @"";
        startEnd = startTime;
    }
    else{
        startEnd = [NSString stringWithFormat:@"%@ - %@", startTime, endTime];
    }
    
    cell.eventTimeLabel.text = startEnd;
    cell.eventTimeLabel.textColor = [NSWStyle darkBlueColor];
    
    // Remove "NSW: " from event title
    NSString *eventNameString = [event title];
    NSString *eventNameStringFirstFourChars = [eventNameString substringToIndex:5];
    if([eventNameStringFirstFourChars  isEqual: @"NSW: "]){
        eventNameString = [eventNameString substringFromIndex:5];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.eventNameLabel.text = eventNameString;
    cell.eventNameLabel.textColor = [NSWStyle darkBlueColor];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSWEvent *event = self.listItems[(NSUInteger) indexPath.row];
    
//    UIView* contentView = [self getEventView:object];
//    KLCPopup* popup = [KLCPopup popupWithContentView:contentView];
//    [popup show];
//    EventDetailViewController *destController = [[self.storyboard instantiateViewControllerWithIdentifier:@"eventDetailViewController"] initWithEvent:object];
//    [self.navigationController pushViewController:destController animated:YES];
//    
    
    id <DayViewControllerDelegate> strongDelegate = self.delegate;

    [self.delegate addItemViewController:self didFinishEnteringItem:event];

    
   // UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:destController];
    
//       UINavigationController *navController=[[UINavigationController alloc] init];
//    [navController pushViewController:destController animated:YES];


}

-(UIView *)getEventView:(NSWEvent *)event{
    UIView* eventView = [[UIView alloc] init];
    
    eventView.backgroundColor = [NSWStyle grayColor];
    eventView.layer.cornerRadius = 20;
    
    //NSLog(@"width: %f",self.view.frame.size.width);
    eventView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width - 40, self.view.frame.size.height - 103);
    
    UILabel *eventName = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, eventView.frame.size.width - 10, 40)];
    eventName.numberOfLines = 2;
    eventName.font = [UIFont fontWithName:@"Helvetica" size:24];
    eventName.textColor = [NSWStyle darkBlueColor];
    eventName.textAlignment = NSTextAlignmentCenter;
    
    UILabel *eventDescription = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 300, 20)];
    UILabel *startTimeDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 300, 20)];
  
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat:@"hh:mm a"];
    
    NSString *startDateTimeString = [dateFormatter stringFromDate:[event startDateTime]];
    NSDate *startDateTime = [event startDateTime];
    NSDate *endDateTime = [event endDateTime];
    
    // Remove "NSW: " from event title
    NSString *eventNameString = [event title];
    NSString *eventNameStringFirstFourChars = [eventNameString substringToIndex:5];
    if([eventNameStringFirstFourChars  isEqual: @"NSW: "]){
        eventNameString = [eventNameString substringFromIndex:5];
    }
    eventName.text = eventNameString;

    
    [eventDescription setText:[event theDescription]];
    
    NSTimeInterval descriptionNumber = [event duration];
    int descriptionInteger = (int) descriptionNumber;
    descriptionInteger = descriptionInteger/60;
    
    NSDate* newDate = [startDateTime dateByAddingTimeInterval:descriptionNumber];
    NSString *newDateString = [dateFormatter stringFromDate:newDate];
    NSString *dash = @" – ";
    
    // Turns "08:00am" to "8:00am"
    if(![startDateTime isEqualToDate:endDateTime]){
        
        if ([startDateTimeString hasPrefix:@"0"]) {
            startDateTimeString = [startDateTimeString substringFromIndex:1];
        }
        
        if ([newDateString hasPrefix:@"0"]) {
            newDateString = [newDateString substringFromIndex:1];
        }
        
        startTimeDescriptionLabel.text = [NSString stringWithFormat:@"%@ %@ %@", startDateTimeString, dash, newDateString];
    }
    
    else{
        startTimeDescriptionLabel.text = [dateFormatter stringFromDate:startDateTime];
        if ([startTimeDescriptionLabel.text hasPrefix:@"0"]) {
            startTimeDescriptionLabel.text = [startTimeDescriptionLabel.text substringFromIndex:1];
        }
    }

    
    [eventView addSubview:eventName];
    [eventView addSubview:eventDescription];
    [eventView addSubview:startTimeDescriptionLabel];
    return eventView;
}







@end
