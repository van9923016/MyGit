//
//  ViewController.m
//  TWWormBumping
//
//  Created by Wen Tan on 3/28/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "ViewController.h"
#import "TWWormView.h"

@interface ViewController ()

@property (nonatomic, strong) TWWormView *wormHUDView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	TWWormView *wormView = [TWWormView addWormHUDWithStyle:TWWormHUDStyleLarge toView:self.view];
	self.wormHUDView = wormView;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(UIButton *)sender {
	if (self.wormHUDView.isShowing) {
		[self.wormHUDView endLoading];
	}else{
		[self.wormHUDView loadingWorm];
	}
}

@end
