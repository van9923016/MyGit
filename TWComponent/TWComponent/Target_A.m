//
//  Target_A.m
//  TWComponent
//
//  Created by Wen Tan on 4/12/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "Target_A.h"
#import "TWDetailViewController.h"


typedef void(^TWURLRouterCallBackBlock) (NSDictionary *info);

@implementation Target_A

- (UIViewController *)Action_nativeDetailViewController:(NSDictionary *)params {
	TWDetailViewController *detailViewController = [[TWDetailViewController alloc] init];
	detailViewController.valueLabel.text = params[@"key"];
	return detailViewController;
}

- (id)Action_nativePresentImage:(NSDictionary *)params {
	TWDetailViewController *detailViewController = [[TWDetailViewController alloc] init];
	detailViewController.valueLabel.text = @"This is image";
	detailViewController.imageView.image = params[@"image"];
	[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:detailViewController animated:YES completion:nil];
	return nil;
}

- (id)Action_nativeNoImage:(NSDictionary *)params {
	TWDetailViewController *detailViewController = [[TWDetailViewController alloc] init];
	detailViewController.valueLabel.text = @"No Image!";
	detailViewController.imageView.image = [UIImage imageNamed:@"noImageBackRound"];
	[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:detailViewController animated:YES completion:nil];
	return nil;
}
- (id)Action_showAlert:(NSDictionary *)params {
	UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"Alert from module A" message:params[@"message"] preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
		TWURLRouterCallBackBlock callBack = params[@"cancelAction"];
		if (callBack) {
			callBack(@{@"alertAction":action});
		}
	}];
	UIAlertAction *completion = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		TWURLRouterCallBackBlock callBack = params[@"completion"];
		if (callBack) {
			callBack(@{@"alertAction":action});
		}
	}];
	[alertViewController addAction:cancelAction];
	[alertViewController addAction:completion];
	[[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertViewController animated:YES completion:nil];
	return nil;
}


@end
