//
//  DayViewController.h
//  Carleton NSW
//
//  Created by Stephen Grinich on 8/11/15.
//  Copyright (c) 2015 BTIN. All rights reserved.
//

#import "BaseNSWTableViewController.h"

@interface DayViewController : BaseNSWTableViewController{
    NSString* day;
}

- (id)initWithDay:(NSString *)day;

@end
