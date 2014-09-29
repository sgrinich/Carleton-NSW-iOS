//
//  CarlTermDetailViewController.m
//  NSW
//
//  Created by Stephen Grinich on 7/8/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "CarlTermDetailViewController.h"
#import "CarlTermDataSource.h"
#import "CarlTerm.h"
#import "CarlTermTableViewCell.h"
#import "NSWStyle.h"
#import "DataSourceManager.h"

@interface CarlTermDetailViewController ()


@property (weak, nonatomic) IBOutlet UITextView *descriptionTextVIew;
@end

@implementation CarlTermDetailViewController

@synthesize termTitle;
@synthesize termName; 
@synthesize termDescription;
@synthesize termDescriptionTextView;

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
    
    
    termTitle.text = termName;
    termDescriptionTextView.text = termDescription;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    termDescriptionTextView.layer.borderColor = [UIColor grayColor].CGColor;
    termDescriptionTextView.layer.borderWidth = 0.25;
    termDescriptionTextView.layer.cornerRadius = 15;
    [termDescriptionTextView setTextContainerInset:UIEdgeInsetsMake(8, 10, 8, 10)]; // top, left, bottom, right



    //Connect this VC to the shared DataSource
    //[[[DataSourceManager sharedDSManager] getCarlTermDataSource] attachVCBackref:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doneButtonPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
