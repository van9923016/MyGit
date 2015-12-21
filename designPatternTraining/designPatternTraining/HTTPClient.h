//
//  HTTPClient.h
//  designPatternTraining
//
//  Created by Wen Tan on 12/20/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface HTTPClient : NSObject

- (instancetype)getRequest:(NSString *)URLString;
- (instancetype)postRequest:(NSString *)URLString body:(NSString *)body;
- (UIImage *)downloadImage:(NSString *)URLString;

@end
