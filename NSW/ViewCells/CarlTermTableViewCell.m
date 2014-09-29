//
//  CarlTermTableViewCell.m
//  NSW
//
//  Created by Evan Harris on 5/24/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "CarlTermTableViewCell.h"

@implementation CarlTermTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
