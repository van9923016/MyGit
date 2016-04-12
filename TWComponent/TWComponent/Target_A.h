//
//  Target_A.h
//  TWComponent
//
//  Created by Wen Tan on 4/12/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Target_A : NSObject

- (UIViewController *)Action_nativeDetailViewController:(NSDictionary *)params;
- (id)Action_nativePresentImage:(NSDictionary *)params;
- (id)Action_nativeNoImage:(NSDictionary *)params;
- (id)Action_showAlert:(NSDictionary *)params;

@end
