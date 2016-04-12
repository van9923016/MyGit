//
//  TWMediator.h
//  TWComponent
//
//  Created by Wen Tan on 4/11/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//
//iOS组件化架构
//参考自Casa Taloyum的https://github.com/casatwy/CTMediator

#import <Foundation/Foundation.h>

@interface TWMediator : NSObject

+ (instancetype)sharedInstance;

//远程调用接口
- (id)performActionWithURL:(NSURL *)url completion:(void(^)(NSDictionary *info))completion;

//本地组件间调用接口
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params;

@end
