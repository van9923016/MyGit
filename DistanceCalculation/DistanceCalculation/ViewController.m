//
//  ViewController.m
//  DistanceCalculation
//
//  Created by Wen Tan on 12/22/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "ViewController.h"
#import <DistanceGetter/DGDistanceRequest.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField		*myLocation;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UIButton			*caculateBtn;
@property (weak, nonatomic) IBOutlet UITextField		*locationA;
@property (weak, nonatomic) IBOutlet UITextField		*locationB;
@property (weak, nonatomic) IBOutlet UITextField		*locationC;
@property (weak, nonatomic) IBOutlet UITextField		*locationD;
@property (weak, nonatomic) IBOutlet UILabel			*labelA;
@property (weak, nonatomic) IBOutlet UILabel			*labelB;
@property (weak, nonatomic) IBOutlet UILabel			*labelC;
@property (weak, nonatomic) IBOutlet UILabel			*labelD;

@property (strong, nonatomic) DGDistanceRequest			*distanceRequest;

@end

@implementation ViewController

// make round shape
- (void)configureViewsWithLayer:(CALayer *)layer radius:(float)radius {
	layer.cornerRadius	= radius;
	layer.masksToBounds = YES;
}
- (IBAction)caculateBtnPressed:(UIButton *)sender {
	self.caculateBtn.enabled = NO;
	NSString *myLoc = self.myLocation.text;
	
	NSString *locA	= self.locationA.text;
	NSString *locB	= self.locationB.text;
	NSString *locC	= self.locationC.text;
	NSString *locD	= self.locationD.text;
	NSArray *locations = @[locA, locB, locC, locD];
	
	self.distanceRequest = [[DGDistanceRequest alloc] initWithLocationDescriptions:locations
																 sourceDescription:myLoc];
	__weak ViewController *weakSelf = self;
	self.distanceRequest.callback = ^void(NSArray *responses){
		
		ViewController *strongSelf = weakSelf;
		if (!strongSelf) return;
		
		NSNull *badResult = [NSNull null];
		
		//LocationA Distance Label
		if (responses[0] != badResult) {
			NSLog(@"%f", [responses[0] floatValue]);
			double num = [responses[0] floatValue];
			switch (strongSelf.segment.selectedSegmentIndex) {
					
				case 0:
					strongSelf.labelA.text = [NSString stringWithFormat:@"%.2f m", num];
					break;
				case 1:
					num = num / 1000.0;
					strongSelf.labelA.text = [NSString stringWithFormat:@"%.2f km", num];
					break;
				case 2:
					num = num * 0.0006214;
					strongSelf.labelA.text = [NSString stringWithFormat:@"%.2f miles", num];
					break;
			}
		}else{
			//if bad result put err in label
			strongSelf.labelA.text = @"err";
		}
		
		//LocationB Distance Label
		if (responses[1] != badResult) {
			double num = 1.0 * [responses[1] floatValue];
			
			switch (strongSelf.segment.selectedSegmentIndex) {
					
				case 0:
					num = num;
					strongSelf.labelB.text = [NSString stringWithFormat:@"%.2f m", num];
					break;
				case 1:
					num = num / 1000.0;
					strongSelf.labelB.text = [NSString stringWithFormat:@"%.2f km", num];
					break;
				case 2:
					num = num * 0.00062137;
					strongSelf.labelB.text = [NSString stringWithFormat:@"%.2f miles", num];
					break;
			}
		}else{
			strongSelf.labelB.text = @"err";
		}
		
		//LocationC Distance Label
		if (responses[2] != badResult) {
			double num = 1.0 * [responses[2] floatValue];
			switch (strongSelf.segment.selectedSegmentIndex) {
					
				case 0:
					num = num;
					strongSelf.labelC.text = [NSString stringWithFormat:@"%.2f m", num];
					break;
				case 1:
					num = num / 1000.0;
					strongSelf.labelC.text = [NSString stringWithFormat:@"%.2f km", num];
					break;
				case 2:
					num = num * 0.00062137;
					strongSelf.labelC.text = [NSString stringWithFormat:@"%.2f miles", num];
					break;
			}
		}else{
			strongSelf.labelC.text = @"err";
		}
		
		//LocationD Distance Label
		if (responses[3] != badResult) {
			double num = 1.0 * [responses[3] floatValue];
			switch (strongSelf.segment.selectedSegmentIndex) {
					
				case 0:
					num = num;
					strongSelf.labelD.text = [NSString stringWithFormat:@"%.2f m", num];
					break;
				case 1:
					num = num / 1000.0;
					strongSelf.labelD.text = [NSString stringWithFormat:@"%.2f km", num];
					break;
				case 2:
					num = num * 0.00062137;
					strongSelf.labelD.text = [NSString stringWithFormat:@"%.2f miles", num];
					break;
			}
		}else{
			strongSelf.labelD.text = @"err";
		}
	};
	
	[self.distanceRequest start];
	self.caculateBtn.enabled = YES;
}



- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	NSArray *array = @[self.myLocation.layer,self.segment.layer, self.locationA.layer, self.locationB.layer, self.locationC.layer];
	
	NSArray *newArr = @[self.caculateBtn.layer, self.labelA.layer, self.labelB.layer, self.labelC.layer];
	
	for (id object in array) {
		[self configureViewsWithLayer:object radius:8.0];
	}
	
	for (id object in newArr) {
		[self configureViewsWithLayer:object radius:5.0];
	}
	
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
