//
// Created by Alex Simonides on 6/1/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import "DataSourceManager.h"
#import "EventDataSource.h"


@interface DataSourceManager ()
    @property EventDataSource *eventDataSource;
    @property ContactDataSource *contactDataSource;
    @property CarlTermDataSource *carlTermDataSource;
    @property FaqDataSource *faqDataSource;
    @property StudentProfileDataSource *studentProfileDataSource;
@end



@implementation DataSourceManager

#pragma mark ---- Initializers

static DataSourceManager *sharedDSManager = nil;

// Returns the singleton DataSourceManager
+(id)sharedDSManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedDSManager == nil) {
            sharedDSManager = [[self alloc] initPrivate];
        }
    });
    return sharedDSManager;
}

// this is a private init method (hidden). The real init method raise an exception. Like a real init method
// here we call [super init]
- (id)initPrivate {
    NSLog(@"Data Source Manager initialized.");
    if (self = [super init]) {
        self.eventDataSource = [[EventDataSource alloc] init];
        self.contactDataSource = [[ContactDataSource alloc] init];
        self.carlTermDataSource = [[CarlTermDataSource alloc] init];
        self.faqDataSource = [[FaqDataSource alloc] init];
        self.studentProfileDataSource = [[StudentProfileDataSource alloc] init];
    }
    return self;
}

// raise an exception
- (id)init {
    [NSException exceptionWithName:@"InvalidOperation" reason:@"Cannot invoke init on a Singleton class. Use sharedDSManager." userInfo:nil];
    return nil;
}

#pragma mark ---- Getters

- (EventDataSource *) getEventDataSource {
    return self.eventDataSource;
}

- (ContactDataSource *)getContactDataSource {
    return self.contactDataSource;
}

- (CarlTermDataSource *)getCarlTermDataSource {
    return self.carlTermDataSource;
}

- (FaqDataSource *)getFaqDataSource {
    return self.faqDataSource;
}

- (StudentProfileDataSource *)getStudentProfileDataSource{
    return self.studentProfileDataSource;
}

@end