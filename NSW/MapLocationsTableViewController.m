//
//  MapLocationsTableViewController.m
//  NSW
//
//  Created by Stephen Grinich on 7/27/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "MapLocationsTableViewController.h"
#import "LocationTableViewCell.h"
#import "MapLocation.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Mixpanel.h"
#import <CoreLocation/CoreLocation.h>
#import "NSWStyle.h"


@interface MapLocationsTableViewController ()

@end

@implementation MapLocationsTableViewController

@synthesize locationsList = _locationsList;
@synthesize delegate;

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
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [NSWStyle oceanBlueColor];
    [self.tableView setBackgroundView:view];
  
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager startUpdatingLocation];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _locationsList = [[NSMutableArray alloc] init];
    
    // User Location
    GMSMarker *myLocationMarker = [[GMSMarker alloc] init];
    myLocationMarker.position = CLLocationCoordinate2DMake(_locationManager.location.coordinate.latitude, _locationManager.location.coordinate.longitude);
    myLocationMarker.title = @"You are here";
    MapLocation *myLocation = [[MapLocation alloc]initWithLocation:@"Where am I?" Coordinates:myLocationMarker];
    [_locationsList addObject:myLocation];
    
    // Allen House
    GMSMarker *allenMarker = [[GMSMarker alloc] init];
    allenMarker.position = CLLocationCoordinate2DMake(44.460106, -93.158276);
    allenMarker.title = @"Allen House";
    MapLocation *allen = [[MapLocation alloc]initWithLocation:@"Allen House" Coordinates:allenMarker];
    [_locationsList addObject:allen];
    
    // Alumni Guest House
    GMSMarker *alumniMarker = [[GMSMarker alloc] init];
    alumniMarker.position = CLLocationCoordinate2DMake(44.459241,  -93.155846);
    alumniMarker.title = @"Alumni Guest House";
    MapLocation *alumni = [[MapLocation alloc]initWithLocation:@"Alumni Guest House" Coordinates:alumniMarker];
    [_locationsList addObject:alumni];
    
    // Arboretum, Lower
    GMSMarker *lowerArbMarker = [[GMSMarker alloc] init];
    lowerArbMarker.position = CLLocationCoordinate2DMake(44.465027, -93.153251);
    lowerArbMarker.title = @"Lower Arboretum";
    MapLocation *lowerArb = [[MapLocation alloc]initWithLocation:@"Arboretum, Lower" Coordinates:lowerArbMarker];
    [_locationsList addObject:lowerArb];
    
    // Arboretum, Upper
    GMSMarker *upperArbMarker = [[GMSMarker alloc] init];
    upperArbMarker.position = CLLocationCoordinate2DMake(44.462523, -93.148198);
    upperArbMarker.title = @"Upper Arboretum";
    MapLocation *upperArb = [[MapLocation alloc]initWithLocation:@"Arboretum, Upper" Coordinates:upperArbMarker];
    [_locationsList addObject:upperArb];
    
    // Bald Spot
    GMSMarker *baldSpotMarker = [[GMSMarker alloc] init];
    baldSpotMarker.position = CLLocationCoordinate2DMake(44.461068, -93.154587);
    baldSpotMarker.title = @"The Bald Spot";
    MapLocation *baldSpot = [[MapLocation alloc]initWithLocation:@"The Bald Spot" Coordinates:baldSpotMarker];
    [_locationsList addObject:baldSpot];
    
    // Baseball Field
    GMSMarker *baseballFieldMarker = [[GMSMarker alloc] init];
    baseballFieldMarker.position = CLLocationCoordinate2DMake(44.466633, -93.147234);
    baseballFieldMarker.title = @"Baseball Field";
    MapLocation *baseballField = [[MapLocation alloc]initWithLocation:@"Baseball field" Coordinates:baseballFieldMarker];
    [_locationsList addObject:baseballField];
    
    // Bell Field
    GMSMarker *bellmarker = [[GMSMarker alloc] init];
    bellmarker.position = CLLocationCoordinate2DMake(44.460195, -93.148842);
    bellmarker.title = @"Bell Field";
    MapLocation *bell = [[MapLocation alloc]initWithLocation:@"Bell Field" Coordinates:bellmarker];
    [_locationsList addObject:bell];
    
    // Benton House
    GMSMarker *bentonMarker = [[GMSMarker alloc] init];
    bentonMarker.position = CLLocationCoordinate2DMake(44.458730, -93.154315);
    bentonMarker.title = @"Benton House (Sci-Fi)";
    MapLocation *benton = [[MapLocation alloc]initWithLocation:@"Benton (Sci-Fi) House" Coordinates:bentonMarker];
    [_locationsList addObject:benton];
    
    // Berg House
    GMSMarker *bergMarker = [[GMSMarker alloc] init];
    bergMarker.position = CLLocationCoordinate2DMake(44.458782, -93.157437);
    bergMarker.title = @"Berg House (WA House)";
    MapLocation *berg = [[MapLocation alloc]initWithLocation:@"Berg (WA) House" Coordinates:bergMarker];
    [_locationsList addObject:berg];
    
    // Bird House
    GMSMarker *birdMarker = [[GMSMarker alloc] init];
    birdMarker.position = CLLocationCoordinate2DMake(44.459509, -93.155248);
    birdMarker.title = @"Bird House";
    MapLocation *bird = [[MapLocation alloc]initWithLocation:@"Bird Hourse" Coordinates:birdMarker];
    [_locationsList addObject:bird];
    
    // Boliou Hall
    GMSMarker *boliouMarker = [[GMSMarker alloc] init];
    boliouMarker.position = CLLocationCoordinate2DMake(44.462398, -93.152998);
    boliouMarker.title = @"Boliou hall";
    MapLocation *boliou = [[MapLocation alloc]initWithLocation:@"Boliou Hall" Coordinates:boliouMarker];
    [_locationsList addObject:boliou];
    
    // Brooks House
    GMSMarker *brooksMarker = [[GMSMarker alloc] init];
    brooksMarker.position = CLLocationCoordinate2DMake(44.459607, -93.157974);
    brooksMarker.title = @"Brooks House";
    MapLocation *brooks = [[MapLocation alloc]initWithLocation:@"Brooks House" Coordinates:brooksMarker];
    [_locationsList addObject:brooks];
    
    // Burton Hall
    GMSMarker *burtonMarker = [[GMSMarker alloc] init];
    burtonMarker.position = CLLocationCoordinate2DMake(44.460560, -93.156772);
    burtonMarker.title = @"Burton Hall";
    MapLocation *burton = [[MapLocation alloc]initWithLocation:@"Burton Hall" Coordinates:burtonMarker];
    [_locationsList addObject:burton];
    
    // Cassat Hall
    GMSMarker *cassatMarker = [[GMSMarker alloc] init];
    cassatMarker.position = CLLocationCoordinate2DMake(44.460041, -93.151038);
    cassatMarker.title = @"Cassat Hall";
    MapLocation *cassat = [[MapLocation alloc]initWithLocation:@"Cassat Hall" Coordinates:cassatMarker];
    [_locationsList addObject:cassat];
    
    // Central Park
    GMSMarker *centralParkMarker = [[GMSMarker alloc] init];
    centralParkMarker.position = CLLocationCoordinate2DMake(44.456829, -93.154704);
    centralParkMarker.title = @"Central Park";
    MapLocation *centralPark = [[MapLocation alloc]initWithLocation:@"Central Park" Coordinates:centralParkMarker];
    [_locationsList addObject:centralPark];
    
    // Chaney House
    GMSMarker *chaneyMarker = [[GMSMarker alloc] init];
    chaneyMarker.position = CLLocationCoordinate2DMake(44.458786, -93.150567);
    chaneyMarker.title = @"Chaney House (CANOE House)";
    MapLocation *chaney = [[MapLocation alloc]initWithLocation:@"Chaney (CANOE) House" Coordinates:chaneyMarker];
    [_locationsList addObject:chaney];
    
    // Chapel
    GMSMarker *chapelMarker = [[GMSMarker alloc] init];
    chapelMarker.position = CLLocationCoordinate2DMake(44.460170, -93.154838);
    chapelMarker.title = @"Skinner Memorial Chapel";
    MapLocation *chapel = [[MapLocation alloc]initWithLocation:@"Chapel" Coordinates:chapelMarker];
    [_locationsList addObject:chapel];
    
    // Clader House
    GMSMarker *claderMarker = [[GMSMarker alloc] init];
    claderMarker.position = CLLocationCoordinate2DMake(44.458692, -93.157743);
    claderMarker.title = @"Clader House";
    MapLocation *clader = [[MapLocation alloc]initWithLocation:@"Clader House" Coordinates:claderMarker];
    [_locationsList addObject:clader];
    
    // CMC
    GMSMarker *cmcMarker = [[GMSMarker alloc] init];
    cmcMarker.position = CLLocationCoordinate2DMake(44.462463, -93.153519);
    cmcMarker.title = @"Center for Mathematics and Computing";
    MapLocation *cmc = [[MapLocation alloc]initWithLocation:@"CMC" Coordinates:cmcMarker];
    [_locationsList addObject:cmc];
    
    // Collier House
    GMSMarker *collierMarker = [[GMSMarker alloc] init];
    collierMarker.position = CLLocationCoordinate2DMake(44.459281, -93.158174);
    collierMarker.title = @"Collier House";
    MapLocation *collier = [[MapLocation alloc]initWithLocation:@"Collier House" Coordinates:collierMarker];
    [_locationsList addObject:collier];
    
    // Colwell House
    GMSMarker *colwellMarker = [[GMSMarker alloc] init];
    colwellMarker.position = CLLocationCoordinate2DMake(44.458798, -93.158599);
    colwellMarker.title = @"Colwell House";
    MapLocation *colwell = [[MapLocation alloc]initWithLocation:@"Colwell House" Coordinates:colwellMarker];
    [_locationsList addObject:colwell];
    
    // Concert Hall
    GMSMarker *concertMarker = [[GMSMarker alloc] init];
    concertMarker.position = CLLocationCoordinate2DMake(44.460241, -93.153326);
    concertMarker.title = @"Concert Hall";
    MapLocation *concert = [[MapLocation alloc]initWithLocation:@"Concert Hall" Coordinates:concertMarker];
    [_locationsList addObject:concert];
    
    // Cowling Rec Center
    GMSMarker *cowlingMarker = [[GMSMarker alloc] init];
    cowlingMarker.position = CLLocationCoordinate2DMake(44.459896, -93.149963);
    cowlingMarker.title = @"Cowling Gymnasium";
    MapLocation *cowling = [[MapLocation alloc]initWithLocation:@"Cowling Gymnasium" Coordinates:cowlingMarker];
    [_locationsList addObject:cowling];
    
    // Dacie Moses House
    GMSMarker *dacieMarker = [[GMSMarker alloc] init];
    dacieMarker.position = CLLocationCoordinate2DMake(44.459047, -93.157389);
    dacieMarker.title = @"Dacie Moses House";
    MapLocation *dacie = [[MapLocation alloc]initWithLocation:@"Dacie Moses House" Coordinates:dacieMarker];
    [_locationsList addObject:dacie];
    
    // Davis Hall
    GMSMarker *davisMarker = [[GMSMarker alloc] init];
    davisMarker.position = CLLocationCoordinate2DMake(44.460083, -93.156764);
    davisMarker.title = @"Davis Hall";
    MapLocation *davis = [[MapLocation alloc]initWithLocation:@"Davis Hall" Coordinates:davisMarker];
    [_locationsList addObject:davis];
    
    // Dixon House
    GMSMarker *dixonMarker = [[GMSMarker alloc] init];
    dixonMarker.position = CLLocationCoordinate2DMake(44.459147, -93.158261);
    dixonMarker.title = @"Dixon House";
    MapLocation *dixon = [[MapLocation alloc]initWithLocation:@"Dixon House" Coordinates:dixonMarker];
    [_locationsList addObject:dixon];
    
    // Douglas House
    GMSMarker *douglasMarker = [[GMSMarker alloc] init];
    douglasMarker.position = CLLocationCoordinate2DMake(44.457572,  -93.155313);
    douglasMarker.title = @"Douglas House (F.I.S.H. House)";
    MapLocation *douglas = [[MapLocation alloc]initWithLocation:@"Douglas (F.I.S.H.) House" Coordinates:douglasMarker];
    [_locationsList addObject:douglas];
    
    // Dow House
    GMSMarker *dowMarker = [[GMSMarker alloc] init];
    dowMarker.position = CLLocationCoordinate2DMake(44.459012, -93.158340);
    dowMarker.title = @"Dow House";
    MapLocation *dow = [[MapLocation alloc]initWithLocation:@"Dow House" Coordinates:dowMarker];
    [_locationsList addObject:dow];
    
    // Eugster House
    GMSMarker *eugsterMarker = [[GMSMarker alloc] init];
    eugsterMarker.position = CLLocationCoordinate2DMake(44.459982, -93.157742);
    eugsterMarker.title = @"Eugster House";
    MapLocation *eugster = [[MapLocation alloc]initWithLocation:@"Eugster House" Coordinates:eugsterMarker];
    [_locationsList addObject:eugster];
    
    // Evans Hall
    GMSMarker *evansMarker = [[GMSMarker alloc] init];
    evansMarker.position = CLLocationCoordinate2DMake(44.460367, -93.149829);
    evansMarker.title = @"Evans Hall";
    MapLocation *evans = [[MapLocation alloc]initWithLocation:@"Evans Hall" Coordinates:evansMarker];
    [_locationsList addObject:evans];
    
    // Faculty Club
    GMSMarker *facultyMarker = [[GMSMarker alloc] init];
    facultyMarker.position = CLLocationCoordinate2DMake(44.458725, -93.149517);
    facultyMarker.title = @"Faculty Club";
    MapLocation *faculty = [[MapLocation alloc]initWithLocation:@"Faculty Club" Coordinates:facultyMarker];
    [_locationsList addObject:faculty];
    
    // Farm House
    GMSMarker *farmMarker = [[GMSMarker alloc] init];
    farmMarker.position = CLLocationCoordinate2DMake(44.466051, -93.149448);
    farmMarker.title = @"Farm House";
    MapLocation *farm = [[MapLocation alloc]initWithLocation:@"Farm House" Coordinates:farmMarker];
    [_locationsList addObject:farm];
    
    // Geffert House
    GMSMarker *geffertMarker = [[GMSMarker alloc] init];
    geffertMarker.position = CLLocationCoordinate2DMake(44.458901, -93.158990);
    geffertMarker.title = @"Geffert House (Fitness House)";
    MapLocation *geffert = [[MapLocation alloc]initWithLocation:@"Geffert (Fitness) House" Coordinates:geffertMarker];
    [_locationsList addObject:geffert];
    
    // Goodhue Hall
    GMSMarker *goodhueMarker = [[GMSMarker alloc] init];
    goodhueMarker.position = CLLocationCoordinate2DMake(44.462455, -93.149728);
    goodhueMarker.title = @"Goodhue Hall";
    MapLocation *goodhue = [[MapLocation alloc]initWithLocation:@"Goodhue Hall" Coordinates:goodhueMarker];
    [_locationsList addObject:goodhue];
    
    // Goodsell Observatory
    GMSMarker *goodsellMarker = [[GMSMarker alloc] init];
    goodsellMarker.position = CLLocationCoordinate2DMake(44.461856, -93.152440);
    goodsellMarker.title = @"Goodsell Observatory";
    MapLocation *goodsell = [[MapLocation alloc]initWithLocation:@"Goodsell Observatory" Coordinates:goodsellMarker];
    [_locationsList addObject:goodsell];
    
    // Hall House
    GMSMarker *hallMarker = [[GMSMarker alloc] init];
    hallMarker.position = CLLocationCoordinate2DMake(44.459512, -93.157912);
    hallMarker.title = @"Hall House (Asia House)";
    MapLocation *hall = [[MapLocation alloc]initWithLocation:@"Hall House (Asia House)" Coordinates:hallMarker];
    [_locationsList addObject:hall];
    
    // Henrickson House
    GMSMarker *henricksonMarker = [[GMSMarker alloc] init];
    henricksonMarker.position = CLLocationCoordinate2DMake(44.458617, -93.158195);
    henricksonMarker.title = @"Henrickson House";
    MapLocation *henrickson = [[MapLocation alloc]initWithLocation:@"Henrickson House" Coordinates:henricksonMarker];
    [_locationsList addObject:henrickson];
    
    // Hoppin House
    GMSMarker *hoppinMarker = [[GMSMarker alloc] init];
    hoppinMarker.position = CLLocationCoordinate2DMake(44.459541, -93.154317);
    hoppinMarker.title = @"Hoppin House";
    MapLocation *hoppin = [[MapLocation alloc]initWithLocation:@"Hoppin House" Coordinates:hoppinMarker];
    [_locationsList addObject:hoppin];
    
    
    // Hulings Hall
    GMSMarker *hulingsMarker = [[GMSMarker alloc] init];
    hulingsMarker.position = CLLocationCoordinate2DMake(44.460928, -93.153460);
    hulingsMarker.title = @"Hulings Hall";
    MapLocation *hulings = [[MapLocation alloc]initWithLocation:@"Hulings Hall" Coordinates:hulingsMarker];
    [_locationsList addObject:hulings];
    
    // Hill House
    GMSMarker *hillMarker = [[GMSMarker alloc] init];
    hillMarker.position = CLLocationCoordinate2DMake(44.458083, -93.155302);
    hillMarker.title = @"Hill House";
    MapLocation *hill = [[MapLocation alloc]initWithLocation:@"Hill House" Coordinates:hillMarker];
    [_locationsList addObject:hill];
    
    // Hill of Three Oaks
    GMSMarker *htoMarker = [[GMSMarker alloc] init];
    htoMarker.position = CLLocationCoordinate2DMake(44.463266, -93.147314);
    htoMarker.title = @"Hill of Three Oaks";
    MapLocation *hillThreeOaks = [[MapLocation alloc]initWithLocation:@"Hill of Three Oaks" Coordinates:htoMarker];
    [_locationsList addObject:hillThreeOaks];
    
    // Hunt Cottage
    GMSMarker *huntCottageMarker = [[GMSMarker alloc] init];
    huntCottageMarker.position = CLLocationCoordinate2DMake(44.459257, -93.157413);
    huntCottageMarker.title = @"Hunt Cottage (La Casa de Sol)";
    MapLocation *huntCottage = [[MapLocation alloc]initWithLocation:@"Hunt Cottage (La Casa de Sol)" Coordinates:huntCottageMarker];
    [_locationsList addObject:huntCottage];
    
    // Hunt House
    GMSMarker *huntHouseMarker = [[GMSMarker alloc] init];
    huntHouseMarker.position = CLLocationCoordinate2DMake(44.458623, -93.158451);
    huntHouseMarker.title = @"Hunt House";
    MapLocation *huntHouse = [[MapLocation alloc]initWithLocation:@"Hunt House" Coordinates:huntHouseMarker];
    [_locationsList addObject:huntHouse];
    
    // Huntington House
    GMSMarker *huntingtonMarker = [[GMSMarker alloc] init];
    huntingtonMarker.position = CLLocationCoordinate2DMake(44.458751, -93.155342);
    huntingtonMarker.title = @"Huntington House";
    MapLocation *huntington = [[MapLocation alloc]initWithLocation:@"Huntington House" Coordinates:huntingtonMarker];
    [_locationsList addObject:huntington];
    
    // James Hall
    GMSMarker *jamesMarker = [[GMSMarker alloc] init];
    jamesMarker.position = CLLocationCoordinate2DMake(44.460025, -93.151773);
    jamesMarker.title = @"James Hall";
    MapLocation *james = [[MapLocation alloc]initWithLocation:@"James Hall" Coordinates:jamesMarker];
    [_locationsList addObject:james];
    
    // Jewett House
    GMSMarker *jewettMarker = [[GMSMarker alloc] init];
    jewettMarker.position = CLLocationCoordinate2DMake(44.457677, -93.157513);
    jewettMarker.title = @"Jewett House (Culinary House)";
    MapLocation *jewett = [[MapLocation alloc]initWithLocation:@"Jewett (Culinary) House" Coordinates:jewettMarker];
    [_locationsList addObject:jewett];
    
    // Johnson House
    GMSMarker *johnsonMarker = [[GMSMarker alloc] init];
    johnsonMarker.position = CLLocationCoordinate2DMake(44.459472, -93.155970);
    johnsonMarker.title = @"Johnson House";
    MapLocation *johnson = [[MapLocation alloc]initWithLocation:@"Johnson House" Coordinates:johnsonMarker];
    [_locationsList addObject:johnson];
    
    // Laird Hall
    GMSMarker *lairdHallMarker = [[GMSMarker alloc] init];
    lairdHallMarker.position = CLLocationCoordinate2DMake(44.462103, -93.154052);
    lairdHallMarker.title = @"Laird Hall";
    MapLocation *lairdHall = [[MapLocation alloc]initWithLocation:@"Laird Hall" Coordinates:lairdHallMarker];
    [_locationsList addObject:lairdHall];
    
    // Laird Stadium
    GMSMarker *stadiumMarker = [[GMSMarker alloc] init];
    stadiumMarker.title = @"Laird Stadium";
    stadiumMarker.position = CLLocationCoordinate2DMake(44.461516, -93.157987);
    MapLocation *lairdStadium = [[MapLocation alloc]initWithLocation:@"Stadium" Coordinates:stadiumMarker];
    [_locationsList addObject:lairdStadium];
    
    // LDC
    GMSMarker *ldcMarker = [[GMSMarker alloc] init];
    ldcMarker.position = CLLocationCoordinate2DMake(44.461026, -93.151374);
    ldcMarker.title = @"Language and Dining Center";
    MapLocation *ldc = [[MapLocation alloc]initWithLocation:@"Language and Dining Center (LDC)" Coordinates:ldcMarker];
    [_locationsList addObject:ldc];
    
    // Leighton Hall
    GMSMarker *leightonMarker = [[GMSMarker alloc] init];
    leightonMarker.position = CLLocationCoordinate2DMake(44.462114, -93.155643);
    leightonMarker.title = @"Leighton Hall";
    MapLocation *leighton = [[MapLocation alloc]initWithLocation:@"Leighton Hall" Coordinates:leightonMarker];
    [_locationsList addObject:leighton];
    
    // Libe
    GMSMarker *libeMarker = [[GMSMarker alloc] init];
    libeMarker.position = CLLocationCoordinate2DMake(44.462232, -93.154774);
    libeMarker.title = @"Gould Library";
    MapLocation *libe = [[MapLocation alloc]initWithLocation:@"Libe" Coordinates:libeMarker];
    [_locationsList addObject:libe];
    
    // Mudd Hall
    GMSMarker *muddMarker = [[GMSMarker alloc] init];
    muddMarker.position = CLLocationCoordinate2DMake(44.460953, -93.152479);
    muddMarker.title = @"Mudd Hall of Science";
    MapLocation *mudd = [[MapLocation alloc]initWithLocation:@"Mudd Hall" Coordinates:muddMarker];
    [_locationsList addObject:mudd];
    
    // Music Hall
    GMSMarker *musicMarker = [[GMSMarker alloc] init];
    musicMarker.position = CLLocationCoordinate2DMake(44.461376, -93.153583);
    musicMarker.title = @"Music Hall";
    MapLocation *music = [[MapLocation alloc]initWithLocation:@"Music Hall" Coordinates:musicMarker];
    [_locationsList addObject:music];
    
    // Musser Hall
    GMSMarker *musserMarker = [[GMSMarker alloc] init];
    musserMarker.position = CLLocationCoordinate2DMake(44.459934, -93.157050);
    musserMarker.title = @"Musser Hall";
    MapLocation *musser = [[MapLocation alloc]initWithLocation:@"Musser Hall" Coordinates:musserMarker];
    [_locationsList addObject:musser];
    
    // Myers Hall
    GMSMarker *myersMarker = [[GMSMarker alloc] init];
    myersMarker.position = CLLocationCoordinate2DMake(44.460721, -93.150870);
    myersMarker.title = @"Myers Hall";
    MapLocation *myers = [[MapLocation alloc]initWithLocation:@"Myers Hall" Coordinates:myersMarker];
    [_locationsList addObject:myers];
    
    // Nason House
    GMSMarker *nasonMarker = [[GMSMarker alloc] init];
    nasonMarker.position = CLLocationCoordinate2DMake(44.459740, -93.157676);
    nasonMarker.title = @"Nason House";
    MapLocation *nason = [[MapLocation alloc]initWithLocation:@"Nason House" Coordinates:nasonMarker];
    [_locationsList addObject:nason];
    
    // Nourse Hall
    GMSMarker *nourseMarker = [[GMSMarker alloc] init];
    nourseMarker.position = CLLocationCoordinate2DMake(44.460491, -93.152017);
    nourseMarker.title = @"Nourse Hall";
    MapLocation *nourse = [[MapLocation alloc]initWithLocation:@"Nourse Hall" Coordinates:nourseMarker];
    [_locationsList addObject:nourse];
    
    // Olin Hall
    GMSMarker *olinMarker = [[GMSMarker alloc] init];
    olinMarker.position = CLLocationCoordinate2DMake(44.461370, -93.152897);
    olinMarker.title = @"Olin Hall of Science";
    MapLocation *olin = [[MapLocation alloc]initWithLocation:@"Olin Hall" Coordinates:olinMarker];
    [_locationsList addObject:olin];
    
    // Owens House
    GMSMarker *owensMarker = [[GMSMarker alloc] init];
    owensMarker.position = CLLocationCoordinate2DMake(44.459443, -93.158074);
    owensMarker.title = @"Owens House";
    MapLocation *owens = [[MapLocation alloc]initWithLocation:@"Owens House" Coordinates:owensMarker];
    [_locationsList addObject:owens];
    
    // Page House
    GMSMarker *pageMarker = [[GMSMarker alloc] init];
    pageMarker.position = CLLocationCoordinate2DMake(44.457587, -93.155817);
    pageMarker.title = @"Page House (Jewish Interest)";
    MapLocation *page = [[MapLocation alloc]initWithLocation:@"Page House (Jewish Interest)" Coordinates:pageMarker];
    [_locationsList addObject:page];
    
    // Parish House
    GMSMarker *parishMarker = [[GMSMarker alloc] init];
    parishMarker.position = CLLocationCoordinate2DMake(44.457589, -93.154857);
    parishMarker.title = @"Parish House";
    MapLocation *parish = [[MapLocation alloc]initWithLocation:@"Parish House" Coordinates:parishMarker];
    [_locationsList addObject:parish];
    
    // Parr House
    GMSMarker *parrMarker = [[GMSMarker alloc] init];
    parrMarker.position = CLLocationCoordinate2DMake(44.466390, -93.149292);
    parrMarker.title = @"Parr House";
    MapLocation *parr = [[MapLocation alloc]initWithLocation:@"Parr House" Coordinates:parrMarker];
    [_locationsList addObject:parr];
    
    // Prentice House
    GMSMarker *prenticeMarker = [[GMSMarker alloc] init];
    prenticeMarker.position = CLLocationCoordinate2DMake(44.459940, -93.158371);
    prenticeMarker.title = @"Prentice House (Q&A House)";
    MapLocation *prentice = [[MapLocation alloc]initWithLocation:@"Prentice (Q&A) House" Coordinates:prenticeMarker];
    [_locationsList addObject:prentice];
    
    // Rec Center
    GMSMarker *recMarker = [[GMSMarker alloc] init];
    recMarker.position = CLLocationCoordinate2DMake(44.463985, -93.149614);
    recMarker.title = @"Recreation Center";
    MapLocation *rec = [[MapLocation alloc]initWithLocation:@"Rec Center" Coordinates:recMarker];
    [_locationsList addObject:rec];
    
    // Rice House
    GMSMarker *riceMarker = [[GMSMarker alloc] init];
    riceMarker.position = CLLocationCoordinate2DMake(44.457976, -93.155882);
    riceMarker.title = @"Rice House";
    MapLocation *rice = [[MapLocation alloc]initWithLocation:@"Rice House" Coordinates:riceMarker];
    [_locationsList addObject:rice];
    
    // Sayles Hill
    GMSMarker *saylesMarker = [[GMSMarker alloc] init];
    saylesMarker.position = CLLocationCoordinate2DMake(44.461259, -93.156159);
    saylesMarker.title = @"Sayles Hill";
    MapLocation *sayles = [[MapLocation alloc]initWithLocation:@"Sayles Hill" Coordinates:saylesMarker];
    [_locationsList addObject:sayles];
    
    // Scott House
    GMSMarker *scottMarker = [[GMSMarker alloc] init];
    scottMarker.position = CLLocationCoordinate2DMake(44.459825, -93.157787);
    scottMarker.title = @"Scott House";
    MapLocation *scott = [[MapLocation alloc]initWithLocation:@"Scott House" Coordinates:scottMarker];
    [_locationsList addObject:scott];
    
    // Scoville Hall
    GMSMarker *scovilleMarker = [[GMSMarker alloc] init];
    scovilleMarker.position = CLLocationCoordinate2DMake(44.460127, -93.155928);
    scovilleMarker.title = @"Scoville hall";
    MapLocation *scoville = [[MapLocation alloc]initWithLocation:@"Scoville Hall" Coordinates:scovilleMarker];
    [_locationsList addObject:scoville];
    
    // Severance Hall
    GMSMarker *severanceMarker = [[GMSMarker alloc] init];
    severanceMarker.position = CLLocationCoordinate2DMake(44.460972, -93.156760);
    severanceMarker .title = @"Severance Hall";
    MapLocation *severance = [[MapLocation alloc]initWithLocation:@"Severance Hall" Coordinates:severanceMarker];
    [_locationsList addObject:severance];
    
    // Softball Field
    GMSMarker *softballFieldMarker = [[GMSMarker alloc] init];
    softballFieldMarker.position = CLLocationCoordinate2DMake(44.465616, -93.146882);
    softballFieldMarker.title = @"Softball Field";
    MapLocation *softballField = [[MapLocation alloc]initWithLocation:@"Softball Field" Coordinates:softballFieldMarker];
    [_locationsList addObject:softballField];
    
    // Stimson House
    GMSMarker *stimsonMarker = [[GMSMarker alloc] init];
    stimsonMarker.position = CLLocationCoordinate2DMake(44.459488, -93.156788);
    stimsonMarker.title = @"Stimson House (Multicultural Center)";
    MapLocation *stimson = [[MapLocation alloc]initWithLocation:@"Stimson House (Multicultural Center)" Coordinates:stimsonMarker];
    [_locationsList addObject:stimson];
    
    // Strong House
    GMSMarker *strongMarker = [[GMSMarker alloc] init];
    strongMarker.position = CLLocationCoordinate2DMake(44.458728, -93.155846);
    strongMarker.title = @"Strong House";
    MapLocation *strong = [[MapLocation alloc]initWithLocation:@"Strong House" Coordinates:strongMarker];
    [_locationsList addObject:strong];
    
    // Watson Hall
    GMSMarker *watsonMarker = [[GMSMarker alloc] init];
    watsonMarker.position = CLLocationCoordinate2DMake(44.459390, -93.150524);
    watsonMarker.title = @"Watson Hall";
    MapLocation *watson = [[MapLocation alloc]initWithLocation:@"Watson Hall" Coordinates:watsonMarker];
    [_locationsList addObject:watson];
    
    // West Gym
    GMSMarker *westMarker = [[GMSMarker alloc] init];
    westMarker.position = CLLocationCoordinate2DMake(44.462856, -93.156925);
    westMarker.title = @"West Gym";
    MapLocation *westGym = [[MapLocation alloc]initWithLocation:@"West Gym" Coordinates:westMarker];
    [_locationsList addObject:westGym];
    
    // Weitz Center
    GMSMarker *weitzMarker = [[GMSMarker alloc] init];
    weitzMarker.position = CLLocationCoordinate2DMake(44.457037, -93.156035);
    weitzMarker.title = @"Weitz Center";
    MapLocation *weitz = [[MapLocation alloc]initWithLocation:@"Weitz Center" Coordinates:weitzMarker];
    [_locationsList addObject:weitz];
    
    // Williams House
    GMSMarker *williamsMarker = [[GMSMarker alloc] init];
    williamsMarker.position = CLLocationCoordinate2DMake(44.459111, -93.156947);
    williamsMarker .title = @"Williams House (Freedom House)";
    MapLocation *williams = [[MapLocation alloc]initWithLocation:@"Williams (Freedom) House" Coordinates:williamsMarker];
    [_locationsList addObject:williams];
    
    // Willis Hall
    GMSMarker *willisMarker = [[GMSMarker alloc] init];
    willisMarker.position = CLLocationCoordinate2DMake(44.460735, -93.155987);
    willisMarker .title = @"Willis Hall";
    MapLocation *willis = [[MapLocation alloc]initWithLocation:@"Willis Hall" Coordinates:willisMarker];
    [_locationsList addObject:willis];
    
    // Wilson House
    GMSMarker *wilsonMarker = [[GMSMarker alloc] init];
    wilsonMarker.position = CLLocationCoordinate2DMake(44.460252, -93.158135);
    wilsonMarker.title = @"Wilson House";
    MapLocation *wilson = [[MapLocation alloc]initWithLocation:@"Wilson House" Coordinates:wilsonMarker];
    [_locationsList addObject:wilson];

    
    
    
    return [_locationsList count];
}


- (LocationTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.locationLabel.text = [[_locationsList objectAtIndex:indexPath.row] maplocation];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MapLocation *selectedLocation = [_locationsList objectAtIndex:[indexPath row]];
    
   
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel track:@"Map Location Choice" properties:@{
                                                      @"Location Name": [selectedLocation maplocation]
                                                      }];

    [self.delegate addItemViewController:self didFinishEnteringItem:selectedLocation];
    [self dismissModalViewControllerAnimated:YES];
}
    
    
    



@end
