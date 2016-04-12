//
//  TWMediator+ModuleAActions.m
//  TWComponent
//
//  Created by Wen Tan on 4/11/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "TWMediator+ModuleAActions.h"

NSString *const kTWMediatorTargetA = @"A";
NSString *const kTWMediatorActionNativeDetailViewController = @"nativeDetailViewController";
NSString *const kTWMediatorActionNativePresentImage = @"nativePresentImage";
NSString *const kTWMediatorActionNativeNoImage = @"nativeNoImage";
NSString *const kTWMediatorActionShowAlert = @"showAlert";

@implementation TWMediator (ModuleAActions)

- (UIViewController *)TWMediator_viewControllerForDetail {
	UIViewController *viewController = [self performTarget:kTWMediatorTargetA
												action:kTWMediatorActionNativeDetailViewController
												params:@{@"key":@"value"}];
	if ([viewController isKindOfClass:[UIViewController class]]) {
		//返回该详情界面
		return viewController;
	} else {
		//处理界面异常的场景
		return [[UIViewController alloc] init];
	}
	
}

- (void)TWMediator_presentImage:(UIImage *)image {
	if (image) {
		[self performTarget:kTWMediatorTargetA
					 action:kTWMediatorActionNativePresentImage
					 params:@{@"image":image}];
	} else {
		// 这里处理image为nil的场景，这里使用背景图，具体如何处理取决于产品
		[self performTarget:kTWMediatorTargetA
					 action:kTWMediatorActionNativeNoImage
					 params:@{@"image":[UIImage imageNamed:@"backRoundImage"]}];
	}
}

- (void)TWMediator_showAlertWithMessage:(NSString *)message cancelAction:(void (^)(NSDictionary *))cancelAction completion:(void (^)(NSDictionary *))completion {
	NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
	if (message) {
		params[@"message"] = message;
	}
	if (cancelAction) {
		params[@"cancelAction"] = cancelAction;
	}
	if (completion) {
		params[@"completion"] = completion;
	}
	[self performTarget:kTWMediatorTargetA
				 action:kTWMediatorActionShowAlert
				 params:params];
}

@end
