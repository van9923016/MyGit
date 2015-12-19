//
//  ViewController.m
//  MyInsPhoto
//
//  Created by Wen Tan on 12/19/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIBarButtonItem	*loginBtn;
@property (nonatomic, weak) IBOutlet UIBarButtonItem	*logOutBtn;
@property (nonatomic, weak) IBOutlet UIButton			*refreshBtn;
@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentControl;
@property (nonatomic, weak) IBOutlet UILabel			*insLabel;
@property (nonatomic, weak) IBOutlet UIImageView		*insImageView;


@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (IBAction)loginIns:(UIBarButtonItem *)sender {
	
}

- (IBAction)logoutIns:(UIBarButtonItem *)sender {
	
}

- (IBAction)refreshInsImage:(UIButton *)sender {
	
}

- (IBAction)segmentChanged:(UISegmentedControl *)sender {
	switch (sender.selectedSegmentIndex) {
		case 0:
			self.insImageView.contentMode = UIViewContentModeScaleToFill;
			break;
		case 1:
			self.insImageView.contentMode = UIViewContentModeScaleAspectFit;
			break;
		case 2:
			self.insImageView.contentMode = UIViewContentModeScaleAspectFill;
			break;
	}
}

@end
