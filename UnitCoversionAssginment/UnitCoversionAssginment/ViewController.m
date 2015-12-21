//
//  ViewController.m
//  UnitCoversionAssginment
//
//  Created by Wen Tan on 12/21/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController




- (double)convertUnitOldValue:(double)value atIndex:(NSInteger)index {
	double newValue = 0.0;
	switch (index) {
		case 0:
			// m to cm
			newValue = value * 100;
			break;
		case 1:
			// m to ft
			newValue = value * 3.2808399;
			break;
		case 2:
			// m to inch
			newValue = value * 39.3700787;
			break;
	}
	
	return newValue;
}
- (IBAction)convertNumber:(UIButton *)sender {

	double newValue = [self convertUnitOldValue:[self.inputField.text doubleValue]
										atIndex:self.segmentControl.selectedSegmentIndex];
	
	NSMutableString *str = [NSMutableString new];
	//convert value to string one
	[str appendString:[@(newValue) stringValue]];
	[str appendString:@" "];
	// get segmentControl title for unit
	[str appendString:[self.segmentControl
					   titleForSegmentAtIndex:self.segmentControl.selectedSegmentIndex]];
	self.resultLabel.text = str;

}


- (void)viewDidLoad {
	[super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.segmentControl.layer.cornerRadius = 8;
	self.segmentControl.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
