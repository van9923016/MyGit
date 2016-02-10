//
//  NSLayoutConstraint+ViewHierarchy.m
//  C02Constraints
//
//  Created by Wen Tan on 2/10/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "NSLayoutConstraint+ViewHierarchy.h"

@implementation NSLayoutConstraint (ViewHierarchy)

//cast first item to a view
- (TW_VIEW_CLASS *)firstView {
	return self.firstItem;
}
//cast second item to a view
- (TW_VIEW_CLASS *)secondView {
	return self.secondItem;
}
@end


#pragma mark - Add HierarchySupport to TW_VIEW_CLASS
@implementation TW_VIEW_CLASS (HierarchySupport)
//return an array of all superviews
- (NSArray *)superviews {
	NSMutableArray *array = [NSMutableArray array];
	TW_VIEW_CLASS *view = self.superview;
	while (view) {
		[array addObject:view];
		view = self.superview;
	}
	return array;
}
//test if the  current view has a superview relationship to a view
- (BOOL) isAncestorOfView: (TW_VIEW_CLASS *)aView {
	return [[aView superviews] containsObject:self];
}
//return the nearest common ancestor between self and another view
- (TW_VIEW_CLASS *)nearestCommonAncestorToView: (TW_VIEW_CLASS *)aView {
	//check for same view
	if ([self isEqual:aView]) {
		return self;
	}
	//check for direct superview relationship
	if ([self isAncestorOfView:aView]) {
		return self;
	}
	if ([aView isAncestorOfView:self]) {
		return aView;
	}
	//search for indirect common ancestor
	NSArray *ancestors = self.superviews;
	for (TW_VIEW_CLASS *view in aView.superviews) {
		if ([ancestors containsObject:view]) {
			return view;
		}
	}
	//no common ancestor
	return nil;
}


@end