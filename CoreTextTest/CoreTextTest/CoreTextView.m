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
#import "CTColumnView.h"

@implementation CoreTextView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		//Init
	}
	return self;
}
- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
//	[self basicDrawRect];
}

- (void)basicDrawRect {
	
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
	//	MarkupParser *parser = [[MarkupParser alloc] init];
	//	NSAttributedString *attString = [parser attrStringFromMarkup:@"Hello <fontcolor=\"red\"> core text <font color=\"blue\">world!"];
	
	//3.Manage font reference and text drawing frames
	//covert NSAttributedString to CFAttributedStringRef
	CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_attString);
	CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [_attString length]), path, NULL);
	
	//4.draw text frame using frame reference and context
	CTFrameDraw(frame, context);
	
	//5 manually release C struct object
	CFRelease(frame);
	CFRelease(path);
	CFRelease(frameSetter);
}

- (void)buildFrames {
	//1.basic setup of offset and delegate and more
	self.frameXOffset = 20;
	self.frameYOffset = 20;
	self.pagingEnabled = YES;
	self.delegate = self;
	self.frames = [NSMutableArray array];
	
	//2.create CGpath and CTFramesetter
	CGMutablePathRef path = CGPathCreateMutable();
	//Returns a rectangle that is smaller or larger than the source rectangle, with the same center point.
	//positive decreased, negative increased
	CGRect textFrame = CGRectInset(self.bounds, self.frameXOffset, self.frameYOffset);

	CGPathAddRect(path, nil, textFrame);
	//Creates an immutable framesetter object from an attributed string.
	CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attString);
	
	//3.initial text position and column index
	int textPosition = 0;
	int columnIndex = 0;
	
	//4.
	while (textPosition < [self.attString length]) {
		float x = (columnIndex+1)*self.frameXOffset + columnIndex*(textFrame.size.width/2);
		CGPoint columnOffset = CGPointMake(x, 20);
		CGRect columnRect = CGRectMake(0, 0, textFrame.size.width/2-10, textFrame.size.height-40);
		CGMutablePathRef path = CGPathCreateMutable();
		CGPathAddRect(path, nil, columnRect);
		
		//use the column path
		CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(textPosition, 0), path, nil);

		//5.get the frame maximum contains character's number
		CFRange frameRange = CTFrameGetVisibleStringRange(frame);
		
		//create an empty column view
		CTColumnView *content = [[CTColumnView alloc] initWithFrame:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)];
		content.backgroundColor = [UIColor clearColor];
		content.frame = CGRectMake(columnOffset.x, columnOffset.y, columnRect.size.width, columnRect.size.height);
		
		//set the column view contents and add it as subview
		//6.
		[content setCtFrame:(__bridge id)frame];
		
		//add image content
		[self attachImagesWithframe:frame inColumnView:content];
		
		[self.frames addObject:(__bridge id)frame];
		[self addSubview:content];
		
		//prepare for next frame
		textPosition += frameRange.length;
		
		//cfrelease frame
		CFRelease(path);
		
		columnIndex++;
	}
	
	//set the total width of the scroll view
	//7.
	int totalPages = (columnIndex+1) / 2;
	self.contentSize = CGSizeMake(totalPages*self.bounds.size.width, textFrame.size.height);
	
}

- (void)setAttString:(NSAttributedString *)attString withImages:(NSArray *)imgs {
	self.attString = attString;
	self.images = imgs;
}

- (void)attachImagesWithframe:(CTFrameRef)ref inColumnView:(CTColumnView *)col {
	//1.drawing images
	NSArray *lines = (NSArray *)CTFrameGetLines(ref);
	
	CGPoint origins[[lines count]];
	//2.
	CTFrameGetLineOrigins(ref, CFRangeMake(0, 0), origins);
	
	//3.
	int imgIndex = 0;
	NSDictionary *nextImage = [self.images objectAtIndex:imgIndex];
	int imgLocation = [[nextImage objectForKey:@"location"] intValue];
	
	//4.find images for the current column
	CFRange frameRange = CTFrameGetVisibleStringRange(ref);
	while (imgLocation < frameRange.location) {
		imgIndex++;
		if (imgIndex >= [self.images count]) {
			return;//quit if no images for this column
		}
		nextImage = [self.images objectAtIndex:imgIndex];
		imgLocation = [[nextImage objectForKey:@"location"] intValue];
	}
	
	NSUInteger lineIndex = 0;
	
	//5.
	for (id lineObj in lines) {
		CTLineRef line = (__bridge CTLineRef)lineObj;
		
		for (id runObj in (NSArray *)CTLineGetGlyphRuns(line)) {
			//6.
			CTRunRef run = (__bridge CTRunRef)runObj;
			CFRange runRange = CTRunGetStringRange(run);
			
			if (runRange.location <= imgLocation && runRange.location+runRange.length > imgLocation) {
				//7.
				CGRect runBounds;
				CGFloat ascent;//height above the baseline
				CGFloat descent;//height below the baseline
				
				//8.
				runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, nil);
				runBounds.size.height = ascent + descent;
				
				//9.
				CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, nil);
				runBounds.origin.x = origins[lineIndex].x + self.frame.origin.x + xOffset + self.frameXOffset;
				runBounds.origin.y = origins[lineIndex].y + self.frame.origin.y + self.frameYOffset;
				runBounds.origin.y -= descent;
				
				UIImage *img = [UIImage imageNamed:[nextImage objectForKey:@"filename"]];
				
				//10.
				CGPathRef pathRef = CTFrameGetPath(ref);
				CGRect colRect = CGPathGetBoundingBox(pathRef);
				
				CGRect imgBounds = CGRectOffset(runBounds, colRect.origin.x - self.frameXOffset - self.contentOffset.x, colRect.origin.y - self.frameYOffset - self.frame.origin.y);
				[col.images addObject:[NSArray arrayWithObjects:img, NSStringFromCGRect(imgBounds), nil]];

				imgIndex++;
				if (imgIndex < [self.images count]) {
					nextImage = [self.images objectAtIndex:imgIndex];
					imgLocation = [[nextImage objectForKey:@"location"] intValue];
				}
			}
		}
		lineIndex++;
	}
}


@end
