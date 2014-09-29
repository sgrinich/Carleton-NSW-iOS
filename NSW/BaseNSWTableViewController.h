//
// Created by Alex Simonides on 5/15/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BaseNSWTableViewController : UITableViewController

@property NSMutableArray *listItems;
@property (nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;

-(void)setVCArrayToDataSourceArray:(NSArray *)dataSourceEventList;


@end