//
//  TWDetailViewController.m
//  TWComponent
//
//  Created by Wen Tan on 4/12/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "TWDetailViewController.h"
#import <HandyFrame/UIView+LayoutMethods.h>

@interface TWDetailViewController ()

@property (nonatomic, strong, readwrite) UILabel *valueLabel;
@property (nonatomic, strong, readwrite) UIImageView *imageView;
@property (nonatomic, strong)			 UIButton *returnButton;

@end

@implementation TWDetailViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor grayColor];
	[self.view addSubview:self.valueLabel];
	[self.view addSubview:self.imageView];
	[self.view addSubview:self.returnButton];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.valueLabel sizeToFit];
	[self.valueLabel topInContainer:70.f shouldResize:NO];
	[self.valueLabel centerXEqualToView:self.view];
	
	self.imageView.size = CGSizeMake(300, 300);
	[self.imageView centerXEqualToView:self.view];
	[self.imageView centerYEqualToView:self.view];
	
	self.returnButton.size = CGSizeMake(100, 100);
	[self.returnButton bottomInContainer:20 shouldResize:NO];
	[self.returnButton centerXEqualToView:self.view];
	
}


- (void)didTappedReturnButton:(UIButton *)button {
	if (!self.navigationController) {
		[self dismissViewControllerAnimated:YES completion:nil];
	} else {
		[self.navigationController popViewControllerAnimated:YES];
	}
}

#pragma mark - Setters and Getters

- (UILabel *)valueLabel {
	if (!_valueLabel) {
		_valueLabel = [[UILabel alloc] init];
		_valueLabel.font = [UIFont systemFontOfSize:30];
		_valueLabel.textColor = [UIColor blackColor];
	}
	return _valueLabel;
}

- (UIImageView *)imageView {
	if (!_imageView) {
		_imageView = [[UIImageView alloc] init];
		_imageView.contentMode = UIViewContentModeScaleAspectFit;
	}
	return _imageView;
}

- (UIButton *)returnButton {
	if (!_returnButton) {
		_returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[_returnButton addTarget:self action:@selector(didTappedReturnButton:) forControlEvents:UIControlEventTouchUpInside];
	}
	[_returnButton setTitle:@"Return" forState:UIControlStateNormal];
	[_returnButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	return _returnButton;
}


@end
