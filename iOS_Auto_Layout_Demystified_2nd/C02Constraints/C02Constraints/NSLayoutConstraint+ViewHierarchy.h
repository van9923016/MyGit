//
//  NSLayoutConstraint+ViewHierarchy.h
//  C02Constraints
//
//  Created by Wen Tan on 2/10/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import <UIKit/UIKit.h>
#if TARGET_OS_IPHONE
#define TW_VIEW_CLASS UIView
#elif TARGET_OS_MAC
#define TW_VIEW_CLASS NSView
#endif

@interface NSLayoutConstraint (ViewHierarchy)

@property (nonatomic, readonly) TW_VIEW_CLASS *firstView;
@property (nonatomic, readonly) TW_VIEW_CLASS *secondView;

@end
