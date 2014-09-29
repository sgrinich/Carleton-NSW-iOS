//
//  DictionaryWord.h
//  NSW
//
//  Created by Alex Simonides on 5/13/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarlTerm : NSObject

@property (nonatomic, strong) NSString *abbreviation;
@property (nonatomic, strong) NSString *longName;

-(id) initWithAbbreviation:(NSString *)abbrev LongName:(NSString *)longerName;

@end
