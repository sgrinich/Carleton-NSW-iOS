//
//  EventTableViewCell.h
//  NSW
//
//  Created by Evan Harris on 5/24/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *startEndLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;

@end
