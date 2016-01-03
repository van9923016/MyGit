//
//  CTColumnView.m
//  CoreTextTest
//
//  Created by Wen Tan on 1/2/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "CTColumnView.h"

@implementation CTColumnView

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	//flip the coordinate system
	CGContextSetTextMatrix(context, CGAffineTransformIdentity);
	CGContextTranslateCTM(context, 0, self.bounds.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	
	CTFrameDraw((CTFrameRef)_ctFrame, context);
	
	for (NSArray *imgData in self.images) {
		UIImage *img = [imgData objectAtIndex:0];
		CGRect imgBounds = CGRectFromString([imgData objectAtIndex:1]);
		CGContextDrawImage(context, imgBounds, img.CGImage);
	}
	
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.images = [NSMutableArray array];
	}
	return self;
}

@end
