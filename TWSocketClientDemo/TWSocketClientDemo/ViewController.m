//
//  ViewController.m
//  TWSocketClientDemo
//
//  Created by Wen Tan on 4/24/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

@interface ViewController ()<NSStreamDelegate>

@property (nonatomic, strong) UITextField *nicknameField;
@property (nonatomic, strong) UIButton *joinButton;
@property (nonatomic, strong) NSInputStream *inputStream;
@property (nonatomic, strong) NSOutputStream *outputStream;


@end

@implementation ViewController

#pragma mark - Private Methods

- (void)initNetworkCommunication {
	CFReadStreamRef readStream;
	CFWriteStreamRef writeStream;
	CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"localhost", 82, &readStream, &writeStream);
	self.inputStream = (__bridge NSInputStream *)readStream;
	self.outputStream = (__bridge NSOutputStream *)writeStream;
	
	// set network stream delegate to self
	self.inputStream.delegate = self;
	self.outputStream.delegate = self;
	
	//set run loop for stream, avoid block other code
	[self.inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[self.outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[self.inputStream open];
	[self.outputStream open];
	
}

#pragma mark - Actions

- (void)joinButtonPressed {
	
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.view addSubview:self.nicknameField];
	[self.view addSubview:self.joinButton];
	
	//init stream
	[self initNetworkCommunication];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	
}

#pragma mark - Layout SubViews

- (void)updateViewConstraints {
	//1. joinbutton layout
	 [self.joinButton mas_makeConstraints:^(MASConstraintMaker *make){
		 make.center.equalTo(self.view);
	 
	 }];
	//2.nicknameField layout
	// offset 左负右正上负下正，基于参考 view 而言

	[self.nicknameField mas_makeConstraints:^(MASConstraintMaker *make){
		make.height.equalTo(self.joinButton.mas_height).multipliedBy(1.5);
		make.centerX.equalTo(self.view);
		make.bottom.equalTo(self.joinButton.mas_top).with.offset(-20);
		make.left.equalTo(self.view.mas_left).with.offset(20);
		make.right.equalTo(self.view.mas_right).with.offset(-20);
	}];
	
	[super updateViewConstraints];
}


#pragma mark - Getters And Setters

- (UITextField *)nicknameField {
	if (!_nicknameField) {
		_nicknameField = [[UITextField alloc] init];
		[_nicknameField setBorderStyle:UITextBorderStyleRoundedRect];
		[_nicknameField setPlaceholder:@"Enter Your nickname"];
	}
	return _nicknameField;
}

- (UIButton *)joinButton {
	if (!_joinButton) {
		_joinButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[_joinButton setTitle:@"Join" forState:UIControlStateNormal];
		[_joinButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
		[_joinButton addTarget:self action:@selector(joinButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	}
	return _joinButton;
}

@end

