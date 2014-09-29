//
//  FaqItem.m
//  NSW
//
//  Created by Stephen Grinich on 7/21/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "FaqItem.h"

@implementation FaqItem

@synthesize question;
@synthesize answer;
@synthesize section;

- (id)init {
    self = [super init];
    if (self) {
        // initialization happens here.
    }
    
    return self;
}


- (id)initWithQuestion:(NSString *)faqQuestion
              Answer:(NSString *)faqAnswer Section:(NSString *)faqSection{
    self = [super init];
    if (self) {
        self.question = faqQuestion;
        self.answer = faqAnswer;
        self.section = faqSection;
    }
    
    return self;
}



@end
