//
//  PickViewHelperViewController.m
//  CoreDataTest
//
//  Created by Wen Tan on 12/28/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//
#import "ChoreMO.h"
#import "PersonMO.h"
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

//- (NSString *)getObjectName:(id )myObject {
//	
//	if ([myObject isKindOfClass:[ChoreMO class]]) {
//		ChoreMO *choreMO = myObject;
//		return choreMO.chore_name;
//	}else if ([myObject isKindOfClass:[PersonMO class]]){
//		PersonMO *personMO = myObject;
//		return personMO.name;
//	}else {
//		return @"Error";
//	}
//}

- (instancetype)init {
	self = [super init];
	if (!self) {
		return nil;
	}
	self.pickerData = [NSMutableArray arrayWithArray:@[]];
	return self;
}

#pragma mark - PickView delegate

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [self.pickerData count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [self.pickerData[row] description];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
}

#pragma mark - PickerView Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
