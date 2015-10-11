//
//  CarlTermTableViewController.m
//  NSW
//
//  Created by Alex Simonides on 5/13/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "CarlTermViewController.h"
#import "CarlTermDataSource.h"
#import "CarlTerm.h"
#import "CarlTermTableViewCell.h"
#import "NSWStyle.h"
#import "DataSourceManager.h"
#import "CarlTermDetailViewController.h"
#import "SWRevealViewController.h"
#import "KLCPopup.h"
#import "Mixpanel.h"
#import "NSWStyle.h"

@interface CarlTermViewController (){
}

@end

@implementation CarlTermViewController

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
    self.navigationItem.title = @"Speak Carleton";
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [NSWStyle oceanBlueColor];
    [self.tableView setBackgroundView:view];
    
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

    //Connect this VC to the shared DataSource
    [[[DataSourceManager sharedDSManager] getCarlTermDataSource] attachVCBackref:self];

}


- (CarlTermTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarlTermTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    CarlTerm *term = self.listItems[(NSUInteger) indexPath.row];
    cell.longNameLabel.text = [term longName];
    cell.abbreviationLabel.text = [term abbreviation];
    cell.abbreviationLabel.textColor = [NSWStyle oceanBlueColor];
    cell.longNameLabel.numberOfLines = 1;
    return cell;
}

/*
 Set selectedIndex to the clicked indexPath. [tableView begin/endUpdates] will reload view, calling heightForRowAtIndexPath. This sets the cell at selectedIndex to have a height 80
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CarlTerm *term = self.listItems[(NSUInteger) indexPath.row];

    
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel track:@"Carlterm View" properties:@{
                                                    @"Term Selected": [term abbreviation]
                                                    }];
    
    
        UIView* contentView = [self getTermView:term];    
        KLCPopup* popup = [KLCPopup popupWithContentView:contentView];
        [popup show];

}


-(UIView *)getTermView:(CarlTerm *)term{
    UIView* termView = [[UIView alloc] init];
    
    termView.backgroundColor = [NSWStyle grayColor];
    termView.layer.cornerRadius = 20;
    
    //NSLog(@"width: %f",self.view.frame.size.width);
    termView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width - 40, self.view.frame.size.height/2 + 30);
    
    UILabel *termName = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, termView.frame.size.width - 10, 40)];
    termName.font = [UIFont fontWithName:@"Helvetica" size:36];
    termName.textColor = [NSWStyle darkBlueColor];
    termName.textAlignment = NSTextAlignmentCenter;
    termName.text = [term abbreviation];
    
    UITextView *termDescription = [[UITextView alloc] initWithFrame:CGRectMake(20, termName.frame.origin.y + 45, termView.frame.size.width - 30, termView.frame.size.height - 85)];
    termDescription.font = [UIFont fontWithName:@"Helvetica" size:18];
    termDescription.text = [term longName];
    termDescription.backgroundColor = [NSWStyle grayColor];
    termDescription.editable = NO; 

    
    [termView addSubview:termName];
    [termView addSubview:termDescription];
    return termView;
}






//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    
//    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//    CarlTerm *term = self.listItems[(NSUInteger) indexPath.row];
//    CarlTermDetailViewController *destViewController = segue.destinationViewController;
//    
//    if ([[segue identifier] isEqualToString:@"showTermDetail"]) {
//        
//        destViewController.termName = [term abbreviation];
//        destViewController.termDescription = [term longName]; 
//        
//        
//    }
//}
//



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
