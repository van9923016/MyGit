//
//  ViewController.m
//  SocialNetWorkTest
//
//  Created by Wen Tan on 12/17/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

@import Social;
#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITextView *shareTextView;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self configureShareTextView];

}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; 
}


- (void)shareText:(NSString *)message {
	SLComposeViewController *sinaWeiboVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
	if (message.length < 140) {
		[sinaWeiboVC setInitialText:message];
	}else{
		[sinaWeiboVC setInitialText:[message substringToIndex:140]];
	}
	
	[self presentViewController:sinaWeiboVC animated:YES completion:nil];
}

- (void)configureSystemSinaWeibo {
	UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"您尚未配置系统微博账户" preferredStyle:UIAlertControllerStyleAlert];
	[alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
	
	//TODO: using URL scheme to jump to sina weibo settings
	[alertVC addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
		NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//		NSURL *settingsURL = [NSURL URLWithString:@"prefs:root=TWITTER"];
		
		if ([[UIApplication sharedApplication] canOpenURL:settingsURL]) {
			[[UIApplication sharedApplication] openURL:settingsURL];
		}
	}]];
	[self presentViewController:alertVC animated:YES completion:nil];
}

- (IBAction)shareAction:(UIBarButtonItem *)sender {
	if ([self.shareTextView isFirstResponder]) {
		[self.shareTextView resignFirstResponder];
	}
	UIAlertController *shareAlertVC = [UIAlertController alertControllerWithTitle:@"分享"
																		  message:@"将这段话分享到微博"
																   preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
														   style:UIAlertActionStyleDefault
														 handler:nil];
	
	UIAlertAction *shareAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
			[self shareText:self.shareTextView.text];
		}else{
			[self configureSystemSinaWeibo];
		}
		
	}];
	
	//add left cancel action
	[shareAlertVC addAction:cancelAction];
	//add right done action
	[shareAlertVC addAction:shareAction];
	[self presentViewController:shareAlertVC animated:YES completion:nil];
}

//configure share textview UI style
- (void)configureShareTextView {
	self.shareTextView.layer.backgroundColor = [UIColor colorWithRed:1.0
															   green:1.0
																blue:0.9
															   alpha:1.0].CGColor;
	self.shareTextView.layer.cornerRadius = 10.0;
	self.shareTextView.layer.borderColor = [UIColor colorWithWhite:0
															alpha:0.5].CGColor;
	self.shareTextView.layer.borderWidth =  2.0;
}
@end
