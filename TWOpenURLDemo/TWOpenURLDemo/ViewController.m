//
//  ViewController.m
//  TWOpenURLDemo
//
//  Created by Wen Tan on 4/23/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

#pragma mark - Actions

- (void)buttonClicked {
	NSURL *safariURL = [NSURL URLWithString:@"https://www.apple.com"];
	NSURL *chromeURL = [NSURL URLWithString:@"googleChromes://www.apple.com"];
	
	if ([[UIApplication sharedApplication] canOpenURL:chromeURL]) {
		[[UIApplication sharedApplication] openURL:chromeURL];
	} else {
		UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"未安装Chrome" message:@"点击确定将使用Safari打开网页" preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
			NSLog(@"User pressed cancel!");
		}];
		UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
			[[UIApplication sharedApplication] openURL:safariURL];
		}];
		[alertVC addAction:cancelAction];
		[alertVC addAction:doneAction];
		[self presentViewController:alertVC animated:YES completion:nil];
	}
}




#pragma mark - Life cycles
- (void)viewDidLoad {
	[super viewDidLoad];
	[self.view addSubview:self.button];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


#pragma mark - Layout Views

-(void)updateViewConstraints {
	
	 [self.button mas_makeConstraints:^(MASConstraintMaker *make){
		 make.center.equalTo(self.view);
	 }];
	[super updateViewConstraints];
}

#pragma mark - Getters and Setters

- (UIButton *)button {
	if (!_button) {
		_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[_button setTitle:@"Click to open" forState:UIControlStateNormal];
		[_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		_button.titleLabel.font = [UIFont systemFontOfSize:20.f];
		[_button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
	}
	return _button;
}

@end
