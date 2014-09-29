//
// Created by Alex Simonides on 5/20/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import "MapViewController.h"
#import "SWRevealViewController.h"
#import "NSWStyle.h"

@interface MapViewController ()
@property (nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;
@end

@implementation MapViewController


UIImageView *mapImageView;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIStoryboard *aStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    mapImageView = [aStoryboard instantiateViewControllerWithIdentifier:@"mapImage"];
    
    /**
     // ignore this
    UIPanGestureRecognizer *panTagGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panTagGesture setDelegate:self];
    [mapImageView addGestureRecognizer:panTagGesture];
    
    UIPinchGestureRecognizer *pinchTagGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [pinchTagGesture setDelegate:self];
    [mapImageView addGestureRecognizer:pinchTagGesture];
    **/
    
     self.navigationItem.title = @"Campus Map";
    [self.revealButtonItem setTarget: self.revealViewController];
    [self.revealButtonItem setAction: @selector( revealToggle: )];
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    [self setNavigationColors];
    self.view.backgroundColor = [NSWStyle lightBlueColor];
}



//This is directly lifted from BaseNSWTableViewController, can we put it in an interface or such?
- (void)setNavigationColors{
        UINavigationBar *navBar = self.navigationController.navigationBar;
        navBar.translucent = NO;
        navBar.barTintColor = [NSWStyle lightBlueColor];
        [navBar setTitleTextAttributes:@{
                NSForegroundColorAttributeName : [NSWStyle whiteColor],
                NSFontAttributeName : [NSWStyle boldFont]}];
        UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(popoverArrowDirection)];
        self.navigationItem.backBarButtonItem = barBtnItem;
        //"navBar text color" = [NSWStyle whiteColor];
        self.revealButtonItem.tintColor = [NSWStyle whiteColor];
    }

CGFloat lastScale;

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer {
    if([recognizer state] == UIGestureRecognizerStateBegan) {
        // Reset the last scale, necessary if there are multiple objects with different scales
        lastScale = [recognizer scale];
    }
    
    if ([recognizer state] == UIGestureRecognizerStateBegan ||
        [recognizer state] == UIGestureRecognizerStateChanged) {
        
        CGFloat currentScale = [[[recognizer view].layer valueForKeyPath:@"transform.scale"] floatValue];
        
        // Constants to adjust the max/min values of zoom
        const CGFloat kMaxScale = 3.0;
        const CGFloat kMinScale = 1.0;
        
        CGFloat newScale = 1 -  (lastScale - [recognizer scale]); // new scale is in the range (0-1)
        newScale = MIN(newScale, kMaxScale / currentScale);
        newScale = MAX(newScale, kMinScale / currentScale);
        CGAffineTransform transform = CGAffineTransformScale([[recognizer view] transform], newScale, newScale);
        [recognizer view].transform = transform;
        
        lastScale = [recognizer scale];  // Store the previous scale factor for the next pinch gesture call
    }
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];

    
}

@end