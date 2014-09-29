//
//  AppDelegate.m
//  NSW
//
//  Created by Stephen Grinich on 5/7/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "AppDelegate.h"
#import "FLDownloader.h"
#import "DataSourceManager.h"
#import <GoogleMaps/GoogleMaps.h>
#import "NSWConstants.h"
#import "SWRevealViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // Initialize the downloader singleton and ensure there aren't any pending downloads 
    // (our downloads are so quick that we're better off just getting a new copy in case 
    // the data's been updated since that other download started).
    FLDownloader *downloader = [FLDownloader sharedDownloader];
    [downloader cancelAnyExistingDownloads];
    NSString *pathToDocuments = [downloader defaultFilePath];
    NSLog(@"Default download location:\n  %@", pathToDocuments);
    [DataSourceManager sharedDSManager];
    NSLog(@"Week start: %@\n  Week end: %@", [NSWConstants firstDayOfNSW], [NSWConstants lastDayOfNSW]);

    [GMSServices provideAPIKey:@"AIzaSyDlADA4C0TCbE2jWOXVjuQxeyBljSmH3Xg"];
    
    // Initialize the singleton downloader
    [FLDownloader sharedDownloader];
    
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"NSW"
                                                        message:notification.alertBody
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    // Request to reload table view data
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    // Set icon badge number to zero
    application.applicationIconBadgeNumber = 0;
}


@end
