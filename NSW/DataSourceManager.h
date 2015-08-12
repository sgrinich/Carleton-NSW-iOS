//
// Created by Alex Simonides on 6/1/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventDataSource.h"
#import "ContactDataSource.h"
#import "CarlTermDataSource.h"
#import "FaqDataSource.h"
#import "StudentProfileDataSource.h"


@interface DataSourceManager : NSObject

+ (id) sharedDSManager;

-(EventDataSource *) getEventDataSource;
-(ContactDataSource *) getContactDataSource;
-(CarlTermDataSource *) getCarlTermDataSource;
-(FaqDataSource *) getFaqDataSource;
-(StudentProfileDataSource *) getStudentProfileDataSource;

@end