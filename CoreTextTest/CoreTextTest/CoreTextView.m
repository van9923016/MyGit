//
//  CoreTextView.m
//  CoreTextTest
//
//  Created by Wen Tan on 1/2/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

@import CoreText;
#import "CoreTextView.h"
#import "MarkupParser.h"

@implementation CoreTextView

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	
	//0.create core graphics drawing context.
	CGContextRef context = UIGraphicsGetCurrentContext();
	//flip coordinate system
	CGContextSetTextMatrix(context, CGAffineTransformIdentity);
	//text just below status bar
	CGContextTranslateCTM(context, 0, self.bounds.size.height+20);
	CGContextScaleCTM(context, 1.0, -1.0);
	
	//1.create a graphics path bounds the area u drawing text
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathAddRect(path, NULL, self.bounds);
	
	//2.core text world, using NSAttributedString to represent string
	//NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"Hello core text world!"];
	
	//2.using parser to create different color text 
	MarkupParser *parser = [[MarkupParser alloc] init];
	NSAttributedString *attString = [parser attrStringFromMarkup:@"Hello <fontcolor=\"red\"> core text <font color=\"blue\">world!"];
	
	//3.Manage font reference and text drawing frames
	//covert NSAttributedString to CFAttributedStringRef
	CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
	CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [attString length]), path, NULL);
	
	//4.draw text frame using frame reference and context
	CTFrameDraw(frame, context);
	
	//5 manually release C struct object
	CFRelease(frame);
	CFRelease(path);
	CFRelease(frameSetter);
}


@end
