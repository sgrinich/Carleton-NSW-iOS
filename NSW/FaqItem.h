//
//  FaqItem.h
//  NSW
//
//  Created by Stephen Grinich on 7/21/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FaqItem : NSObject
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *answer;
@property (nonatomic, strong) NSString *section;


-(id) initWithQuestion:(NSString *)faqQuestion Answer:(NSString *)faqAnswer Section:(NSString *)faqSection;


@end
