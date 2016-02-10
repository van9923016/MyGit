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

//static const NSUInteger distancScale = 5000;

@interface ViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, copy) NSArray *locationArray;
@property (weak, nonatomic) IBOutlet UINavigationItem *navController;
@property (strong, nonatomic) CLLocationManager *locationManager;


@end

@implementation ViewController

#pragma mark - Basic data initialize
- (void)showLocationFromTag:(NSUInteger)tag {
	TWLocation *taggedLocation = self.locationArray[tag];
	self.navController.title = taggedLocation.name;
	
	MKPointAnnotation *myColleage = [[MKPointAnnotation alloc] init];
	myColleage.coordinate = CLLocationCoordinate2DMake(taggedLocation.latitude, taggedLocation.longitude);
	myColleage.title = taggedLocation.name;
	myColleage.subtitle = taggedLocation.details;
//	[self.mapView removeAnnotations:self.mapView.annotations];
	//remove duplicate annotation
	[self.mapView.annotations enumerateObjectsUsingBlock:^(id<MKAnnotation>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		MKPointAnnotation *annotation = obj;
		if ([annotation.title isEqualToString:myColleage.title]) {
			[self.mapView removeAnnotation:obj];
		}
	}];

	[self.mapView addAnnotation:myColleage];
	self.mapView.centerCoordinate = myColleage.coordinate;

}

//Initial location data
- (NSMutableArray *)createLocationExample {
	TWLocation *myColleage = [[TWLocation alloc] initWithName:@"天安门" details:@"北京天安门广场" latitude:39.9087461 longitude:116.3798794];
	TWLocation *trainStaion = [[TWLocation alloc] initWithName:@"东方明珠" details:@"东方明珠电视塔" latitude:31.2396935 longitude:121.4975666];
	TWLocation *anqingXiStation = [[TWLocation alloc] initWithName:@"西湖" details:@"浙江杭州西湖风景区" latitude:30.2430814 longitude:120.1258992];
	return [NSMutableArray arrayWithObjects:myColleage,trainStaion,anqingXiStation, nil];
}
//lazy loading of location data
- (NSArray *)locationArray {
	if (!_locationArray) {
		_locationArray = [NSArray arrayWithArray:[self createLocationExample]];
	}
	return _locationArray;
}

- (CLLocationManager *)locationManager {
	if (!_locationManager) {
		_locationManager = [[CLLocationManager alloc] init];
		_locationManager.delegate = self;
	}
	return _locationManager;
}


#pragma mark - Toolbar action
- (IBAction)toolBarButtonPressed:(UIButton *)sender {
	[self showLocationFromTag:sender.tag];
}

- (IBAction)switchButtonPressed:(UISwitch *)sender {
	
	self.mapView.showsUserLocation = sender.isOn;
	if (sender.isOn) {
		self.navController.title = self.mapView.userLocation.title;
		
		[self.locationManager requestAlwaysAuthorization];
		[self.locationManager startUpdatingLocation];
		[self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
		
	}else{
		self.navController.title = @"Basic Map";
		[self.locationManager stopUpdatingLocation];
	}
}

#pragma mark - View life cycle
- (void)viewDidLoad {
	[super viewDidLoad];
	self.mapView.delegate = self;
//	CLLocationCoordinate2D noLocation;
//	MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, distancScale, distancScale);
//	MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
//	[self.mapView setRegion:adjustedRegion animated:YES];
	
	//show default location
	[self showLocationFromTag:0];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

#pragma mark - CLLocationManager Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
	[self.mapView setCenterCoordinate:locations.firstObject.coordinate animated:YES];
}
@end
