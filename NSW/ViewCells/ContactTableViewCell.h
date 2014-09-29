//
//  ContactTableViewCell.h
//  NSW
//
//  Created by Alex Simonides on 5/12/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactButton.h"

@interface ContactTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *emailLabel;

@end
