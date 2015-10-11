
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
    self = [super initWithDataFromFile:@"StudentProfiles.txt"];
    
    [self parseDataIntoProfiles];
    
    return self;
}



- (void)parseLocalData{
    [self parseDataIntoProfiles];
    [super parseLocalData];
}

-(void) parseDataIntoProfiles{
    
    
    profilesArrray = [[NSMutableArray alloc]init];
    
    NSString *csvFile = [[NSString alloc] initWithData:self.localData encoding:NSUTF8StringEncoding];

    
    NSArray *allLines = [csvFile componentsSeparatedByString:@"\n"];
    
    NSString *name = [[NSString alloc]init];
    NSString *major = [[NSString alloc]init];
    NSString *email = [[NSString alloc]init];
    NSString *phoneNumber = [[NSString alloc]init];

    for (NSString* line in allLines) {
        NSArray *elements = [line componentsSeparatedByString:@","];
        
        if([elements count]>1){
        
        name = [elements objectAtIndex:0];
        major = [elements objectAtIndex:1];
        email = [[elements objectAtIndex:2] stringByAppendingString:@"@carleton.edu"];
        phoneNumber = [[[elements objectAtIndex:3] componentsSeparatedByCharactersInSet:
                        [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                       componentsJoinedByString:@""];
          
        NSMutableString *bio = [[NSMutableString alloc]init];
    
        for(int i = 4; i<[elements count]; i++) {
            if ((i != [elements count]) && (i != 4)){
                [bio appendString:@","];
            }
            [bio appendString:[elements objectAtIndex:i]];
        }
            
            if([bio hasPrefix:@"\""]){
                bio = [bio substringFromIndex:1];
            }
            
            if([bio hasSuffix:@"\""]){
                bio = [bio substringToIndex:[bio length] -1];
            }
        
            StudentSpecialist *student = [[StudentSpecialist alloc] initWithProfile:name Bio:bio Number:phoneNumber Email:email Major:major];
            [profilesArrray addObject:student];
         }
    }
    
    if (myTableViewController != nil) {
        [myTableViewController setVCArrayToDataSourceArray:profilesArrray];
        
    } else {
        self.dataList = [NSArray arrayWithArray:profilesArrray];
    }
    
}
@end
