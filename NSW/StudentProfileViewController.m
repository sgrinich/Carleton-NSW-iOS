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
#import <QuartzCore/QuartzCore.h>
#import "Mixpanel.h"

@interface StudentProfileViewController ()

@end

@implementation StudentProfileViewController

@synthesize cellIconNames;
@synthesize imageName;
@synthesize fileName;

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
    [[[DataSourceManager sharedDSManager] getStudentProfileDataSource] attachVCBackref:self];

    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [NSWStyle oceanBlueColor];
    [self.tableView setBackgroundView:view];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    
    
    for(int i=0;i<[self.listItems count];i++){
        imageName = [NSString stringWithFormat:@"%@.jpg", [self.listItems[i] name]];
//        NSLog(@"imagename: %@", imageName);
        
        [cellIconNames addObject:imageName];
    }
    
    self.navigationItem.title = @"SDAs";
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    [self.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];


    

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
//    cell.studentNameLabel.adjustsFontSizeToFitWidth = YES;
//    cell.studentNameLabel.minimumFontSize = 0;
//    
    
    cell.studentMajorLabel.text = [student major];
//    cell.studentMajorLabel.adjustsFontSizeToFitWidth = YES;
//    cell.studentMajorLabel.minimumFontSize = 0;

    imageName = [NSString stringWithFormat:@"%@.jpg", [self.listItems[indexPath.row] name]];
    fileName = [imageName stringByReplacingOccurrencesOfString:@" " withString:@""];

    UIImage *img = [UIImage imageNamed:fileName];
    
    UIImage *scaledimage = [self imageWithImage:img];
    
    cell.studentImageView.layer.cornerRadius = 40;
    cell.studentImageView.layer.masksToBounds = YES;
    [cell.studentImageView sizeToFit];
    [cell.studentImageView setImage:scaledimage];

    
    return cell;
}

-(UIImage *)imageWithImage:(UIImage *)image  {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(80, 80), NO, 0.0);
    // Here pass new size you need
    [image drawInRect:CGRectMake(0, 0, 80, 80)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    return newImage;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    cell.imageView.frame = (CGRect){{0.0f, 0.0f}, 80, 80};
//    cell.imageView.layer.masksToBounds = YES;
//    cell.imageView.layer.cornerRadius = 50;
//}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    StudentSpecialist *student = self.listItems[(NSUInteger) indexPath.row];
    StudentProfileDetailViewController *destViewController = segue.destinationViewController;
    
    Mixpanel *mixpanel = [Mixpanel sharedInstance];


    
    if ([[segue identifier] isEqualToString:@"showProfileDetail"]) {
        
        [mixpanel track:@"SDAs View Controller" properties:@{
                                                             @"SDA Name": [student name]
                                                          }];
        
        destViewController.studentName = [student name];
        destViewController.studentMajor = [student major];
        destViewController.studentBio = [student bio];
        destViewController.studentPhoneNumber = [student number];
        destViewController.studentEmail = [student email];
        
        imageName = [NSString stringWithFormat:@"%@.jpg", [self.listItems[indexPath.row] name]];
        fileName = [imageName stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        destViewController.studentImageName = fileName;
        
        
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
