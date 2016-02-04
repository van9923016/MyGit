//
//  ViewController.m
//  BasicMap
//
//  Created by Wen Tan on 2/4/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "ViewController.h"
#import "TWLocation.h"
@import MapKit;

@interface ViewController ()<MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, copy) NSArray *locationArray;

@end

@implementation ViewController

#pragma mark - Basic data initialize
//Default location annotation
- (void)showDefaultLocationAnnotation {
	//1.make default map annotation:South China Argriculture Univercity
	//same as first toolbar pressed
	TWLocation *colleageLoc = self.locationArray[0];
	MKPointAnnotation *myColleage = [[MKPointAnnotation alloc] init];
	myColleage.coordinate = CLLocationCoordinate2DMake(colleageLoc.latitude, colleageLoc.longitude);
	myColleage.title = colleageLoc.name;
	myColleage.subtitle = colleageLoc.details;
	[self.mapView addAnnotation:myColleage];
	self.mapView.centerCoordinate = myColleage.coordinate;
}
//Initial location data
- (NSMutableArray *)createLocationExample {
	TWLocation *myColleage = [[TWLocation alloc] initWithName:@"SCAU" details:@"South China Argriculture Univercity" latitude:23.1553899 longitude:113.3514445];
	TWLocation *trainStaion = [[TWLocation alloc] initWithName:@"广州火车东站" details:@"Guangzhou East Railway station" latitude:23.1554333 longitude:113.3361236];
	TWLocation *anqingXiStation = [[TWLocation alloc] initWithName:@"安庆西火车站" details:@"AnQingXi train station" latitude:30.7615456 longitude:116.8173543];
	return [NSMutableArray arrayWithObjects:myColleage,trainStaion,anqingXiStation, nil];
}
//lazy loading of location data
- (NSArray *)locationArray {
	if (!_locationArray) {
		_locationArray = [NSArray arrayWithArray:[self createLocationExample]];
	}
	return _locationArray;
}

#pragma mark - Toolbar action
- (IBAction)toolBarButtonPressed:(id)sender {
	
}

- (IBAction)switchButtonPressed:(id)sender {

}

#pragma mark - View life cycle
- (void)viewDidLoad {
	[super viewDidLoad];
	self.mapView.delegate = self;
	[self showDefaultLocationAnnotation];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
