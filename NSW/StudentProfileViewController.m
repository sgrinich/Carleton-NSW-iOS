//
//  StudentProfileViewController.m
//  Carleton NSW
//
//  Created by Stephen Grinich on 7/18/15.
//  Copyright (c) 2015 BTIN. All rights reserved.
//

#import "BaseNSWTableViewController.h"
#import "DataSourceManager.h"
#import "StudentProfileViewController.h"
#import "SWRevealViewController.h"
#import "StudentProfileTableViewCell.h"
#import "StudentSpecialist.h"
#import "StudentProfileDataSource.h"
#import "NSWStyle.h"
#import "StudentProfileDetailViewController.h"

@interface StudentProfileViewController ()

@end

@implementation StudentProfileViewController



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Student Profiles";
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    [self.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];


    [[[DataSourceManager sharedDSManager] getStudentProfileDataSource] attachVCBackref:self];
    

}

//-(void)viewWillAppear:(BOOL)animated{
//    [self.tableView reloadData];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    
//    return [self.listItems count];
//    
//}


- (StudentProfileTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    StudentProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    StudentSpecialist *student = self.listItems[(NSUInteger) indexPath.row];
    cell.studentNameLabel.text = [student name];
    cell.studentMajorLabel.text = [student major];

    
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    StudentSpecialist *student = self.listItems[(NSUInteger) indexPath.row];
    StudentProfileDetailViewController *destViewController = segue.destinationViewController;
    
    if ([[segue identifier] isEqualToString:@"showProfileDetail"]) {
        
        destViewController.studentName = [student name];
        destViewController.studentMajor = [student major];
        destViewController.studentBio = [student bio];
        destViewController.studentPhoneNumber = [student number];
        destViewController.studentEmail = [student email]; 
        
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
