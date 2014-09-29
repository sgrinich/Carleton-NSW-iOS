//
//  MapLocation.m
//  NSW
//
//  Created by Stephen Grinich on 7/27/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "MapLocation.h"
#import <GoogleMaps/GoogleMaps.h>


@implementation MapLocation

@synthesize maplocation;
@synthesize coordinates;

- (id)init {
    self = [super init];
    if (self) {
        // initialization happens here.
    }
    
    return self;
}

-(id) initWithLocation:(NSString *)LocationName Coordinates:(GMSMarker *)buildingCoordinates
{
    self = [super init];
    if (self) {
        self.maplocation = LocationName;
        self.coordinates = buildingCoordinates;
    }
    
    return self;
}


@end
