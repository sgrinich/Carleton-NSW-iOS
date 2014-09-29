//
//  CarlTermDetailViewController.h
//  NSW
//
//  Created by Stephen Grinich on 7/8/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNSWTableViewController.h"


@interface CarlTermDetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *termTitle;
@property (weak, nonatomic) IBOutlet UITextView *termDescriptionTextView;
@property (nonatomic, strong) NSString *termDescription;
@property (nonatomic, strong) NSString *termName;


@end
