//
//  EventTableViewCell.m
//  NSW
//
//  Created by Evan Harris on 5/24/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "EventTableViewCell.h"

@implementation EventTableViewCell

@synthesize eventTimeLabel;
@synthesize eventNameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.eventTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 300, 30)];
        self.eventTimeLabel.font = [UIFont fontWithName:@"Arial" size:25.0f];
        
        self.eventNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 300, 30)];
        self.eventNameLabel.font = [UIFont fontWithName:@"Ariel" size:25.0f];
        
        [self addSubview:self.eventTimeLabel];
        [self addSubview:self.eventNameLabel];

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
