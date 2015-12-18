//
//  ViewController.m
//  SocialFrameworkTest
//
//  Created by Wen Tan on 12/17/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

@import Social;
#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UITextView *facebookTextView;
@property (weak, nonatomic) IBOutlet UITextView *moreActionTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self configureTextView];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)configureTextView {
	
	//configure tweetTextView
	self.tweetTextView.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.5 alpha:1.0].CGColor;
	self.tweetTextView.layer.cornerRadius = 15.0;
	self.tweetTextView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:1.0].CGColor;
	self.tweetTextView.layer.borderWidth = 5.0;
	
	//configure facebook textView
	self.facebookTextView.layer.backgroundColor = [UIColor colorWithRed:1.0 green:0.8 blue:0.7 alpha:1.0].CGColor;
	self.facebookTextView.layer.cornerRadius = 15.0;
	self.facebookTextView.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.8].CGColor;
	self.facebookTextView.layer.borderWidth = 5.0;
	
	//configure moreAction textView
	self.moreActionTextView.layer.backgroundColor = [UIColor colorWithRed:0.8 green:1.0 blue:0.5 alpha:1.0].CGColor;
	self.moreActionTextView.layer.cornerRadius = 15.0;
	self.moreActionTextView.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
	self.moreActionTextView.layer.borderWidth = 5.0;
}
- (IBAction)tweetAction:(UIBarButtonItem *)sender {
	[self.view endEditing:YES];
	if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
		
		SLComposeViewController *twitterShareVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
		[twitterShareVC setInitialText:[self legalMessage:self.tweetTextView.text]];
		[self presentViewController:twitterShareVC animated:YES completion:nil];
	}
}

- (IBAction)facebookAction:(UIBarButtonItem *)sender {
	[self.view endEditing:YES];
	if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
		SLComposeViewController *facebookShareVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
		[facebookShareVC setInitialText:self.facebookTextView.text];
		[self presentViewController:facebookShareVC animated:YES completion:nil];
	}
}

- (IBAction)moreAction:(UIBarButtonItem *)sender {
	[self.view endEditing:YES];
	UIActivityViewController *moreActionVC = [[UIActivityViewController alloc]
											  initWithActivityItems:@[self.moreActionTextView.text]
											  applicationActivities:nil];
	[self presentViewController:moreActionVC animated:YES completion:nil];
	
}

- (IBAction)popupAlert:(UIBarButtonItem *)sender {
	UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Alert"
																	 message:@"This is an alert test!"
															  preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
														   style:UIAlertActionStyleCancel
														 handler:nil];
	[alertVC addAction:cancelAction];
	[self presentViewController:alertVC animated:YES completion:nil];
	
}

- (NSString *)legalMessage:(NSString *)message {
	return (message.length > 140) ? [message substringToIndex:140] : message;
}
@end
