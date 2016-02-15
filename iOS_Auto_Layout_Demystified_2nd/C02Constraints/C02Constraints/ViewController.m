//
//  ViewController.m
//  C02Constraints
//
//  Created by Wen Tan on 2/10/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#define PREPCONSTRAINTS(VIEW) [VIEW setTranslatesAutoresizingMaskIntoConstraints:NO]

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *aView;
@property (nonatomic, strong) UIView *bView;
@property (nonatomic, strong) UILabel *myLabel;


@end

@implementation ViewController

- (void)configureView {
	self.view.backgroundColor = [UIColor redColor];
	
	self.button = [[UIButton alloc] init];
	self.button.backgroundColor = [UIColor blackColor];
	[self.button setTitle:@"Log in" forState:UIControlStateNormal];
	//Using Macro simplify view setting
	PREPCONSTRAINTS(self.button);
	self.button.layer.cornerRadius = 8.0;
	self.myLabel = [[UILabel alloc] init];
	PREPCONSTRAINTS(self.myLabel);
	self.myLabel.text = @"Add constraints and Visual format way layout";
	
	self.aView = [[UIView alloc] init];
	self.bView = [[UIView alloc] init];
	self.aView.backgroundColor = [UIColor blueColor];
	self.bView.backgroundColor = [UIColor purpleColor];
	PREPCONSTRAINTS(self.aView);
	PREPCONSTRAINTS(self.bView);
	
	[self.view addSubview:self.button];
	[self.view addSubview:self.aView];
	[self.view addSubview:self.bView];
	[self.view addSubview:self.myLabel];
}
- (void)buttonLayout {
	
	//center Y
	NSLayoutConstraint *logBtnYConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY  multiplier:1.0 constant:0];
	//center X
	NSLayoutConstraint *logBtnXConstraint = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX  multiplier:1.0 constant:0];
	//button width 70
	NSLayoutConstraint *logBtnWidth = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:70.f];
	//button height 70
	NSLayoutConstraint *logBtnHeight = [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:70.f];
	
	[self.view addConstraint:logBtnXConstraint];
	[self.view addConstraint:logBtnYConstraint];
	[self.view addConstraint:logBtnWidth];
	[self.view addConstraint:logBtnHeight];
	
	//aView and bView constraint
	
	NSLayoutConstraint *aViewHeight = [NSLayoutConstraint constraintWithItem:self.aView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
	NSLayoutConstraint *aViewWidth = [NSLayoutConstraint constraintWithItem:self.aView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
	
	NSLayoutConstraint *bViewHeight = [NSLayoutConstraint constraintWithItem:self.bView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.aView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
	NSLayoutConstraint *bViewWidth = [NSLayoutConstraint constraintWithItem:self.bView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.aView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];

	[self.aView addConstraint:aViewHeight];
	[self.aView addConstraint:aViewWidth];
	[self.view addConstraint:bViewHeight];
	[self.view addConstraint:bViewWidth];
}
- (void)visualFormatLayout {
	
	//visual format cosntraint
	NSArray *viewGap = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_aView]-15-[_bView]"options:NSLayoutFormatAlignAllLeading metrics:nil views:NSDictionaryOfVariableBindings(_aView,_bView)];
	
	NSArray *viewVerticalGap = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_button]-15-[_aView]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:NSDictionaryOfVariableBindings(_button,_aView)];
	
	[self.view addConstraints:viewGap];
	[self.view addConstraints:viewVerticalGap];
	
	//UILabel constraints
	NSArray *labelHLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_myLabel]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_myLabel)];
	NSArray *labelVLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[_myLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_myLabel)];
	[self.view addConstraints:labelHLayout];
	[self.view addConstraints:labelVLayout];
	

	
}
- (void)viewDidLoad {
	[super viewDidLoad];
	[self configureView];
}

- (void)viewWillAppear:(BOOL)animated {
	[self buttonLayout];
	[self visualFormatLayout];
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
