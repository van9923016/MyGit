//
//  MarkupParser.m
//  CoreTextTest
//
//  Created by Wen Tan on 1/2/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "MarkupParser.h"
//Callbacks

static CGFloat ascentCallback(void *ref) {
	return [(NSString *)[(__bridge NSDictionary *)ref objectForKey:@"height"] floatValue];
}
static CGFloat descentCallback(void *ref) {
	return [(NSString *)[(__bridge NSDictionary *)ref objectForKey:@"descent"] floatValue];
}
static CGFloat widthCallback(void *ref) {
	return [(NSString *)[(__bridge NSDictionary *)ref objectForKey:@"width"] floatValue];
}
@implementation MarkupParser

- (instancetype)init {
	self = [super init];
	
	if (self) {
		self.aFont = @"ArialMT";
		self.color = [UIColor blackColor];
		self.strokeColor = [UIColor whiteColor];
		self.strokeWidth = 0.0;
		self.images = [NSMutableArray array];
	}
	return self;
}

- (NSAttributedString *)attrStringFromMarkup:(NSString *)markup {
	//1.
	NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:@""];
	
	//2.
	NSRegularExpression *regex = [[NSRegularExpression alloc]
								  initWithPattern:@"(.*?)(<[^>]+>|\\Z)"
								  options:NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators
								  error:nil];
	
	NSArray *chunks = [regex matchesInString:markup options:0 range:NSMakeRange(0, [markup length])];
	
	for (NSTextCheckingResult *result in chunks) {
		NSArray *parts = [[markup substringWithRange:result.range] componentsSeparatedByString:@"<"];
		
		CTFontRef fontRef = CTFontCreateWithName((CFStringRef)self.aFont, 24.0f, NULL);
		
		//apply the current text style
		NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
							   (id)self.color.CGColor, kCTForegroundColorAttributeName,
							   (__bridge id)fontRef, kCTFontAttributeName,
							   (id)self.strokeColor.CGColor, (__bridge NSString *)kCTStrokeColorAttributeName,
							   (id)[NSNumber numberWithFloat:self.strokeWidth],(__bridge NSString *)kCTStrokeWidthAttributeName,
							   nil];
		[aString appendAttributedString:[[NSAttributedString alloc]
										 initWithString:[parts objectAtIndex:0]
										 attributes:attrs]];
		CFRelease(fontRef);
		
		//handle new formatting
		if ([parts count] > 1) {
			NSString *tag = (NSString *)[parts objectAtIndex:1];
			//font parsing
			if ([tag hasPrefix:@"font"]) {
				
				//stroke color
				NSRegularExpression *scolorRegex = [[NSRegularExpression alloc]
													initWithPattern:@"(?<=strokeColor=\")\\w+"
													options:0
													error:nil];
				
				[scolorRegex enumerateMatchesInString:tag
											  options:0
												range:NSMakeRange(0, [tag length])
										   usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
											   if ([[tag substringWithRange:result.range] isEqualToString:@"none"]) {
												   self.strokeWidth = 0.0;
											   }else{
												   self.strokeWidth = -3.0;
												   SEL colorSel = NSSelectorFromString([NSString stringWithFormat:@"%@Color", [tag substringWithRange:result.range]]);
												   self.strokeColor = [UIColor performSelector: colorSel];
											   }
										   }];
				
				//color
				NSRegularExpression *colorRegex = [[NSRegularExpression alloc]
													initWithPattern:@"(?<=color=\")\\w+"
													options:0
													error:nil];
				[colorRegex enumerateMatchesInString:tag
											  options:0
												range:NSMakeRange(0, [tag length])
										   usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
											   SEL colorSel = NSSelectorFromString([NSString stringWithFormat:@"%@Color", [tag substringWithRange:result.range]]);
											   self.color = [UIColor performSelector: colorSel];
										   }];
				
				//face
				NSRegularExpression *faceRegex = [[NSRegularExpression alloc]
												   initWithPattern:@"(?<=face=\")[^\"]+"
												   options:0
												   error:nil];
				[faceRegex enumerateMatchesInString:tag
											 options:0
											   range:NSMakeRange(0, [tag length])
										  usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
											  self.aFont = [tag substringWithRange:result.range];
										  }];
			}//end of font parsing
			//img parsing
			if ([tag hasPrefix:@"img"]) {
				__block NSNumber *width = [NSNumber numberWithInt:0];
				__block NSNumber *height = [NSNumber numberWithInt:0];
				__block NSString *filename = @"";
				
				//width
				NSRegularExpression *widthRegex = [[NSRegularExpression alloc] initWithPattern:@"(?<=width=\")[^\"]+" options:0 error:nil];
				[widthRegex enumerateMatchesInString:tag options:0 range:NSMakeRange(0, [tag length]) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
					width = [NSNumber numberWithInt:[[tag substringWithRange:result.range]intValue]];
				}];
				
				//height
				NSRegularExpression *heightRegex = [[NSRegularExpression alloc] initWithPattern:@"(?<=height=\")[^\"]+" options:0 error:nil];
				[heightRegex enumerateMatchesInString:tag options:0 range:NSMakeRange(0, [tag length]) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
					height = [NSNumber numberWithInt:[[tag substringWithRange:result.range]intValue]];
				}];
				
				//image
				NSRegularExpression *srcRegex = [[NSRegularExpression alloc] initWithPattern:@"(?<=src=\")[^\"]+" options:0 error:nil];
				[srcRegex enumerateMatchesInString:tag options:0 range:NSMakeRange(0, [tag length]) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
					filename = [tag substringWithRange:result.range];
				}];
				
				//add image for drawing
				[self.images addObject:[NSDictionary dictionaryWithObjectsAndKeys:
										width,@"width",
										height, @"height",
										filename,@"filename",
										[NSNumber numberWithInt:(int)[aString length]],@"location",
										nil]];
				
				//render empty space for drawing image
				CTRunDelegateCallbacks callbacks;
				callbacks.version = kCTRunDelegateVersion1;
				callbacks.getAscent = ascentCallback;
				callbacks.getDescent = descentCallback;
				callbacks.getWidth = widthCallback;
//				callbacks.dealloc = deallocCallback;
				
				NSDictionary *imgAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
										   width, @"width",
										   height, @"height",
										   nil];
				
				//create ctrun delegate
				CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void * _Nullable)(imgAttrs));
				//set delegate
				NSDictionary *attrDictionaryDelegate = [NSDictionary dictionaryWithObjectsAndKeys:
														(__bridge id)delegate,(NSString *)kCTRunDelegateAttributeName, nil];
				
				//add a space to the text so that it can call delegate
				[aString appendAttributedString:[[NSAttributedString alloc]
												 initWithString:@" "
												 attributes:attrDictionaryDelegate]];
			}
		}
	}
	return (NSAttributedString *)aString;
}


@end
