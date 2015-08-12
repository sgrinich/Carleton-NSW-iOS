//
//  StudentSpecialist.h
//  Carleton NSW
//
//  Created by Stephen Grinich on 7/16/15.
//  Copyright (c) 2015 BTIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface StudentSpecialist : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *bio;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *major;

// NEED IMAGE


- (id)initWithProfile:(NSString *)name Bio:(NSString *)bio Number:(NSString *)number  Email:(NSString *)email Major:(NSString *)major;

@end


