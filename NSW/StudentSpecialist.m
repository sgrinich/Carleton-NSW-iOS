//
//  StudentSpecialist.m
//  Carleton NSW
//
//  Created by Stephen Grinich on 7/16/15.
//  Copyright (c) 2015 BTIN. All rights reserved.
//

#import "StudentSpecialist.h"

@implementation StudentSpecialist

@synthesize name;
@synthesize bio;
@synthesize number;
@synthesize email;
@synthesize major;


- (id)init {
    self = [super init];
    if (self) {
        // initialization happens here.
    }
    
    return self;
}

- (id)initWithProfile:(NSString *)name
              Bio:(NSString *)bio
                Number:(NSString *)number
              Email:(NSString *)email
                Major:(NSString *)major  {
    self = [super init];
    if (self) {
        self.name = name;
        self.bio = bio;
        self.email = email;
        self.major = major;
        self.number = number; 
    }
    
    return self;
}
@end

