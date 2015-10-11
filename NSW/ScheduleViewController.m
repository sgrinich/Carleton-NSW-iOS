//
//  ScheduleViewController.m
//  Carleton NSW
//
//  Created by Stephen Grinich on 8/9/15.
//  Copyright (c) 2015 BTIN. All rights reserved.
//

#import "ScheduleViewController.h"
#import "ADPageControl.h"
#import "NSWStyle.h"
#import "SWRevealViewController.h"
#import "DayViewController.h"
#import "DataSourceManager.h"
#import "EventTableViewCell.h"
#import "EventDataSource.h"
#import "NSWEvent.h"
#import "KLCPopup.h"
#import "EventDetailViewController.h"


@interface ScheduleViewController ()<ADPageControlDelegate> 
{
    ADPageControl *_pageControl;
    NSDate *currentDate;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealSideBar;
@property UILocalNotification *localNotification;



@end

@implementation ScheduleViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:9];
    [comps setMonth:9];
    [comps setYear:2015];
    [comps setHour:16];
    [comps setMinute:0];
    [comps setSecond:0];
    [comps setTimeZone:[NSTimeZone defaultTimeZone]];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *timeToFire= [gregorian dateFromComponents:comps];
    NSDate *now = [NSDate date];

    if([now compare:timeToFire] ==  NSOrderedAscending){
        self.localNotification = [[UILocalNotification alloc] init];
        self.localNotification.timeZone = [NSTimeZone defaultTimeZone];
        self.localNotification.alertBody = [NSString stringWithFormat:@"Have you signed up yet for the CLA+ exam?  90 minutes; $35; a chance to compare your reasoning skills to thousands of college students across the country.  Limited to the first 250 students who sign up.  What are you waiting for?"];
        self.localNotification.fireDate = timeToFire;
        self.localNotification.soundName = @"notify.wav";
        [[UIApplication sharedApplication] scheduleLocalNotification:self.localNotification];
    }
    
    NSDateComponents *startDateComps = [[NSDateComponents alloc] init];
    [startDateComps setDay:8];
    [startDateComps setMonth:9];
    [startDateComps setYear:2015];
    NSDate *startDate = [gregorian dateFromComponents:startDateComps];
    
    NSDateComponents *endDateComps = [[NSDateComponents alloc] init];
    [endDateComps setDay:13];
    [endDateComps setMonth:9];
    [endDateComps setYear:2015];
    NSDate *endDate = [gregorian dateFromComponents:endDateComps];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    NSDate *today = [calendar dateFromComponents:components];
    
    if (([startDate compare:today] == NSOrderedAscending) && ([endDate compare:today] == NSOrderedDescending)) {
        currentDate = today;
    }
    
    else{
        currentDate = startDate;
    }
    
    
        
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    
    [self displayDirectionsIfNewUser];

    self.view.backgroundColor =[NSWStyle oceanBlueColor];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealSideBar setTarget: self.revealViewController];
        [self.revealSideBar setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        
    }
    
    [self setNavigationColors];
    [self setupPageControl];
    
    
    
    
}

