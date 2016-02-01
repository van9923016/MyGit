//
//  ViewController.m
//  TestForNSSortDescriptor
//
//  Created by Wen Tan on 2/1/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)createExample {
	NSArray *firstNames = @[@"Alice", @"Bob", @"Selina", @"Chuck"];
	NSArray *lastNames = @[@"Smith",@"Jones",@"Smith",@"Alberts"];
	NSArray *ages = @[@21,@13,@11,@33];
	NSMutableArray *people = [NSMutableArray array];
	
	[firstNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		Person *person = [[Person alloc] init];
		person.firstName = [firstNames objectAtIndex:idx];
		person.lastName = [lastNames objectAtIndex:idx];
		person.age = [ages objectAtIndex:idx];
		[people addObject:person];
	}];
	
	NSSortDescriptor *firstNameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES selector:@selector(localizedStandardCompare:)];
	NSSortDescriptor *lastNameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES selector:@selector(localizedStandardCompare:)];
	NSSortDescriptor *ageSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
	
	NSLog(@"By firstName ascending order: %@",[people sortedArrayUsingDescriptors:@[firstNameSortDescriptor]]);
	NSLog(@"By lastName ascending order: %@",[people sortedArrayUsingDescriptors:@[lastNameSortDescriptor]]);
	NSLog(@"By age %@",[people sortedArrayUsingDescriptors:@[ageSortDescriptor]]);
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self createExample];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
