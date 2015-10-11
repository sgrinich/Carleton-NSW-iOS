//
//  FaqDetailViewController.m
//  NSW
//
//  Created by Stephen Grinich on 7/22/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "FaqDetailViewController.h"
#import "FaqDataSource.h"
#import "FaqItem.h"
#import "FaqTableViewCell.h"
#import "NSWStyle.h"
#import "DataSourceManager.h"
#import "SWRevealViewController.h"

@interface FaqDetailViewController ()

@end

@implementation FaqDetailViewController

@synthesize question;
@synthesize answer;
@synthesize questionLabel;
@synthesize answerTextView;

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

    questionLabel.text = question;
    answerTextView.text = answer;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    answerTextView.layer.borderColor = [UIColor grayColor].CGColor;
    answerTextView.layer.borderWidth = 0.25;
    answerTextView.layer.cornerRadius = 15;
    [answerTextView setTextContainerInset:UIEdgeInsetsMake(8, 10, 8, 10)]; // top, left, bottom, right
    

}


-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar.layer removeAllAnimations];
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
