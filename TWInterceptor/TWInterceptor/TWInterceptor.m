//
//  TWInterceptor.m
//  TWInterceptor
//
//  Created by Wen Tan on 4/19/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//


//using Aspects hook up method to UIViewController or other super class in runtime
//instead of using category

@import UIKit;
#import "TWInterceptor.h"
#import <Aspects.h>

@implementation TWInterceptor

+ (void)load {
	//所有属于NSObject类的函数都会在runtime自动被调用，通过重载此函数实现对父类最小程度入侵式篡改
	[super load];
	[TWInterceptor sharedInstance];
}


+ (instancetype)sharedInstance {
	static TWInterceptor *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[TWInterceptor alloc] init];
	});
	return sharedInstance;
}

- (instancetype)init {
	self = [super init];
	if (self) {
		//使用Aspects对UIViewController进行拦截
		[UIViewController aspect_hookSelector:@selector(loadView) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo) {
			//这里写loadView方法的业务需求逻辑代码
			[self loadView:[aspectInfo instance]];
		} error:NULL];
		
		[UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo, BOOL animated) {
			//这里写viewWillAppear方法后需要插入的方法
			[self viewWillAppear:animated viewController:[aspectInfo instance]];
			NSLog(@"From TW");
		}error:NULL];
		//类似的还可以进行其他的方法拦截和替换
	}
	return self;
}

//Test for intercptor

- (void)loadView:(UIViewController *)viewController {
	NSLog(@"[%@ loadView]",[viewController class]);
}

- (void)viewWillAppear:(BOOL) animated viewController:(UIViewController *)viewController {
	//可以加入初始化基础业务逻辑
	NSLog(@"[%@ viewWillAppear:%@]",[viewController class],animated ? @"YES" : @"NO");
}

@end
