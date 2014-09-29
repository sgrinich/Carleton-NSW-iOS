//
// Created by Alex Simonides on 5/15/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import "BaseNSWTableViewController.h"
#import "SWRevealViewController.h"
#import "NSWStyle.h"

@interface BaseNSWTableViewController ()
@end

@implementation BaseNSWTableViewController

@synthesize listItems;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.revealButtonItem setTarget: self.revealViewController];
    [self.revealButtonItem setAction: @selector( revealToggle: )];
    [self setNavigationColors];
    
    
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
    self.revealButtonItem.tintColor = [NSWStyle whiteColor];
}

// Called by the DataSource when it's ready to update the VC with its objects
- (void)setVCArrayToDataSourceArray:(NSArray *)dataSourceObjects {
    self.listItems = [[NSMutableArray alloc] initWithArray:dataSourceObjects];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listItems.count;
}

@end