//
//  MapLocation.h
//  NSW
//
//  Created by Stephen Grinich on 7/27/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface MapLocation : NSObject

@property (nonatomic, strong) NSString *maplocation;
@property (nonatomic, strong) GMSMarker *coordinates;

-(id) initWithLocation:(NSString *)LocationName Coordinates:(GMSMarker *)buildingCoordinates;

@end
