//
// Created by Alex Simonides on 5/20/14.
// Copyright (c) 2014 BTIN. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MapViewController : UIViewController
- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer;
- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;

@end