//
//  TWMediator+ModuleAActions.h
//  TWComponent
//
//  Created by Wen Tan on 4/11/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

//为中介者扩展模块A功能，实现展示自定义控制器，图片，以及弹框提示

@import UIKit;
#import "TWMediator.h"

@interface TWMediator (ModuleAActions)

- (UIViewController *)TWMediator_viewControllerForDetail;

- (void)TWMediator_presentImage:(UIImage *)image;

- (void)TWMediator_showAlertWithMessage:(NSString *)message cancelAction:(void(^)(NSDictionary *info))cancelAction completion:(void(^)(NSDictionary *info))completion;


@end