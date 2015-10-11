//
//  FaqViewController.m
//  NSW
//
//  Created by Stephen Grinich on 7/21/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "FaqViewController.h"
#import "FaqDataSource.h"
#import "FaqItem.h"
#import "FaqTableViewCell.h"
#import "DataSourceManager.h"
#import "NSWStyle.h"
#import "FaqDetailViewController.h"
#import "UIViewController+ScrollingNavbar.h"
#import "SWRevealViewController.h"
#import "Mixpanel.h"

@interface FaqViewController (){
    /* Sections are in this order and include:
     -- NewStudents
     -- Registration
     -- Housing
     -- OneCard
     -- PostOffice
     -- SHAC
     -- Advising
     -- ITS
     -- Language
     -- PrintServices
     -- DisabilityServices
     -- Miscellaneous
     */
    
}


@end

@implementation FaqViewController

@synthesize studentsSection = _studentsSection;
@synthesize registrationSection = _registrationSection;
@synthesize housingSection  = _housingSection;
@synthesize oneCardSection = _oneCardSection;
@synthesize postOfficeSection = _postOfficeSection;
@synthesize shacSection = _shacSection;
@synthesize advisingSection = _advisingSection;
@synthesize itsSection = _itsSection; 
@synthesize languageSection = _languageSection;
@synthesize printServicesSection = _printServicesSection;
@synthesize disabilityServiceSection = _disabilityServiceSection;
@synthesize miscSection = _miscSection;



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

int selectedIndex;



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"FAQ";
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [NSWStyle oceanBlueColor];
    [self.tableView setBackgroundView:view];
    
    //Connect this VC to the shared DataSource
    [[[DataSourceManager sharedDSManager] getFaqDataSource] attachVCBackref:self];
    
    //[self followScrollView:self.tableView];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    
    SWRevealViewController *revealViewController = self.revealViewController;

    
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    [self.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self showNavBarAnimated:NO];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}



//- (BOOL)scrollViewShouldScrollToTop {
//    [self showNavbar];
//    return YES;
//
//}

//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    
//     if([self isRowZeroVisible]){
//            CGRect frameAdjustedToPreventOffset = self.tableView.frame;
//            frameAdjustedToPreventOffset.size.height += frameAdjustedToPreventOffset.origin.y;
//            frameAdjustedToPreventOffset.origin.y = 0;
//            self.tableView.frame = frameAdjustedToPreventOffset;
//        }
//}


//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    scrollView.bounces = NO;
//
//    // Prevent the AMScrollingNavbar from creating a black gap the first time the feed is scrolled.
//    
//    if([self isRowZeroVisible]){
//        if (scrollView.contentOffset.y > 0
//            && CGRectGetMinY(self.tableView.frame) != 0) {
//            CGRect frameAdjustedToPreventOffset = self.tableView.frame;
//            frameAdjustedToPreventOffset.size.height += frameAdjustedToPreventOffset.origin.y;
//            frameAdjustedToPreventOffset.origin.y = 0;
//            self.tableView.frame = frameAdjustedToPreventOffset;
//        }
//        if (scrollView.contentOffset.y < 0
//            && CGRectGetMinY(self.tableView.frame) != 0) {
//            CGRect frameAdjustedToPreventOffset = self.tableView.frame;
//            frameAdjustedToPreventOffset.size.height += frameAdjustedToPreventOffset.origin.y;
//            frameAdjustedToPreventOffset.origin.y = 0;
//            self.tableView.frame = frameAdjustedToPreventOffset;
//        }
//    }
//    
//    else{
//        if (scrollView.contentOffset.y > 0
//            && CGRectGetMinY(self.tableView.frame) != 0) {
//            CGRect frameAdjustedToPreventOffset = self.tableView.frame;
//            frameAdjustedToPreventOffset.size.height += frameAdjustedToPreventOffset.origin.y;
//            frameAdjustedToPreventOffset.origin.y = 0;
//            self.tableView.frame = frameAdjustedToPreventOffset;
//        }
//        
//        if (scrollView.contentOffset.y < 0
//            && CGRectGetMinY(self.tableView.frame) != 0) {
//            CGRect frameAdjustedToPreventOffset = self.tableView.frame;
//            frameAdjustedToPreventOffset.size.height += frameAdjustedToPreventOffset.origin.y;
//            frameAdjustedToPreventOffset.origin.y = 0;
//            self.tableView.frame = frameAdjustedToPreventOffset;
//        }
//        
//    }
//    
//    
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Do some stuff when the row is selected
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//
//-(BOOL)isRowZeroVisible {
//    NSArray *indexes = [self.tableView indexPathsForVisibleRows];
//    for (NSIndexPath *index in indexes) {
//        if (index.row == 0) {
//            return YES;
//        }
//    }
//    
//    return NO;
//}

