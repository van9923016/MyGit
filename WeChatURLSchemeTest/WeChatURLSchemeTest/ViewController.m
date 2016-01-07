//
//  ViewController.m
//  WeChatURLSchemeTest
//
//  Created by Wen Tan on 1/7/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "ViewController.h"
#import "URLSchemeModel.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *jumpButton;
@end

@implementation ViewController

-(IBAction)jumpToWeChat:(UIButton *)sender {
	NSURL *urlScheme = [NSURL URLWithString:[URLSchemeModel sharedModel].officialAccounts];
	
	if ([[UIApplication sharedApplication] canOpenURL:urlScheme]) {
		[[UIApplication sharedApplication] openURL:urlScheme];
	}else{
		UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"未安装微信" message:@"跳转到App Store下载微信" preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
			//using itms instead https directly jump to app store
			NSURL *appLink = [NSURL URLWithString:@"itms-apps://appsto.re/cn/S8gTy.i"];
			[[UIApplication sharedApplication] openURL:appLink];
			
		}];
		[alertVC addAction:alertAction];
		[self presentViewController:alertVC animated:YES completion:nil];
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.jumpButton.layer.cornerRadius = 8.0;
	self.jumpButton.layer.masksToBounds = YES;
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
