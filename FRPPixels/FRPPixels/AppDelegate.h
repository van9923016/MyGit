//
//  AppDelegate.h
//  FRPPixels
//
//  Created by Wen Tan on 12/2/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
//500px apiHelper
@property (nonatomic, readonly, strong) PXAPIHelper *apiHelper;


@end

