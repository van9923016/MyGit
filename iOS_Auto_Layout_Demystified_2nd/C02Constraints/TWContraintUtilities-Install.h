//
//  TWContraintUtilities-Install.h
//  C02Constraints
//
//  Created by Wen Tan on 2/10/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//
#import <Foundation/Foundation.h>

#pragma mark - Cross Platform
#if TARGET_OS_IPHONE
	#import <UIKit/UIKit.h>
	#define TW_VIEW_CLASS UIView
#elif TARGET_OS_MAC
	#define TW_VIEW_CLASS NSView
#endif

typedef enum : NSUInteger {
	LayoutPriorityRequired = 1000,
	LayoutPriorityHigh = 750,
	LayoutPriorityDragResizingWindow = 510,//for mac
	LayoutPriorityMedium = 501,
	LayoutPriorityFixedWindowSize = 500,
	LayoutPriorityLow = 250,
	LayoutPriorityFittingSize = 50,
	LayoutPriorityMildSuggestion = 1,
} ConstraintLayoutPriority;

#define AQUA_SPACE  8
#define AQUA_INDENT 20
#define PREPCONSTRAINTS(VIEW) [VIEW setTranslatesAutoresizingMaskIntoConstraints:NO]


#pragma mark - TW_VIEW_CLASS HierarchySupport
@interface TW_VIEW_CLASS (HierarchySupport)

@property (nonatomic, readonly) NSArray *superviews;
@property (nonatomic, readonly) NSArray	*allSubviews;

- (BOOL) isAncestorOf: (TW_VIEW_CLASS *)aView;
- (TW_VIEW_CLASS *)nearestCommonAncestor: (TW_VIEW_CLASS *) aView;

@end

#pragma mark - TW_VIEW_CLASS ConstraintReadyViews
@interface TW_VIEW_CLASS (ConstraintReadyViews)

+ (instancetype)view;

@end

#pragma mark - NSLayoutConstraint Category
@interface NSLayoutConstraint (ViewHierarchy)

@property (nonatomic, readonly) TW_VIEW_CLASS *firstView;
@property (nonatomic, readonly) TW_VIEW_CLASS *secondView;
@property (nonatomic, readonly) BOOL isUnary;
@property (nonatomic, readonly) TW_VIEW_CLASS *likelyOwner;

@end

@interface NSLayoutConstraint (SelfInstall)

- (BOOL)install;
- (BOOL)install: (float)priority;
- (void)remove;

@end
