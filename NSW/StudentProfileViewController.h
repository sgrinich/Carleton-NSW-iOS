//
//  StudentProfileViewController.h
//  Carleton NSW
//
//  Created by Stephen Grinich on 7/18/15.
//  Copyright (c) 2015 BTIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNSWTableViewController.h"
#import "StudentProfileDetailViewController.h"

@interface StudentProfileViewController : BaseNSWTableViewController

@property (nonatomic, retain) NSMutableArray *cellIconNames;
@property (nonatomic, weak) NSString *imageName;
@property (nonatomic, retain) NSString *fileName;


@end
