
//
//  StudentProfileDataSource.m
//  Carleton NSW
//
//  Created by Stephen Grinich on 7/18/15.
//  Copyright (c) 2015 BTIN. All rights reserved.
//

#import "StudentProfileDataSource.h"
#import "StudentSpecialist.h"

@implementation StudentProfileDataSource

NSMutableArray *profilesArrray;

- (id)init {
    //self = [super initWithDataFromFile:@"SDA.csv"];
    
    [self parseDataIntoProfiles];
    
    return self;
}


//- (void)parseLocalData{
//    [self parseDataIntoProfiles];
//    [super parseLocalData];
//}

-(void) parseDataIntoProfiles{
    
    NSLog(@"parseDataIntoProfiles starts ");
    
    profilesArrray = [[NSMutableArray alloc]init];
    
//    NSString *rawProfiles = [[NSString alloc] initWithData:self.localData encoding:NSUTF8StringEncoding];
//    NSString *file = [[NSString alloc] initWithContentsOfFile:@"SDA.csv"];
//    NSArray *allLines = [file componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
//    
    StudentSpecialist *student = [[StudentSpecialist alloc] initWithProfile:@"Stephen Grinich" Bio:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda." Number:@"555-237-4708" Email:@"grinichs@carlton.edu" Major:@"Computer Science"];
    
    [profilesArrray addObject:student];
    
    if (myTableViewController != nil) {
        [myTableViewController setVCArrayToDataSourceArray:profilesArrray];
        
    } else {
        self.dataList = [NSArray arrayWithArray:profilesArrray];
    }
    
}
@end