- (FaqTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    FaqTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    switch (indexPath.section) {
        case 0:
            cell.questionLabel.text = [[_studentsSection objectAtIndex:indexPath.row] question];
            break;
            
        case 1:
            cell.questionLabel.text = [[_registrationSection objectAtIndex:indexPath.row]question];
            break;
            
        case 2:
            cell.questionLabel.text = [[_housingSection objectAtIndex:indexPath.row] question];
            break;
            
        case 3:
            cell.questionLabel.text = [[_oneCardSection objectAtIndex:indexPath.row] question];
            break;
            
        case 4:
            cell.questionLabel.text = [[_postOfficeSection objectAtIndex:indexPath.row] question];
            break;
            
        case 5:
            cell.questionLabel.text = [[_shacSection objectAtIndex:indexPath.row] question];
            break;
            
        case 6:
            cell.questionLabel.text = [[_advisingSection objectAtIndex:indexPath.row] question];
            break;
            
        case 7:
            cell.questionLabel.text = [[_itsSection objectAtIndex:indexPath.row] question];
            break;
            
        case 8:
            cell.questionLabel.text = [[_languageSection objectAtIndex:indexPath.row] question];
            break;
            
        case 9:
            cell.questionLabel.text = [[_printServicesSection objectAtIndex:indexPath.row] question];
            break;
            
        case 10:
            cell.questionLabel.text = [[_disabilityServiceSection objectAtIndex:indexPath.row] question];
            break;
            
       /* case 10:
            cell.questionLabel.text = [[_miscSection objectAtIndex:indexPath.row] question];
            break;*/
            
        default:
            break;
    }
    
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 12;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    _studentsSection = [NSMutableArray array];
    _registrationSection = [NSMutableArray array];
    _housingSection = [NSMutableArray array];
    _oneCardSection = [NSMutableArray array];
    _postOfficeSection = [NSMutableArray array];
    _shacSection = [NSMutableArray array];
    _advisingSection = [NSMutableArray array];
    _itsSection = [NSMutableArray array];
    _languageSection = [NSMutableArray array];
    _printServicesSection = [NSMutableArray array];
    _disabilityServiceSection = [NSMutableArray array];
    _miscSection = [NSMutableArray array];
    
    
    for(FaqItem *item in self.listItems){
        
        if([[item section] isEqualToString:@"NewStudents"]){
            [_studentsSection addObject:item];
        }
        
        else if ([[item section]isEqualToString:@"Registration"]){
            [_registrationSection addObject:item];
        }
        
        else if([[item section] isEqualToString:@"Housing"]){
            [_housingSection addObject:item];
            
        }
        
        else if([[item section] isEqualToString:@"OneCard"]){
            [_oneCardSection addObject:item];
        }
        
        else if([[item section] isEqualToString:@"PostOffice"]){
            [_postOfficeSection addObject:item];
        }
        
        else if([[item section] isEqualToString:@"SHAC"]){
            [_shacSection addObject:item];
        }
        
        else if([[item section] isEqualToString:@"Advising"]){
            [_advisingSection addObject:item];
        }
        
        else if([[item section] isEqualToString:@"ITS"]){
            [_itsSection addObject:item];
        }
        
        else if([[item section] isEqualToString:@"Language"]){
            [_languageSection addObject:item];
        }
        
        else if([[item section] isEqualToString:@"PrintServices"]){
            [_printServicesSection addObject:item];
        }
        else if([[item section] isEqualToString:@"DisabilityServices"]){
            [_disabilityServiceSection addObject:item];
        }
        else if([[item section] isEqualToString:@"Miscellaneous"]){
            [_miscSection addObject:item];
        }
        
    }
    
    int count = 0;
    switch (section) {
        case 0:
            count = [_studentsSection count];
            break;
        case 1:
            count = [_registrationSection count];
            break;
            
        case 2:
            count = [_housingSection count];
            break;
            
        case 3:
            count = [_oneCardSection count];
            break;
        
        case 4:
            count = [_postOfficeSection count];
            break;
        
        case 5:
            count = [_shacSection count];
            break;
            
        case 6:
            count = [_advisingSection count];
            break;
        
        case 7:
            count = [_itsSection count];
            break;
            
        case 8:
            count = [_languageSection count];
            break;
            
        case 9:
            count = [_printServicesSection count];
            break;
        
        case 10:
            count = [_disabilityServiceSection count];
            break;
        
       /* case 10:
            count = [_miscSection count];
            break;
*/
        default:
            break;
    }
    return count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.frame = CGRectMake(0, 0, 320, 40);
    myLabel.backgroundColor = [NSWStyle oceanBlueColor];
    myLabel.font = [UIFont boldSystemFontOfSize:24];
    myLabel.textColor = [UIColor whiteColor];
    myLabel.textAlignment = NSTextAlignmentCenter; 
    myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, myLabel.frame.size.height)];
    [headerView setBackgroundColor:[NSWStyle oceanBlueColor]];
    [headerView addSubview:myLabel];
    //TODO: Center view in container
    myLabel.center = CGPointMake(headerView.frame.size.width/2, headerView.frame.size.height/2);
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *title = @"";
    
    switch (section) {
        case 0:
            title = @"General";
            break;
        case 1:
            title = @"Registration";
            break;
        case 2:
            title = @"Housing";
            break;
        case 3:
            title = @"OneCard";
            break;
        case 4:
            title = @"Post Office";
            break;
        case 5:
            title = @"Student Health";
            break;
        case 6:
            title = @"Advising";
            break;
        case 7:
            title = @"ITS";
            break;
        case 8:
            title = @"Language Placement";
            break;
        case 9:
            title = @"Print Services";
            break;
        case 10:
            title = @"Disability Services";
            break;
       /* case 10:
            title = @"Miscellaneous";
            break;*/
            
        default:
            break;
    }
    
    return title;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    FaqDetailViewController *destFaqViewController = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSString *sectionQuestion;
    NSString *sectionAnswer;
    
    
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    
    
    switch (indexPath.section) {
        case 0:
            sectionQuestion = [[_studentsSection objectAtIndex:indexPath.row] question];
            sectionAnswer = [[_studentsSection objectAtIndex:indexPath.row] answer];
            
            [mixpanel track:@"FAQ Information" properties:@{
                                                               @"FAQ Section": @"General",
                                                               @"Question":sectionQuestion
                                                               }];
            break;
            
        case 1:
            sectionQuestion = [[_registrationSection objectAtIndex:indexPath.row] question];
            sectionAnswer = [[_registrationSection objectAtIndex:indexPath.row] answer];
            
            [mixpanel track:@"FAQ Information" properties:@{
                                                            @"FAQ Section": @"Registration",
                                                            @"Question":sectionQuestion
                                                            }];
            break;
            
        case 2:
            sectionQuestion = [[_housingSection objectAtIndex:indexPath.row] question];
            sectionAnswer = [[_housingSection objectAtIndex:indexPath.row] answer];
            
            [mixpanel track:@"FAQ Information" properties:@{
                                                            @"FAQ Section": @"Housing",
                                                            @"Question":sectionQuestion
                                                            }];
            break;
            
            
        case 3:
            sectionQuestion = [[_oneCardSection objectAtIndex:indexPath.row] question];
            sectionAnswer = [[_oneCardSection objectAtIndex:indexPath.row] answer];
            
            [mixpanel track:@"FAQ Information" properties:@{
                                                            @"FAQ Section": @"OneCard",
                                                            @"Question":sectionQuestion
                                                            }];
            break;
            
        case 4:
            sectionQuestion = [[_postOfficeSection objectAtIndex:indexPath.row] question];
            sectionAnswer = [[_postOfficeSection objectAtIndex:indexPath.row] answer];
            
            [mixpanel track:@"FAQ Information" properties:@{
                                                            @"FAQ Section": @"Post Office",
                                                            @"Question":sectionQuestion
                                                            }];
            break;
            
        case 5:
            sectionQuestion = [[_shacSection objectAtIndex:indexPath.row] question];
            sectionAnswer = [[_shacSection objectAtIndex:indexPath.row] answer];
            
            [mixpanel track:@"FAQ Information" properties:@{
                                                            @"FAQ Section": @"SHAC",
                                                            @"Question":sectionQuestion
                                                            }];
            break;
            
        case 6:
            sectionQuestion = [[_advisingSection objectAtIndex:indexPath.row] question];
            sectionAnswer = [[_advisingSection objectAtIndex:indexPath.row] answer];
            
            [mixpanel track:@"FAQ Information" properties:@{
                                                            @"FAQ Section": @"Advising",
                                                            @"Question":sectionQuestion
                                                            }];
            break;
            
        case 7:
            sectionQuestion = [[_itsSection objectAtIndex:indexPath.row] question];
            sectionAnswer = [[_itsSection objectAtIndex:indexPath.row] answer];
            
            [mixpanel track:@"FAQ Information" properties:@{
                                                            @"FAQ Section": @"ITS",
                                                            @"Question":sectionQuestion
                                                            }];
            break;
            
        case 8:
            sectionQuestion = [[_languageSection objectAtIndex:indexPath.row] question];
            sectionAnswer = [[_languageSection objectAtIndex:indexPath.row] answer];
            
            [mixpanel track:@"FAQ Information" properties:@{
                                                            @"FAQ Section": @"Language",
                                                            @"Question":sectionQuestion
                                                            }];
            break;
            
        case 9:
            sectionQuestion = [[_printServicesSection objectAtIndex:indexPath.row] question];
            sectionAnswer = [[_printServicesSection objectAtIndex:indexPath.row] answer];
            
            [mixpanel track:@"FAQ Information" properties:@{
                                                            @"FAQ Section": @"Print Services",
                                                            @"Question":sectionQuestion
                                                            }];
            break;
            
        case 10:
            sectionQuestion = [[_disabilityServiceSection  objectAtIndex:indexPath.row] question];
            sectionAnswer = [[_disabilityServiceSection objectAtIndex:indexPath.row] answer];
            
            [mixpanel track:@"FAQ Information" properties:@{
                                                            @"FAQ Section": @"Disability Services",
                                                            @"Question":sectionQuestion
                                                            }];
            break;
            
       /* case 10:
            sectionQuestion = [[_miscSection objectAtIndex:indexPath.row] question];
            sectionAnswer = [[_miscSection objectAtIndex:indexPath.row] answer];
            break;
            */
        default:
            break;
    }

    
    if ([[segue identifier] isEqualToString:@"showAnswerDetail"]) {
        
        destFaqViewController.question = sectionQuestion;
        destFaqViewController.answer = sectionAnswer;
        
        
        
    }
}



@end
