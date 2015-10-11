//
// Created by Alex Simonides on 5/19/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import "MenuViewController.h"
#import "SWRevealViewController.h"
#import "NSWStyle.h"

@implementation DrawerTableViewCell
@end
@interface MenuViewController ()

@property (nonatomic, strong) NSArray *menuIDs;
@property (nonatomic, strong) NSArray *menuTitles;

@end


@implementation MenuViewController

- (void)viewDidLoad {
    self.tableView.backgroundColor = [NSWStyle darkGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;

    // Add gestures to return to current view by tapping or panning (dragging) the menu away
    [self.revealViewController tapGestureRecognizer];
    [self.revealViewController panGestureRecognizer];

    self.revealViewController.frontViewShadowOffset = CGSizeMake(0, 0);
    self.revealViewController.frontViewShadowOpacity = 0.0f;
    self.revealViewController.frontViewShadowRadius = 0.0f;
    
    self.menuIDs = @[@"events", @"map", @"profiles", @"terms", @"contacts",@"faq"];
    self.menuTitles = @[@"Schedule", @"Campus Map", @"Student Dept. Advisers", @"Speak Carleton", @"Important Contacts",@"FAQ"];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.revealViewController.frontViewController.view setUserInteractionEnabled:NO];

    
}

-(void)viewWillDisappear:(BOOL)animated {
    //[super viewDidDisappear:animated];
    
    [self.revealViewController.frontViewController.view setUserInteractionEnabled:YES];

}
 
 
 
 



// boilerplate preparation for storyboard segues
- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    // configure the destination view controller:

//   //  configure the segue.
//    if ( [segue isKindOfClass: [SWRevealViewControllerSeguePushController class]] )
//    {
//        SWRevealViewControllerSeguePushController *swRevealSegue = (SWRevealViewControllerSeguePushController*) segue;
//
//        SWRevealViewController *revealVC = self.revealViewController;
//        NSAssert( revealVC != nil, @"oops! must have a revealViewController" );
//
//        NSAssert( [revealVC.frontViewController isKindOfClass: [UINavigationController class]], @"oops!  for this segue we want a permanent navigation controller in the front!" );
//
//        swRevealSegue.performBlock = ^(SWRevealViewControllerSeguePushController* revealVCSegue, UIViewController* svc, UIViewController*destinationVC)
//        {
//            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:destinationVC];
//            [revealVC pushFrontViewController:navigationController animated:YES];
//        };
//    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return tableView.rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *headerID = @"MenuHeaderID";
    UITableViewHeaderFooterView *menuHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    if (!menuHeaderView) {
        menuHeaderView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerID];
        menuHeaderView.contentView.backgroundColor = [NSWStyle darkGrayColor]; //[NSWStyle lightBlueColor];
        menuHeaderView.textLabel.text = @"Carleton NSW";
        menuHeaderView.textLabel.textColor = [NSWStyle whiteColor];
        //menuHeaderView.textLabel.font = [NSWStyle boldFont];

    }
    return menuHeaderView;
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CellIdentifier = self.menuIDs[(NSUInteger) indexPath.row];

    DrawerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [NSWStyle darkGrayColor]; //[NSWStyle lightBlueColor];
    cell.textLabel.textColor = [NSWStyle whiteColor];
    cell.textLabel.text = self.menuTitles[(NSUInteger) indexPath.row];
    
    UIView * selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    [selectedBackgroundView setBackgroundColor:[UIColor grayColor]]; // set color here
    [cell setSelectedBackgroundView:selectedBackgroundView];

    return cell;
}


@end