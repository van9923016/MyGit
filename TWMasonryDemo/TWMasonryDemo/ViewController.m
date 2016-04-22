//
//  ViewController.m
//  TWMasonryDemo
//
//  Created by Wen Tan on 4/22/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "ViewController.h"
#import <HandyFrame/UIView+LayoutMethods.h>
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) UIView *aView;
@property (nonatomic, strong) UIView *bView;
@property (nonatomic, strong) UILabel *aLabel;

@end

@implementation ViewController



#pragma mark - Life Cycles

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor grayColor];
	[self.view addSubview:self.aView];
	[self.view addSubview:self.bView];
	[self.view addSubview:self.aLabel];
	
	//layout subviews
	[self layoutSubviews];
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	
}

#pragma mark - Layout View

- (void)layoutSubviews {
	//1.aView layout
	UIEdgeInsets paddingA = UIEdgeInsetsMake(10, 10, -10, -10);
	[self.aView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.view.mas_top).with.offset(paddingA.top);
		make.bottom.equalTo(self.view.mas_bottom).with.offset(paddingA.bottom);
		make.left.equalTo(self.view.mas_left).with.offset(paddingA.left);
		make.right.equalTo(self.view.mas_right).with.offset(paddingA.right);
	}];
	
	//2.aLabel layout
	[self.aLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.center.equalTo(self.bView);
	}];
	
	//3.bView layout
	UIEdgeInsets paddingB = UIEdgeInsetsMake(260, 20, 20, 20);
	[self.bView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view).with.insets(paddingB);
	}];
	
}

#pragma mark - Getters and Setters

- (UIView *)aView {
	if (!_aView) {
		_aView = [[UIView alloc] init];
		_aView.backgroundColor = [UIColor yellowColor];
	}
	return _aView;
}

- (UIView *)bView {
	if (!_bView) {
		_bView = [[UIView alloc] init];
		_bView.backgroundColor = [UIColor greenColor];
	}
	return _bView;
}
- (UILabel *)aLabel {
	if (!_aLabel) {
		_aLabel = [[UILabel alloc] init];
		_aLabel.text = @"Layout Frame Test";
		_aLabel.font = [UIFont systemFontOfSize:23.f];
	}
	return _aLabel;
	
}




@end
