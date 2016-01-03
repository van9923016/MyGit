//
//  CTColumnView.m
//  CoreTextTest
//
//  Created by Wen Tan on 1/2/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "CTColumnView.h"

@interface CTColumnView ()


@end

@implementation CTColumnView

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	//flip the coordinate system
	CGContextSetTextMatrix(context, CGAffineTransformIdentity);
	CGContextTranslateCTM(context, 0, self.bounds.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	
	CTFrameDraw((CTFrameRef)_ctFrame, context);
	
}

@end
