//
//  NSWStyle.m
//  NSW
//
//  Created by Alex Simonides on 5/12/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "NSWStyle.h"


//TODO Put any colors you use here so that we can reuse them easily
@implementation NSWStyle
+ (UIColor *)lightBlueColor {
    return [UIColor colorWithRed:132.0f/255.0f green:181.0f/255.0f blue:255.0f/255.0f alpha:1.0];
}

+ (UIColor *)darkBlueColor {
    return [UIColor colorWithRed:0.0f/255.0f green:16.0f/255.0f blue:120.0f/255.0f alpha:1.0];
}

+ (UIColor *)grayColor {
    return [UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1.0];
}

+ (UIColor *)oceanBlueColor {
    return [UIColor colorWithRed:12.0f/255.0f green:97.0f/255.0f blue:160.0f/255.0f alpha:1.0];
}

+ (UIColor *)darkGrayColor {
    return [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0];
}

+ (UIColor *)midnightBlue {
    return [UIColor colorWithRed:1.0f/255.0f green:16.0f/255.0f blue:28.0f/255.0f alpha:1.0];
}

+ (UIColor *)brownColor {
    return [UIColor colorWithRed:126.0f/255.0f green:130.0f/255.0f blue:134.0f/255.0f alpha:1.0];
}

+ (UIColor *)selectedColor {
    return [UIColor colorWithRed:43.0f/255.0f green:56.0f/255.0f blue:65.0f/255.0f alpha:1.0];
}



+ (UIColor *)whiteColor {
    return [UIColor whiteColor];
}

//-----------------------------------------------------------------------------
#pragma mark Fonts
//-----------------------------------------------------------------------------


+ (UIFont *)fontWithSize:(CGFloat) fontSize {
    return [UIFont fontWithName:@"Helvetica Neue" size:fontSize];
}

+ (UIFont *)boldFontWithSize:(CGFloat) fontSize {
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:fontSize];
}

+ (UIFont *)basicFont {
    return [self fontWithSize:12.0];
}

+ (UIFont *)boldFont {
    return [self boldFontWithSize:18.0];
}



//Main UI Elements: #84b5ff Blue

//Text Color: #001078 Navy

//Grey color: #e8e8e8

//Navigation Color: #000000 40% transparent

@end
