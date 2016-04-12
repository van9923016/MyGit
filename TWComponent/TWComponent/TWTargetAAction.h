//
//  TWTargetAAction.h
//  TWComponent
//
//  Created by Wen Tan on 4/11/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

@import UIKit;
#import <Foundation/Foundation.h>

@interface TWTargetAAction : NSObject

- (UIViewController *)Action_nativeDetailViewController:(NSDictionary *)params;
- (id)Action_presentImage:(NSDictionary *)params;
- (id)Action_nativeNoImage:(NSDictionary *)params;
- (id)Action_showAlert:(NSDictionary *)params;

@end
