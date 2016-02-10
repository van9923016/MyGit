//
//  ViewController.m
//  C02Constraints
//
//  Created by Wen Tan on 2/10/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor redColor];
	self.button = [[UIButton alloc] init];
	[self.button setTitle:@"Log in" forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {
	self.button.translatesAutoresizingMaskIntoConstraints = NO;
	self.button.layer.cornerRadius = 8.0;
	self.button.backgroundColor = [UIColor blackColor];
	//center Y
	NSLayoutConstraint *logBtnYConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY  multiplier:1.0 constant:0];
	//center X
	NSLayoutConstraint *logBtnXConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX  multiplier:1.0 constant:0];
	//button width 70
	NSLayoutConstraint *logBtnWidth = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:70.f];
	//button height 70
	NSLayoutConstraint *logBtnHeight = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:70.f];
	[self.view addSubview:self.button];
	[self.view addConstraint:logBtnXConstraint];
	[self.view addConstraint:logBtnYConstraint];
	[self.view addConstraint:logBtnWidth];
	[self.view addConstraint:logBtnHeight];
	NSLog(@"%@",[self.view.subviews description]);
}

- (void)viewWillLayoutSubviews {

}
- (void)viewDidLayoutSubviews {
	
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
