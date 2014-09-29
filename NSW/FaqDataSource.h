//
//  FaqDataSource.h
//  NSW
//
//  Created by Stephen Grinich on 7/21/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FaqViewController.h"
#import "BaseNSWDataSource.h"


@interface FaqDataSource : BaseNSWDataSource

- (NSString *)getIDFromString:(NSString *) htmlContact;

@end
