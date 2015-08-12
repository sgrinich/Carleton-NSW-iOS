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

@interface ScheduleViewController ()<ADPageControlDelegate>
{
    ADPageControl *_pageControl;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealSideBar;

@end

@implementation ScheduleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


-(void)setupPageControl{
    
    //tuesday
    ADPageModel *pageModelTuesday= [[ADPageModel alloc] init];
    DayViewController *tuesday = [[DayViewController alloc] initWithDay:@"tuesday"];
    tuesday.view.backgroundColor = [UIColor colorWithRed:1 green:204.0/255 blue:204.0/255.0 alpha:1.0];//Light Red
    pageModelTuesday.strPageTitle = @"Tuesday";
    pageModelTuesday.iPageNumber = 0;
    pageModelTuesday.viewController = tuesday;//You can provide view controller in prior OR use flag "bShouldLazyLoad" to load only when required
    
    //wednesday
    ADPageModel *pageModelWednesday = [[ADPageModel alloc] init];
    pageModelWednesday.strPageTitle = @"Wednesday";
    pageModelWednesday.iPageNumber = 1;
    pageModelWednesday.bShouldLazyLoad = YES;
    
    //thursday
    ADPageModel *pageModelThursday = [[ADPageModel alloc] init];
    pageModelThursday.strPageTitle = @"Thursday";
    pageModelThursday.iPageNumber = 2;
    pageModelThursday.bShouldLazyLoad = YES;
    
    //friday
    ADPageModel *pageModelFriday = [[ADPageModel alloc] init];
    pageModelFriday.strPageTitle = @"Friday";
    pageModelFriday.iPageNumber = 3;
    pageModelFriday.bShouldLazyLoad = YES;
    
    //saturday
    ADPageModel *pageModelSaturday = [[ADPageModel alloc] init];
    pageModelSaturday.strPageTitle = @"Saturday";
    pageModelSaturday.iPageNumber = 4;
    pageModelSaturday.bShouldLazyLoad = YES;
    
    //sunday
    ADPageModel *pageModelSunday = [[ADPageModel alloc] init];
    pageModelSunday.strPageTitle = @"Sunday";
    pageModelSunday.iPageNumber = 5;
    pageModelSunday.bShouldLazyLoad = YES;
    
    
    /**** 2. Initialize page control ****/
    
    _pageControl = [[ADPageControl alloc] init];
    _pageControl.delegateADPageControl = self;
    _pageControl.arrPageModel = [[NSMutableArray alloc] initWithObjects:pageModelTuesday,pageModelWednesday,pageModelThursday,pageModelFriday, pageModelSaturday, pageModelSunday, nil];
    
    /**** 3. Customize parameters (Optinal, as all have default value set) ****/
    
    _pageControl.iFirstVisiblePageNumber = 1;

    _pageControl.iTitleViewHeight = 40;
    _pageControl.iPageIndicatorHeight = 4;
    _pageControl.fontTitleTabText =  [UIFont fontWithName:@"Helvetica" size:16];
    
    _pageControl.bEnablePagesEndBounceEffect = NO;
    _pageControl.bEnableTitlesEndBounceEffect = NO;
    
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
    

    if(pageModel.iPageNumber == 1)
    {
        DayViewController *wednesday = [[DayViewController alloc] initWithDay:@"wednesday"];
        
        return wednesday;
    }
    else if(pageModel.iPageNumber == 2)
    {
        DayViewController *thursday = [[DayViewController alloc] initWithDay:@"thursday"];
        
        return thursday;
    }
    else if(pageModel.iPageNumber == 3)
    {
        DayViewController *friday = [[DayViewController alloc] initWithDay:@"friday"];
        
        return friday;
    }
    else if(pageModel.iPageNumber == 4)
    {
        DayViewController *saturday = [[DayViewController alloc] initWithDay:@"saturday"];
        
        return saturday;
    }
    else if(pageModel.iPageNumber == 5)
    {
        UIViewController *sunday = [UIViewController new];
        
        return sunday;
    }
    
    return nil;
}

//CURRENT PAGE INDEX

-(void)adPageControlCurrentVisiblePageIndex:(int) iCurrentVisiblePage
{
    NSLog(@"ADPageControl :: Current visible page index : %d",iCurrentVisiblePage);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
