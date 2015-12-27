//
//  ViewController.m
//  UIKitTest
//
//  Created by Wen Tan on 12/27/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()



@property (weak, nonatomic) IBOutlet UILabel                 *myLabel;
@property (weak, nonatomic) IBOutlet UIImageView             *myImgView;
@property (weak, nonatomic) IBOutlet UITextField             *myTextfield;
@property (weak, nonatomic) IBOutlet UISlider                *mySlider;
@property (weak, nonatomic) IBOutlet UIButton                *myButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIProgressView          *progressView;
@property (weak, nonatomic) IBOutlet UIStepper               *stepper;
@property (weak, nonatomic) IBOutlet UILabel				 *stepperCount;
@property (weak, nonatomic) IBOutlet UISwitch                *switchBtn;
@property (weak, nonatomic) IBOutlet UISegmentedControl      *segment;

@end

@implementation ViewController


- (IBAction)changeButtonPressed:(UIButton *)sender {
	self.myLabel.text = self.myTextfield.text;
	
}

- (void)sliderValueChanged {
	self.myImgView.alpha = self.mySlider.value;
	self.indicator.hidden = NO;
	[self.indicator startAnimating];
}

- (void)stepperValueChanged {
	self.stepperCount.text = [NSString stringWithFormat:@"%d",(int)self.stepper.value];
}
- (IBAction)switchButtonPressed:(UISwitch *)sender {
	self.myButton.enabled = sender.on;
}
- (IBAction)stepperPressed:(UIStepper *)sender {
	
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.mySlider addTarget:self action:@selector(sliderValueChanged) forControlEvents:UIControlEventValueChanged];
	[self.stepper addTarget:self action:@selector(stepperValueChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.indicator.hidden = YES;
	self.myImgView.layer.cornerRadius = 8.0;
	self.myImgView.layer.masksToBounds = YES;
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
