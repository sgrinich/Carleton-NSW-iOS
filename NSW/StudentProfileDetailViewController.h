//
//  StudentProfileDetailViewController.h
//  Carleton NSW
//
//  Created by Stephen Grinich on 7/30/15.
//  Copyright (c) 2015 BTIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>


@interface StudentProfileDetailViewController : UIViewController <MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) NSString *studentName;
@property (nonatomic, strong) NSString *studentMajor;
@property (nonatomic, strong) NSString *studentBio;
@property (nonatomic, strong) NSString *studentPhoneNumber;
@property (nonatomic, strong) NSString *studentEmail;
@property (nonatomic, strong) NSString *studentImageName;

@property (weak, nonatomic) IBOutlet UIImageView *studentImage;
@property (weak, nonatomic) IBOutlet UILabel *studentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentMajorLabel;
@property (weak, nonatomic) IBOutlet UITextView *studentBioTextview;

@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UIButton *textButton;

@property (nonatomic, strong) MFMailComposeViewController *mc;




@end

