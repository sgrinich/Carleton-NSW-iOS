//
//  FaqDetailViewController.h
//  NSW
//
//  Created by Stephen Grinich on 7/22/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNSWTableViewController.h"

@interface FaqDetailViewController : UIViewController

@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *answer;
@property (nonatomic, strong) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UITextView *answerTextView;



@end
