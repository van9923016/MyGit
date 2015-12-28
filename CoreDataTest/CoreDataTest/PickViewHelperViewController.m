//
//  PickViewHelperViewController.m
//  CoreDataTest
//
//  Created by Wen Tan on 12/28/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "PickViewHelperViewController.h"

@interface PickViewHelperViewController ()

@property (nonatomic, copy) NSMutableArray *pickerData;

@end

@implementation PickViewHelperViewController

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




#pragma mark - PickerView Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
