//
//  ViewController.m
//  MyInsPhoto
//
//  Created by Wen Tan on 12/19/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "ViewController.h"
#import <NXOAuth2.h>
#import "PasswordInputWindow.h"

NSString *const Instagram = @"Instagram";
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
	self.segmentControl.selectedSegmentIndex = 1;
	self.logOutBtn.enabled = NO;
	self.refreshBtn.enabled = NO;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (IBAction)loginIns:(UIBarButtonItem *)sender {
	[[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType:Instagram];
	self.logOutBtn.enabled = YES;
	self.loginBtn.enabled = NO;
	self.refreshBtn.enabled = YES;
}

- (IBAction)logoutIns:(UIBarButtonItem *)sender {
	NXOAuth2AccountStore *store = [NXOAuth2AccountStore sharedStore];
	NSArray *insAccounts = [store accountsWithAccountType:Instagram];
	for (id account in insAccounts) {
		[store removeAccount:account];
	}
	self.insImageView.image = [UIImage imageNamed:@"Gingerbread Man.jpg"];
	self.insLabel.text = @"Default Image ~_~";
	self.loginBtn.enabled = YES;
	self.logOutBtn.enabled = NO;
	self.refreshBtn.enabled = NO;
	//add a new UIWindow
	[[PasswordInputWindow sharedInstance] show];
}

- (IBAction)refreshInsImage:(UIButton *)sender {
	NSArray *insAccounts = [[NXOAuth2AccountStore sharedStore] accountsWithAccountType:Instagram];
	if ([insAccounts count] == 0) {
		NSLog(@"Warning; Don't have any Instagram accounts logged in, please check again");
	}
	NXOAuth2Account *myInsAccount = [insAccounts firstObject];
	NSString *myRecentToken = myInsAccount.accessToken.accessToken;
	NSString *recentFeedSTR = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/media/recent/?access_token=%@",myRecentToken];
	NSURL    *recentFeedURL = [NSURL URLWithString:recentFeedSTR];
	
	//data task with url session
	NSURLSession *session = [NSURLSession sharedSession];
	[[session dataTaskWithURL:recentFeedURL
			completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
				//Check network error
				if (error) {
					NSLog(@"Could't fetch request %@",error);
				}

				//Check http error
				NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
				if (urlResponse.statusCode < 200 || urlResponse.statusCode >= 300) {
					NSLog(@"Error: Got status code %ld", (long)urlResponse.statusCode);
					return;
				}
				
				//Check JSON parsing error
				NSError *parsingErr;
				id dataPkg = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parsingErr];
				if (!dataPkg) {
					NSLog(@"Error: Could't parse response: %@",parsingErr);
				}
				NSDictionary *dataDict = (NSDictionary *)dataPkg[@"data"];
				NSLog(@"%lu",(unsigned long)dataDict.count);
				for (id x in dataDict) {
					NSLog(@"%@",x);
				}
				
				//JSON data from ins recent
				NSLog(@"%@",dataPkg);
				int randomNum = arc4random_uniform((int)dataDict.count - 1);
				NSString *myImgSTR = dataPkg[@"data"][randomNum][@"images"][@"standard_resolution"][@"url"];
				NSString *imageTitle = dataPkg[@"data"][randomNum][@"caption"][@"text"];
				NSURL *myImgURL = [NSURL URLWithString:myImgSTR];
				if (myImgURL) {
					NSLog(@"%@",myImgURL);
				}
				
				[[session dataTaskWithURL:myImgURL
						completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
					//Check network error
					if (error) {
						NSLog(@"Could't fetch request %@",error);
					}
					
					//Check http error
					NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
					if (urlResponse.statusCode < 200 || urlResponse.statusCode >= 300) {
						NSLog(@"Error: Got status code %ld", (long)urlResponse.statusCode);
						return;
					}
					
					//get back to main queue, turn NSData to UIImage
					dispatch_async(dispatch_get_main_queue(), ^{
						self.insImageView.image = [UIImage imageWithData:data];
						if (imageTitle) {
							self.insLabel.text = imageTitle.length > 30 ? [imageTitle substringToIndex:30] : imageTitle;
						}else{
							self.insLabel.text = @"Aloha!!!";
						}
					});
				}] resume];
				
	}] resume];
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
