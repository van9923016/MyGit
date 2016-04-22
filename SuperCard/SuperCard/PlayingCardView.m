//
//  PlayingCardView.m
//  SuperCard
//
//  Created by Wen Tan on 1/10/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "PlayingCardView.h"

static const double CORNER_FONT_STANDARD_HEIGHT = 180.0;
static const double CORNER_RADIUS = 12.0;

@interface PlayingCardView()

@property (nonatomic, assign) float faceCardScaleFactor;

@end

@implementation PlayingCardView

+ (void)initialize {
	NSLog(@"fv");
}
#pragma mark - setup Properties
-(void)setFaceUp:(BOOL)faceUp {
	_faceUp = faceUp;
	[self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank {
	_rank = rank;
	[self setNeedsDisplay];
}

-(void)setSuit:(NSString *)suit {
	_suit = suit;
	[self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
#pragma mark - Drawing
- (CGFloat)cornerScaleFactor {
	return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;
}

- (CGFloat)cornerRadius {
	return CORNER_RADIUS * [self cornerScaleFactor];
}

- (CGFloat)cornerOffSet {
	return ([self cornerRadius] / 3.0);
}

- (void)drawRect:(CGRect)rect {
	UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
 cornerRadius:[self cornerRadius]];
	[roundedRect addClip];
	[[UIColor whiteColor] setFill];
	UIRectFill(self.bounds);
	
	[[UIColor blackColor] setStroke];
	[roundedRect stroke];
	
	UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit]];
	if (faceImage) {
		CGRect imageRect = CGRectInset(self.bounds,
									   self.bounds.size.width * (1.0-self.faceCardScaleFactor),
									   self.bounds.size.height * (1.0-self.faceCardScaleFactor));
		[faceImage drawInRect:imageRect];
	}else{
		[self drawPips];
	}
	
	[self drawCorners];
}

- (void)drawPips {
	  
}
- (NSString *)rankAsString {
	return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}
- (void)drawCorners {
	NSMutableParagraphStyle *paragraghStyle = [[NSMutableParagraphStyle alloc] init];
	paragraghStyle.alignment = NSTextAlignmentCenter;
	
	UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
	cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
	NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",[self rankAsString], self.suit] attributes:@{NSFontAttributeName : cornerFont,NSParagraphStyleAttributeName : paragraghStyle}];
	
	CGRect textBounds;
	textBounds.origin = CGPointMake([self cornerOffSet], [self cornerOffSet]);
	textBounds.size = [cornerText size];
	[cornerText drawInRect:textBounds];
	
	//translate rotate
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
	CGContextRotateCTM(context, M_PI);
	[cornerText drawInRect:textBounds];
	
}

#pragma mark - Initialization
- (void)setup {
	self.backgroundColor = nil;
	self.opaque = NO;
	self.contentMode = UIViewContentModeRedraw;
#pragma clang diagnostic pop
#pragma clang diagnostic ignored "-Wunused-variable"
	NSString *unUsedString = @"unused";
#pragma clang diagnostic push
	
}

- (void)awakeFromNib {
	[self setup];
}
- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
	}
	return self;
}

@end
