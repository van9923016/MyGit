//
//  ViewController.m
//  testForKVC
//
//  Created by Wen Tan on 1/28/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "ViewController.h"
#import "Product.h"

@interface ViewController ()
@property (nonatomic, copy) NSArray *data;
@property (nonatomic, copy) NSArray *data2;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self createExample];
	//Key-Value Coding
	
	//Simple Collection Operators
	[self simpleCollectionOperatorExample];
	
	//Objects operators
	[self objectOperatorExample];
	
	//Array operators
	[self arrayOperatorExample];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Create Data Example
- (void)createExample {
	NSString *iPodDate = @"23-Oct-2001";
	NSString *iPhoneDate = @"29-June-2007";
	NSString *iPadDate = @"7-March-2012";
	NSString *appleWatchDate = @"19-Feb-2015";
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = @"dd-MM-yy";
	Product *iPod = [[Product alloc] initWithName:@"iPod" price:365.0 launchedDate:[dateFormatter dateFromString:iPodDate]];
	Product *iPhone = [[Product alloc] initWithName:@"iPhone" price:5088.0 launchedDate:[dateFormatter dateFromString:iPhoneDate]];
	Product *iPad = [[Product alloc] initWithName:@"iPad" price:4888.0 launchedDate:[dateFormatter dateFromString:iPadDate]];
	Product *appleWatch = [[Product alloc] initWithName:@"appleWatch" price:3888.0 launchedDate:[dateFormatter dateFromString:appleWatchDate]];
	
	self.data = @[iPod,iPhone,iPhone,iPad];
	self.data2 = @[iPad, iPhone, appleWatch];
	
}

#pragma mark - Simple Collection Operator 
- (void)simpleCollectionOperatorExample {
	//Sum value
	NSLog(@"%@",[self.data valueForKeyPath:@"@sum.price"]);
	//Average value
	NSLog(@"%@",[self.data valueForKeyPath:@"@avg.price"]);
	//Min value
	NSLog(@"%@",[self.data valueForKeyPath:@"@min.price"]);
	//Max value
	NSLog(@"%f", [[self.data valueForKeyPath:@"@max.price"] doubleValue]);
	
	//Count of array,id type returned
	NSLog(@"%@", [self.data valueForKeyPath:@"@count"]);
	//min date
	NSLog(@"%@", [self.data valueForKeyPath:@"@min.launchedOn"]);
}

#pragma mark - Object Operator Example
- (void)objectOperatorExample {
	//unionOfObjects
	NSLog(@"%@",[self.data valueForKeyPath:@"@unionOfObjects.name"]);
	
	//distinctUnionObjects: kick out duplicate objects in array
	NSLog(@"%@",[self.data valueForKeyPath:@"@distinctUnionOfObjects.name"]);
}

#pragma mark - Array Operator Example
- (void)arrayOperatorExample {
	//show in array list
	NSLog(@"%@", [@[self.data, self.data2] valueForKeyPath:@"@unionOfObjects.name"]);
	NSLog(@"%@", [@[self.data, self.data2] valueForKeyPath:@"@distinctUnionOfObjects.name"]);
	
}

@end