- (void) setupExamNotification{
  
    
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


-(void)setupPageControl{
    
    NSDateComponents *compsTues = [[NSDateComponents alloc] init];
    [compsTues setDay:8];
    [compsTues setMonth:9];
    [compsTues setYear:2015];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *tuesday = [gregorian dateFromComponents:compsTues];
    
    NSDateComponents *compsWed = [[NSDateComponents alloc] init];
    [compsWed setDay:9];
    [compsWed setMonth:9];
    [compsWed setYear:2015];
    NSDate *wednesday = [gregorian dateFromComponents:compsWed];
    
    NSDateComponents *compsTh = [[NSDateComponents alloc] init];
    [compsTh setDay:10];
    [compsTh setMonth:9];
    [compsTh setYear:2015];
    NSDate *thursday = [gregorian dateFromComponents:compsTh];
    
    NSDateComponents *compsFr = [[NSDateComponents alloc] init];
    [compsFr setDay:11];
    [compsFr setMonth:9];
    [compsFr setYear:2015];
    NSDate *friday = [gregorian dateFromComponents:compsFr];
    
    NSDateComponents *compsSat = [[NSDateComponents alloc] init];
    [compsSat setDay:12];
    [compsSat setMonth:9];
    [compsSat setYear:2015];
    NSDate *saturday = [gregorian dateFromComponents:compsSat];
    
    NSDateComponents *compsSun = [[NSDateComponents alloc] init];
    [compsSun setDay:13];
    [compsSun setMonth:9];
    [compsSun setYear:2015];
    NSDate *sunday = [gregorian dateFromComponents:compsSun];

    
    ADPageModel *pageModelTuesday= [[ADPageModel alloc] init];
    DayViewController *tuesdayViewController = [[DayViewController alloc] initWithDate:tuesday];
    tuesdayViewController.delegate = self;
    pageModelTuesday.strPageTitle = @"Tuesday";
    pageModelTuesday.iPageNumber = 0;
    pageModelTuesday.viewController = tuesdayViewController;
    
    
    //wednesday
    ADPageModel *pageModelWednesday = [[ADPageModel alloc] init];
    DayViewController *wednesdayViewController = [[DayViewController alloc] initWithDate:wednesday];
    wednesdayViewController.delegate = self;
    pageModelWednesday.strPageTitle = @"Wednesday";
    pageModelWednesday.iPageNumber = 1;
    pageModelWednesday.viewController = wednesdayViewController;
    
    //thursday
    ADPageModel *pageModelThursday = [[ADPageModel alloc] init];
    DayViewController *thursdayViewController = [[DayViewController alloc] initWithDate:thursday];
    thursdayViewController.delegate = self;
    pageModelThursday.strPageTitle = @"Thursday";
    pageModelThursday.iPageNumber = 2;
    pageModelThursday.viewController = thursdayViewController;
    
    //friday
    ADPageModel *pageModelFriday = [[ADPageModel alloc] init];
    DayViewController *fridayViewController = [[DayViewController alloc] initWithDate:friday];
    fridayViewController.delegate = self;
    pageModelFriday.strPageTitle = @"Friday";
    pageModelFriday.iPageNumber = 3;
    pageModelFriday.viewController = fridayViewController;
    
    //saturday
    ADPageModel *pageModelSaturday = [[ADPageModel alloc] init];
    DayViewController *saturdayViewController = [[DayViewController alloc] initWithDate:saturday];
    saturdayViewController.delegate = self;
    pageModelSaturday.strPageTitle = @"Saturday";
    pageModelSaturday.iPageNumber = 4;
    pageModelSaturday.viewController = saturdayViewController;
    
    //sunday
    ADPageModel *pageModelSunday = [[ADPageModel alloc] init];
    DayViewController *sundayViewController = [[DayViewController alloc] initWithDate:sunday];
    sundayViewController.delegate = self;
    pageModelSunday.strPageTitle = @"Sunday";
    pageModelSunday.iPageNumber = 5;
    pageModelSunday.viewController = sundayViewController;
    
    
    /**** 2. Initialize page control ****/
    
    _pageControl = [[ADPageControl alloc] init];
    _pageControl.delegateADPageControl = self;
    _pageControl.arrPageModel = [[NSMutableArray alloc] initWithObjects:pageModelTuesday,pageModelWednesday,pageModelThursday,pageModelFriday, pageModelSaturday, pageModelSunday, nil];
    
    /**** 3. Customize parameters (Optinal, as all have default value set) ****/
    
    
    // do stuff with first date here
    

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *dayOfWeek = [[dateFormatter stringFromDate:currentDate] lowercaseString];
    NSLog(dayOfWeek);
    
    
    if([dayOfWeek isEqualToString:@"tuesday"]){
        _pageControl.iFirstVisiblePageNumber = 0;
    }
    
    if([dayOfWeek isEqualToString:@"wednesday"]){
        _pageControl.iFirstVisiblePageNumber = 1;
    }
    
    if([dayOfWeek isEqualToString:@"thursday"]){
        _pageControl.iFirstVisiblePageNumber = 2;
    }
    
    if([dayOfWeek isEqualToString:@"friday"]){
        _pageControl.iFirstVisiblePageNumber = 3;
    }
    
    if([dayOfWeek isEqualToString:@"saturday"]){
        _pageControl.iFirstVisiblePageNumber = 4;
    }
    
    if([dayOfWeek isEqualToString:@"sunday"]){
        _pageControl.iFirstVisiblePageNumber = 5;
    }

    
    
    

    _pageControl.iTitleViewHeight = 40;
    _pageControl.iPageIndicatorHeight = 4;
    _pageControl.fontTitleTabText =  [UIFont fontWithName:@"Helvetica" size:16];
    
    _pageControl.bEnablePagesEndBounceEffect = YES;
    _pageControl.bEnableTitlesEndBounceEffect = YES;
    
    _pageControl.colorTabText = [UIColor whiteColor];
    _pageControl.colorTitleBarBackground = [NSWStyle oceanBlueColor];
    _pageControl.colorPageIndicator = [UIColor whiteColor];
    _pageControl.colorPageOverscrollBackground = [UIColor lightGrayColor];
    
    _pageControl.bShowMoreTabAvailableIndicator = NO;
    
    /**** 3. Add as subview ****/
    int navHeight = self.navigationController.navigationBar.frame.size.height;
    NSLog(@"nav height is: %d", navHeight);
    _pageControl.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:_pageControl.view];
    
}

// Checks the user defaults and shows directions if this is a first user
-(void)displayDirectionsIfNewUser {
    NSString *returningUserKey = @"returning user";
    //[NSUserDefaults resetStandardUserDefaults];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isReturningUser = [userDefaults boolForKey:returningUserKey];
    if (!isReturningUser) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome to Carleton!"
                                                        message:@"Swipe left or right on this screen to view events for different days. NSW begins on Tuesday and ends on Sunday. \n\n Please wait while your schedule is downloaded... "
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        [userDefaults setBool:YES forKey:returningUserKey];
    } else {
        //[userDefaults setBool:NO forKey:returningUserKey];
    }
}


