//
//  TWTargetAAction.m
//  TWComponent
//
//  Created by Wen Tan on 4/11/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "TWTargetAAction.h"
#import "TWDetailViewController.h"

typedef void(^TWURLRouterCallBackBlock) (NSDictionary *info);
@implementation TWTargetAAction

- (UIViewController *)Action_nativeDetailViewController:(NSDictionary *)params {
	TWDetailViewController *detailViewController = [[TWDetailViewController alloc] init];
	detailViewController.valueLabel.text = params[@"key"];
	return detailViewController;
}

- (id)Action_presentImage:(NSDictionary *)params {
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
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:params[@"cancelAction"]];
	UIAlertAction *completion = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:params[@"completion"]];
	[alertViewController addAction:cancelAction];
	[alertViewController addAction:completion];
	[[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertViewController animated:YES completion:nil];
	return nil;
}


@end
