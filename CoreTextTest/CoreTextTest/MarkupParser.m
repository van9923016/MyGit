//
//  MarkupParser.m
//  CoreTextTest
//
//  Created by Wen Tan on 1/2/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "MarkupParser.h"

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
		}
	}
	
	
	
	return (NSAttributedString *)aString;
}


@end
