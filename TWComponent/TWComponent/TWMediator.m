//
//  TWMediator.m
//  TWComponent
//
//  Created by Wen Tan on 4/11/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

/*
 scheme://[target]/[action]?[params]
 url sample:
 aaa://targetA/actionB?id=1234
 */
//static NSString *const urlScheme = @"aaa://targetA/actionB?id=1234";

#import "TWMediator.h"



@implementation TWMediator

+ (instancetype)sharedInstance {
	static TWMediator*mediator;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		mediator = [[TWMediator alloc] init];
	});
	return mediator;
}

- (id)performActionWithURL:(NSURL *)url completion:(void (^)(NSDictionary *))completion {
	if (![url.scheme isEqualToString:@"aaa"]) {
		return @(NO);
	}
	NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
	NSString *urlString = [url query];
	for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
		NSArray *elts = [param componentsSeparatedByString:@"="];
		if([elts count] < 2) continue;
		[params setObject:[elts lastObject] forKey:[elts firstObject]];
	}
	
	// 这里这么写主要是出于安全考虑，防止黑客通过远程方式调用本地模块。这里的做法足以应对绝大多数场景，如果要求更加严苛，也可以做更加复杂的安全逻辑。
	NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
	if ([actionName hasPrefix:@"native"]) {
		return @(NO);
	}
	
	// 这个demo针对URL的路由处理非常简单，就只是取对应的target名字和method名字，但这已经足以应对绝大部份需求。如果需要拓展，可以在这个方法调用之前加入完整的路由逻辑
	//解析远程url后调用本地target-action方法执行任务
	id result = [self performTarget:url.host action:actionName params:params];
	
	if (completion) {
		if (result) {
			completion(@{@"result":result});
		} else {
			completion(nil);
		}
	}
	return result;
}

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params {
	
	//runtime 处理target-action动作
	NSString *targetClassString = [NSString stringWithFormat:@"Target_%@",targetName];
	NSString *actionString = [NSString stringWithFormat:@"Action_%@:",actionName];
	
	Class targetClass = NSClassFromString(targetClassString);
	id target = [[targetClass alloc] init];
	SEL action = NSSelectorFromString(actionString);
	
	if (target == nil) {
		//处理无响应target情况，本项目不作任何处理直接返回
		return nil;
	}
	NSLog(@"%d",[target respondsToSelector:action]);
	if ([target respondsToSelector:action]) {
//忽略runtime 使用未知selector可能会内存泄漏的警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
		return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
	} else {
		//deal with not found situation
		SEL action = NSSelectorFromString(@"notFound:");
		if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
			return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
		} else {
			//处理target响应，target未找到以外的不存在情况
			return nil;
		}
	}
}
@end
