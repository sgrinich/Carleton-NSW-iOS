//
//  ContactTableViewController.m
//  NSW
//
//  Created by Alex Simonides on 5/12/14.
//  Added/fixed functionality by Stephen Grinich
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "ContactTableViewController.h"
#import "ContactTableViewCell.h"
#import "Contact.h"
#import "ContactDataSource.h"
#import "DataSourceManager.h"
#import <MessageUI/MessageUI.h>
#import <QuartzCore/QuartzCore.h>
#import "ContactButton.h"
#import "SWRevealViewController.h"

@interface ContactTableViewController ()


@end

@implementation ContactTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];

    self.tableView.delaysContentTouches = NO;
    
    self.listItems = [[NSMutableArray alloc] init];
    
    //Connect this VC to the shared DataSource
    [[[DataSourceManager sharedDSManager] getContactDataSource] attachVCBackref:self];

}
- (IBAction)phoneLabel:(id)sender {
    UIButton *button = (UIButton*)sender;

    NSString *promptprefix = @"tel://";
    NSString *callprompt = [promptprefix stringByAppendingString:button.currentTitle];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callprompt]];
     
}


- (IBAction)emailLabel:(id)sender {
    
    UIButton *button = (UIButton*)sender;
    
    // Some cases exist where parsing cuts off "@carleton.edu" due to inconsistincies in HTML source. This is the fix.
    if([button.currentTitle rangeOfString:@"carleton.edu"].location !=NSNotFound){
        NSArray *toRecipents = [NSArray arrayWithObject:button.currentTitle];
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
       [mc setToRecipients:toRecipents];

       [self presentViewController:mc animated:YES completion:NULL];
        
    }
    
    else{
        
    }
    
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (ContactTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    Contact *contact = self.listItems[(NSUInteger) indexPath.row];
    cell.titleLabel.text = [contact title];
    [cell.emailLabel setTitle:[contact email] forState:UIControlStateNormal];
    [cell.phoneLabel setTitle:[contact phone] forState:UIControlStateNormal];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    
    for (id obj in cell.subviews)
    {
        if ([NSStringFromClass([obj class]) isEqualToString:@"UITableViewCellScrollView"])
        {
            UIScrollView *scroll = (UIScrollView *) obj;
            scroll.delaysContentTouches = NO;
            break;
        }
    }
    
    
    return cell;
}

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
