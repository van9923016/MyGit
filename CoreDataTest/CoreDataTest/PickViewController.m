//
//  PickViewHelperViewController.m
//  CoreDataTest
//
//  Created by Wen Tan on 12/28/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//
#import "ChoreMO.h"
#import "PickViewController.h"

@interface PickViewController ()

@property (nonatomic, copy) NSMutableArray *pickerData;

@end

@implementation PickViewController

//Helper method to set pickerData
- (void)setArray:(NSArray *)incoming {
	self.pickerData = [NSMutableArray arrayWithArray:incoming];
}

- (void) addItemToArray:(NSObject *)thing {
	[self.pickerData addObject:thing];
}

- (NSObject *)getItemFromArray:(NSUInteger)index {
	return [self.pickerData objectAtIndex:index];
}


- (instancetype)init {
	self = [super init];
	if (!self) {
		return nil;
	}
	self.pickerData = [NSMutableArray arrayWithArray:@[]];
	return self;
}

#pragma mark - UIPickView delegate

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [self.pickerData count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	ChoreMO *choreMO = self.pickerData[row];
	if (choreMO) {
		return choreMO.chore_name;
	}
	return @"Error";
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}


#pragma mark - PickerView Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
