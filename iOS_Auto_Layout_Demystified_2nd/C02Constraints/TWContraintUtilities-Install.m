//
//  TWContraintUtilities-Install.m
//  C02Constraints
//
//  Created by Wen Tan on 2/10/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "TWContraintUtilities-Install.h"

#pragma mark - Views

#pragma mark - Hierarchy

@implementation TW_VIEW_CLASS (HierarchySupport)

// Return an array of all superviews
- (NSArray *) superviews {
	NSMutableArray *array = [NSMutableArray array];
	TW_VIEW_CLASS *view = self.superview;
	while (view) {
		[array addObject:view];
		view = view.superview;
	}
	
	return array;
}

// Return an array of all subviews
- (NSArray *) allSubviews {
	NSMutableArray *array = [NSMutableArray array];
	
	for (TW_VIEW_CLASS *view in self.subviews) {
		[array addObject:view];
		[array addObjectsFromArray:[view allSubviews]];
	}
	
	return array;
}

// Test if the current view has a superview relationship to a view
- (BOOL) isAncestorOf: (TW_VIEW_CLASS *) aView {
	return [aView.superviews containsObject:self];
}

// Return the nearest common ancestor between self and another view
- (TW_VIEW_CLASS *) nearestCommonAncestor: (TW_VIEW_CLASS *) aView {
	// Check for same view
	if (self == aView)
		return self;
	
	// Check for direct superview relationship
	if ([self isAncestorOf:aView])
		return self;
	if ([aView isAncestorOf:self])
		return aView;
	
	// Search for indirect common ancestor
	NSArray *ancestors = self.superviews;
	for (TW_VIEW_CLASS *view in aView.superviews)
		if ([ancestors containsObject:view])
			return view;
	
	// No common ancestor
	return nil;
}

@end

#pragma mark - Constraint-Ready Views
@implementation TW_VIEW_CLASS (ConstraintReadyViews)
+ (instancetype) view {
	TW_VIEW_CLASS *newView = [[TW_VIEW_CLASS alloc] initWithFrame:CGRectZero];
	newView.translatesAutoresizingMaskIntoConstraints = NO;
	return newView;
}
@end

#pragma mark - NSLayoutConstraint

#pragma mark - View Hierarchy
@implementation NSLayoutConstraint (ViewHierarchy)
// Cast the first item(id type) to a view
- (TW_VIEW_CLASS *) firstView {
	return self.firstItem;
}

// Cast the second item to a view
- (TW_VIEW_CLASS *) secondView {
	return self.secondItem;
}

// Are two items involved or not
- (BOOL) isUnary {
	return self.secondItem == nil;
}

// Return NCA
- (TW_VIEW_CLASS *) likelyOwner {
	if (self.isUnary)
		return self.firstView;
	
	return [self.firstView nearestCommonAncestor:self.secondView];
}
@end

#pragma mark - Self Install
@implementation NSLayoutConstraint (SelfInstall)
- (BOOL) install {
	// Handle Unary constraint
	if (self.isUnary) {
		// Add weak owner reference
		[self.firstView addConstraint:self];
		return YES;
	}
	
	// Install onto nearest common ancestor
	TW_VIEW_CLASS *view = [self.firstView nearestCommonAncestor:self.secondView];
	if (!view) {
		NSLog(@"Error: Constraint cannot be installed. No common ancestor between items.");
		return NO;
	}
	
	[view addConstraint:self];
	return YES;
}

// Set priority and install
- (BOOL) install: (float) priority {
	self.priority = priority;
	return [self install];
}

- (void) remove {
	if (![self.class isEqual:[NSLayoutConstraint class]]) {
		NSLog(@"Error: Can only uninstall NSLayoutConstraint. %@ is an invalid class.", self.class.description);
		return;
	}
	
	if (self.isUnary) {
		TW_VIEW_CLASS *view = self.firstView;
		[view removeConstraint:self];
		return;
	}
	
	// Remove from preferred recipient
	TW_VIEW_CLASS *view = [self.firstView nearestCommonAncestor:self.secondView];
	if (!view) return;
	
	// If the constraint not on view, this is a no-op
	[view removeConstraint:self];
}
@end