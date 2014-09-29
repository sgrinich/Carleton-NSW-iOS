//
//  DictionaryWord.m
//  NSW
//
//  Created by Alex Simonides on 5/13/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "CarlTerm.h"

@implementation CarlTerm

@synthesize abbreviation;
@synthesize longName;

- (id)init {
    self = [super init];
    if (self) {
        // initialization happens here.
    }
    
    return self;
}

- (id) initWithAbbreviation:(NSString *)abbrev LongName:(NSString *)longerName
{
    self = [super init];
    if (self) {
        self.abbreviation = abbrev;
        self.longName = longerName;
    }
    
    return self;
}

@end
