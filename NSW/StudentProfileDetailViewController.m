//
//  StudentProfileDetailViewController.m
//  Carleton NSW
//
//  Created by Stephen Grinich on 7/30/15.
//  Copyright (c) 2015 BTIN. All rights reserved.
//

#import "StudentProfileDetailViewController.h"
#import "StudentSpecialist.h"
#import "NSWStyle.h"
#import "DataSourceManager.h"
#import <MessageUI/MessageUI.h>
#import "Mixpanel.h"



@implementation StudentProfileDetailViewController 

@synthesize studentName;
@synthesize studentMajor;
@synthesize studentBio;
@synthesize studentPhoneNumber;
@synthesize studentEmail;
@synthesize studentImageName;

@synthesize studentImage;
@synthesize studentNameLabel;
@synthesize studentMajorLabel;
@synthesize studentBioTextview;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
 
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    
    self.navigationItem.title = @"SDA";

    studentNameLabel.text = studentName;
    studentMajorLabel.text = studentMajor;
    studentBioTextview.text = studentBio;
    
    UIImage *img = [UIImage imageNamed:studentImageName];
    
    UIImage *scaledimage = [self imageWithImage:img];
    
    

    [studentImage sizeToFit];
    [studentImage setImage:scaledimage];
    
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    studentBioTextview.layer.borderColor = [UIColor grayColor].CGColor;
    studentBioTextview.layer.borderWidth = 0.25;
    studentBioTextview.layer.cornerRadius = 15;
    [studentBioTextview setTextContainerInset:UIEdgeInsetsMake(8, 10, 8, 10)]; // top, left, bottom, right
    
}

-(void)viewDidLayoutSubviews{
    studentImage.layer.cornerRadius = studentImage.frame.size.width / 2.0;
    studentImage.layer.masksToBounds = YES;
    studentImage.clipsToBounds = YES;
    
}


-(UIImage *)imageWithImage:(UIImage *)image  {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(134, 134), NO, 0.0);
    // Here pass new size you need
    [image drawInRect:CGRectMake(0, 0, 134, 134)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}

- (IBAction)callButton:(id)sender {
    
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel track:@"SDA Detail View" properties:@{
                                                    @"SDA Called": studentName
                                                    }];
    NSString *promptprefix = @"tel://";
    
    NSMutableString *strippedString = [NSMutableString stringWithCapacity:10];
    for (int i=0; i<[studentPhoneNumber length]; i++) {
        if (isdigit([studentPhoneNumber characterAtIndex:i])) {
            [strippedString appendFormat:@"%c",[studentPhoneNumber characterAtIndex:i]];
        }
    }
    
    NSString *callprompt = [promptprefix stringByAppendingString:strippedString];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callprompt]];

}
- (IBAction)emailButton:(id)sender {
    
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel track:@"SDA Detail View" properties:@{
                                                    @"SDA Emailed": studentName
                                                    }];
    
    
    NSArray *toRecipents = [NSArray arrayWithObject:studentEmail];
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    [mc setToRecipients:toRecipents];
    mc.mailComposeDelegate = self;
    
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}



- (IBAction)textButton:(id)sender {
    
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel track:@"SDA Detail View" properties:@{
                                                    @"SDA Texted": studentName
                                                    }];
    
    [self showSMS:studentPhoneNumber];
}

- (void)showSMS:(NSString*)recipient {
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    NSArray *recipents = @[recipient];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"Navigation Bar"];
    [[UINavigationBar appearance] setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    // Present message view controller on screen
    [self.navigationController presentViewController:messageController animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
}

@end
