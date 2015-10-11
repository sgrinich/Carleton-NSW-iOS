//
//  FaqViewController.h
//  NSW
//
//  Created by Stephen Grinich on 7/21/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNSWTableViewController.h"
#import "FAQDetailViewController.h"


@interface FaqViewController : BaseNSWTableViewController {
    NSMutableArray *studentsSection;
    NSMutableArray *registrationSection; 
    NSMutableArray *housingSection;
    NSMutableArray *oneCardSection;
    NSMutableArray *postOfficeSection;
    NSMutableArray *shacSection;
    NSMutableArray *advisingSection;
    NSMutableArray *itsSection;
    NSMutableArray *languageSection;
    NSMutableArray *printServicesSection;
    NSMutableArray *disabilityServiceSection;
    NSMutableArray *miscSection;
}

@property (retain, atomic) NSMutableArray *studentsSection;
@property (retain, atomic) NSMutableArray *registrationSection;
@property (retain, atomic) NSMutableArray *housingSection;
@property (retain, atomic) NSMutableArray *oneCardSection;
@property (retain, atomic) NSMutableArray *postOfficeSection;
@property (retain, atomic) NSMutableArray *shacSection;
@property (retain, atomic) NSMutableArray *advisingSection;
@property (retain, atomic) NSMutableArray *itsSection;
@property (retain, atomic) NSMutableArray *languageSection;
@property (retain, atomic) NSMutableArray *printServicesSection;
@property (retain, atomic) NSMutableArray *disabilityServiceSection;
@property (retain, atomic) NSMutableArray *miscSection;

@end
