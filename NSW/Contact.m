//
//  Contact.m
//  NSW
//
//  Created by Evan Harris on 5/11/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "Contact.h"

@implementation Contact
@synthesize title;
@synthesize phone;
@synthesize fax;
@synthesize email;


- (id)init {
    self = [super init];
    if (self) {
        // initialization happens here.
    }
    
    return self;
}

- (id)initWithTitle:(NSString *)contactName
              Phone:(NSString *)phoneNumber
                Fax:(NSString *)faxNumber
              Email:(NSString *)emailAddress{
    self = [super init];
    if (self) {
        self.title = contactName;
        self.phone = phoneNumber;
        self.fax = faxNumber;
        self.email = emailAddress;
    }
    
    return self;
}
@end
