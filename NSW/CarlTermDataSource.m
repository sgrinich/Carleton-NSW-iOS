//
//  DictionaryDataSource.m
//  NSW
//
//  Created by Alex Simonides on 5/13/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "CarlTermDataSource.h"
#import "CarlTerm.h"

@implementation CarlTermDataSource

NSMutableArray * parsedCarlTerms;

- (id)init {
    self = [super initWithDataFromFile:@"terms.json"];

    return self;
}

- (void)parseLocalData{
    [self parseAndSet:self.localData];
    [super parseLocalData];
}
- (void)parseAndSet:(NSData *)JSONData {
    parsedCarlTerms = [[NSMutableArray alloc] init];
    NSDictionary *termlist = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
    for(id key in termlist) {
        id value = termlist[key];
        CarlTerm * term = [[CarlTerm alloc] initWithAbbreviation:key LongName:value];
        [parsedCarlTerms addObject:term];
    }
    
    // "'Scrunch'" is getting placed at the top because of the single quotes...
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"abbreviation" ascending:YES];
    [parsedCarlTerms sortUsingDescriptors:@[sort]];
    
    // Send the data to the view controller if there's one linked, otherwise 
    // copy it into self.dataList to be retrieved once a VC has been linked
    if (myTableViewController != nil) {
        [myTableViewController setVCArrayToDataSourceArray:parsedCarlTerms];
    } else {
        self.dataList = [NSArray arrayWithArray:parsedCarlTerms];
    }
}


@end
