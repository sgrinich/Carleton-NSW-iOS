//
//  DetailViewController.h
//  NSW
//
//  Created by Stephen Grinich on 5/7/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSWEvent.h"

@interface EventDetailViewController : UIViewController

@property (strong, nonatomic) NSWEvent * detailItem;


- (id)initWithEvent:(NSWEvent *)newDetailItem;


@end
