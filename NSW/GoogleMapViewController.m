//
//  GoogleMapViewController.m
//  NSW
//
//  Created by Lab User on 6/3/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "GoogleMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "SWRevealViewController.h"
#import "NSWStyle.h"
#import "MapLocationsTableViewController.h"

@interface GoogleMapViewController ()
@property (strong, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIView *viewLeftDummy;
@property (nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;
@end

@implementation GoogleMapViewController{
    GMSMapView *mapView_;
    GMSMarker *marker_;
    GMSCameraPosition *cameraPosition_;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIStoryboard *aStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    marker_ = nil;
    mapView_ = [aStoryboard instantiateViewControllerWithIdentifier:@"gMap"];
    
    
    cameraPosition_ = [GMSCameraPosition cameraWithLatitude:44.461
                                                            longitude:-93.1546
                                                                 zoom:17];
    int width = [UIScreen mainScreen].bounds.size.width;
    int height = [UIScreen mainScreen].bounds.size.height;
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 0, width,height) camera:cameraPosition_];
    mapView_.myLocationEnabled = YES;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(buttonTouched)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Looking for something?" forState:UIControlStateNormal];
    button.layer.cornerRadius = 10;
    button.clipsToBounds = YES;
    [button setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [button sizeToFit];
    button.frame = CGRectMake(30, height-120, width-60, 35);
    [button setBackgroundColor:[NSWStyle oceanBlueColor]];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:18];
    
    [self.view insertSubview:button atIndex:1];
    [self.view insertSubview:mapView_ atIndex:0];
    [self.view bringSubviewToFront:_viewContainer];
    self.navigationItem.title = @"Campus Map";
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

        mapView_.settings.consumesGesturesInView = NO;

    }
    
//    [_viewContainer bringSubviewToFront:_viewLeftDummy];
    self.view.userInteractionEnabled = YES;
    
    
    


    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];

    
    
  //  [_viewContainer bringSubviewToFront:_viewLeftDummy];

    [self setNavigationColors];
    
	
}







- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)buttonTouched{
    
    
    UIStoryboard *sboard = [UIStoryboard storyboardWithName:@"Main"
                                                     bundle:nil];
    MapLocationsTableViewController *mapChoiceController = [sboard instantiateViewControllerWithIdentifier:@"MapChoiceController"];
    
    mapChoiceController.delegate = self;
    [[self navigationController] presentModalViewController:mapChoiceController animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES animated:YES];

}

- (void)addItemViewController:(MapLocationsTableViewController *)controller didFinishEnteringItem:(MapLocation *)locationObject
{
    
    marker_ = [[GMSMarker alloc]init];
    marker_ = [locationObject coordinates];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
    
    [mapView_ clear];
    
    marker_.map = mapView_;
    cameraPosition_ = [GMSCameraPosition cameraWithTarget:marker_.position zoom:17];
    
    if (marker_ != nil) {
        // can I make this better?
        [mapView_ animateToCameraPosition:cameraPosition_];
        [mapView_ setSelectedMarker:marker_];
    }
    
}



//This is directly lifted from BaseNSWTableViewController, can we put it in an interface or such?
- (void)setNavigationColors{
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.translucent = NO;
    navBar.barTintColor = [NSWStyle oceanBlueColor];
    [navBar setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName : [NSWStyle whiteColor],
                                     NSFontAttributeName : [NSWStyle boldFont]}];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(popoverArrowDirection)];
    self.navigationItem.backBarButtonItem = barBtnItem;
    //"navBar text color" = [NSWStyle whiteColor];
    self.revealButtonItem.tintColor = [NSWStyle whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
