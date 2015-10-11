//
// Created by Alex Simonides on 5/15/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNSWTableViewController.h"
#import "DayViewController.h"


@interface BaseNSWDataSource : NSObject {
    __weak BaseNSWTableViewController *myTableViewController;
    __weak DayViewController *myDayViewController;
}
// the time that the download started
@property (nonatomic, strong) NSDate *downloadStarted;

@property (nonatomic, strong) NSData *localData;

// The list of objects specific to each dataSource (Events, CarlTerms, or Contacts)
@property (nonatomic, strong) NSArray *dataList;

- (id)initWithDataFromFile:(NSString *)localName;

- (void)attachVCBackref:(BaseNSWTableViewController *)tableViewController;

-(void)parseLocalData;

- (void)logDownloadTime;

+(NSArray *)splitString:(NSString *)wholeString atCharactersInString:(NSString *)splitCharacters;


@end