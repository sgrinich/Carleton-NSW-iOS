//
//  StudentProfileTableViewCell.h
//  Carleton NSW
//
//  Created by Stephen Grinich on 7/19/15.
//  Copyright (c) 2015 BTIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentProfileTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *studentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentMajorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *studentImageView;

@end
