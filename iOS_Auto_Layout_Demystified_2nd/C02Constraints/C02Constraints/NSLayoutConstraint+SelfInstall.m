//
//  NSLayoutConstraint+SelfInstall.m
//  C02Constraints
//
//  Created by Wen Tan on 2/10/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "NSLayoutConstraint+SelfInstall.h"
#import "NSLayoutConstraint+ViewHierarchy.h"

@implementation NSLayoutConstraint (SelfInstall)

- (BOOL)install {
	//handle Unary constraint
	if (self.isUnary) {
		[self.firstView addConstraint:self];
		return YES;
	}
}

@end
