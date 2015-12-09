//
//  PersonViewController.m
//  MMVCTest
//
//  Created by Wen Tan on 12/8/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "Person.h"
#import "PersonViewController.h"

@interface PersonViewController ()

@property (nonatomic, strong) Person *personModel;

@end

@implementation PersonViewController

- (IBAction)updateLabel:(UIButton *)sender {
	//update UI
	self.salutaionLabel.text = self.personModel.salutation;
	self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.personModel.lastname, self.personModel.firstname];
	self.birthLabel.text = [NSString stringWithFormat:@"%@", self.personModel.birthDate];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	//convert String to NSdate format
	NSString *stringDate = @"08/01/1994";
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MM/dd/yyyy"];
	NSDate *myBirth = [dateFormatter dateFromString:stringDate];
	NSLog(@"My birthday is %@",myBirth);
	
	//Configure person model
	self.personModel = [[Person alloc] initWithSalutation:@"Tank"
												firstname:@"Wen"
												 lastname:@"Tan"
												birthDate:myBirth];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
