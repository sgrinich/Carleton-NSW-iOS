//
//  NSWStyle.h
//  NSW
//
//  Created by Alex Simonides on 5/12/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import <Foundation/Foundation.h>

// A class containing color constants for consistent styling throughout the app
@interface NSWStyle : NSObject

+ (UIColor *)lightBlueColor;
+ (UIColor *)darkBlueColor;
+ (UIColor *)grayColor;
+ (UIColor *)whiteColor;
+ (UIColor *)oceanBlueColor;
+ (UIColor *)darkGrayColor;

+ (UIFont *)basicFont;
+ (UIFont *)boldFont;
+ (UIFont *)fontWithSize:(CGFloat)fontSize;
+ (UIFont *)boldFontWithSize:(CGFloat)fontSize;
@end