- (void)addItemViewController:(DayViewController *)controller didFinishEnteringItem:(NSWEvent *)event
{
    
    NSLog((@"Schedule View Controller, additemviewcontroller"));
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController* vc = [sb instantiateViewControllerWithIdentifier:@"MedStaffDetailViewController"];
    
    EventDetailViewController *destController = [sb instantiateViewControllerWithIdentifier:@"eventDetailViewController"];

    destController.detailItem = event;
    
  //  EventDetailViewController *destController = [[self.storyboard instantiateViewControllerWithIdentifier:@"eventDetailViewController"] initWithEvent:event];
       [self.navigationController pushViewController:destController animated:YES];
    

    
    
}

// Set the colors for the navigation bar
-(void)setNavigationColors{
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.translucent = NO;
    navBar.barTintColor = [NSWStyle oceanBlueColor];
    [navBar setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName : [NSWStyle whiteColor],
                                     NSFontAttributeName : [NSWStyle boldFont]}];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(popoverArrowDirection)];
    self.navigationItem.backBarButtonItem = barBtnItem;
    //"navBar text color" = [NSWStyle whiteColor];
    self.revealSideBar.tintColor = [NSWStyle whiteColor];
    
  
}


#pragma mark - ADPageControlDelegate

//LAZY LOADING

-(UIViewController *)adPageControlGetViewControllerForPageModel:(ADPageModel *) pageModel
{
    NSLog(@"ADPageControl :: Lazy load asking for page %d",pageModel.iPageNumber);
    

//    if(pageModel.iPageNumber == 1)
//    {
//        
//
//        
//        DayViewController *wednesdayViewController = [[DayViewController alloc] initWithDate:wednesday];
//        //UITableViewController *wednesdayView = [[UITableViewController alloc] init];
//        return wednesdayViewController;
//    }
//    else if(pageModel.iPageNumber == 2)
//    {
//        NSDateComponents *comps = [[NSDateComponents alloc] init];
//        [comps setDay:9];
//        [comps setMonth:9];
//        [comps setYear:2015];
//        NSCalendar *gregorian = [[NSCalendar alloc]
//                                 initWithCalendarIdentifier:NSGregorianCalendar];
//        NSDate *thursday = [gregorian dateFromComponents:comps];
//        
//        DayViewController *thursdayViewController = [[DayViewController alloc] initWithDate:thursday];
//        //UITableViewController *thursdayView = [[UITableViewController alloc] init];
//        return thursdayViewController;
//    }
//    else if(pageModel.iPageNumber == 3)
//    {
//        NSDateComponents *comps = [[NSDateComponents alloc] init];
//        [comps setDay:10];
//        [comps setMonth:9];
//        [comps setYear:2015];
//        NSCalendar *gregorian = [[NSCalendar alloc]
//                                 initWithCalendarIdentifier:NSGregorianCalendar];
//        NSDate *friday = [gregorian dateFromComponents:comps];
//        
//        DayViewController *fridayViewController = [[DayViewController alloc] initWithDate:friday];
//        //UITableViewController *fridayView = [[UITableViewController alloc] init];
//        return fridayViewController;
//    }
//    else if(pageModel.iPageNumber == 4)
//    {
//        NSDateComponents *comps = [[NSDateComponents alloc] init];
//        [comps setDay:11];
//        [comps setMonth:9];
//        [comps setYear:2015];
//        NSCalendar *gregorian = [[NSCalendar alloc]
//                                 initWithCalendarIdentifier:NSGregorianCalendar];
//        NSDate *saturday = [gregorian dateFromComponents:comps];
//        
//        DayViewController *saturdayViewController = [[DayViewController alloc] initWithDate:saturday];
//        //UITableViewController *saturdayView = [[UITableViewController alloc] init];
//        return saturdayViewController;
//    }
//    else if(pageModel.iPageNumber == 5)
//    {
//        NSDateComponents *comps = [[NSDateComponents alloc] init];
//        [comps setDay:12];
//        [comps setMonth:9];
//        [comps setYear:2015];
//        NSCalendar *gregorian = [[NSCalendar alloc]
//                                 initWithCalendarIdentifier:NSGregorianCalendar];
//        NSDate *sunday = [gregorian dateFromComponents:comps];
//        
//        DayViewController *sundayViewController = [[DayViewController alloc] initWithDate:sunday];
//       // UITableViewController *sundayView = [[UITableViewController alloc]init];
//        return sundayViewController;
    //}
    
    return nil;
}




-(void)adPageControlCurrentVisiblePageIndex:(int) iCurrentVisiblePage
{
    NSLog(@"ADPageControl :: Current visible page index : %d",iCurrentVisiblePage);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
