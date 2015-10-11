//
//  MapLocationsTableViewController.h
//  NSW
//
//  Created by Stephen Grinich on 7/27/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationTableViewCell.h"
#import "MapLocation.h"
#import <CoreLocation/CoreLocation.h>


@class MapLocationsTableViewController;

@protocol MapLocationsTableViewControllerDelegate <NSObject>
- (void)addItemViewController:(MapLocationsTableViewController *)controller didFinishEnteringItem:(MapLocation *)locationObject;
@end


@interface MapLocationsTableViewController : UITableViewController <CLLocationManagerDelegate>{
    NSMutableArray *locationsList;

}

@property (retain, atomic) NSMutableArray *locationsList;
@property (nonatomic, weak) id <MapLocationsTableViewControllerDelegate> delegate;
@property(nonatomic,strong) CLLocationManager *locationManager;


@end
