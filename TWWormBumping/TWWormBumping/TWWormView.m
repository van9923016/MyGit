//
//  TWWormView.m
//  TWWormBumping
//
//  Created by Wen Tan on 3/28/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "TWWormView.h"

//Predefine Variable
//指针常量
NSString *const kWormAnimationFirst   = @"kWormAnimationFirst";
NSString *const kWormAnimationSecond  = @"kWormAnimationSecond";
NSString *const kWormAnimationThird   = @"kWormAnimationThird";

//动画半径为HUD尺寸的一半
static NSUInteger kHUDLineWidthSmall  = 4.0f;
static NSUInteger kHUDWidthSmall      = 25.0f;
static NSUInteger kHUDHeightSmall     = 25.0f;

static NSUInteger kHUDLineWidth       = 6.0f;
static NSUInteger kHUDWidth           = 40.0f;
static NSUInteger kHUDHeight          = 40.0f;

static NSUInteger kHUDLineWidthLarge  = 8.0f;
static NSUInteger kHUDWidthLarge      = 80.0f;
static NSUInteger kHUDHeightLarge     = 80.0f;

static CGFloat kWormDuration          = 1.2f;

static NSInteger wormHUDViewWidth     = 0;
static NSInteger wormHUDViewHeight    = 0;
static NSInteger wormHUDViewLineWidth = 0;
//////////////////////////////////////////////////

@interface TWWormView ()

@property (nonatomic, strong) CAShapeLayer *firstWormShapeLayer;
@property (nonatomic, strong) CAShapeLayer *secondWormShapeLayer;
@property (nonatomic, strong) CAShapeLayer *thirdWormShapeLayer;
@property (nonatomic, assign) TWWormHUDStyle hudStyle;
@property (nonatomic, weak) UIView *presentingView;

@end

@implementation TWWormView

+ (instancetype)addWormHUDWithStyle:(TWWormHUDStyle)style toView:(UIView *)aView {
	TWWormView *wormView;
	switch (style) {
		case TWWormHUDStyleSmall:
            wormHUDViewWidth  = kHUDWidthSmall;
            wormHUDViewHeight = kHUDHeightSmall;
            wormHUDViewLineWidth  = kHUDLineWidthSmall;
			break;
		case TWWormHUDStyleLarge:
            wormHUDViewWidth  = kHUDWidthLarge;
            wormHUDViewHeight = kHUDHeightLarge;
            wormHUDViewLineWidth  = kHUDLineWidthLarge;
			break;
			
		default:	//Normal size
            wormHUDViewWidth  = kHUDWidth;
            wormHUDViewHeight = kHUDHeight;
            wormHUDViewLineWidth  = kHUDLineWidth;
			break;
	}
	
	CGRect frame = CGRectZero;
	frame.origin.x = aView.frame.origin.x + (aView.frame.size.width / 2 - wormHUDViewWidth / 2);
	frame.origin.y = aView.frame.origin.y + (aView.frame.size.height / 2 - wormHUDViewHeight / 2);
	frame.size.width = wormHUDViewWidth;
	frame.size.height = wormHUDViewHeight;
	wormView = [[TWWormView alloc] initWithFrame:frame HUDStyle:style];
	wormView.presentingView = aView;
	wormView.layer.cornerRadius = M_PI*4;
	wormView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.8];
	return wormView;
}

//enlarge HUDView to the Scrren
- (void)enlargeHUD {
	self.transform = CGAffineTransformMakeScale(0.1, 0.1);
	[UIView animateKeyframesWithDuration:0.6 delay:0.0 options:0 animations:^{
		
		[UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
			self.transform = CGAffineTransformMakeScale(1.3, 1.3);
		}];
		[UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
			self.transform = CGAffineTransformIdentity;
		}];
		
	} completion:nil];
}

- (void)loadingWorm {
	self.isShowing = YES;
	[self.presentingView addSubview:self];
	[self firstWormAnimation];
	[self secondWormAnimation];
	[self thirdWormAnimation];
	[self enlargeHUD];
	
}
- (void)endLoading {
	[UIView animateKeyframesWithDuration:0.6 delay:0 options:0 animations:^{
		[UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
			self.transform = CGAffineTransformMakeScale(1.2, 1.2);
		}];
		[UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
			self.transform = CGAffineTransformMakeScale(0.1, 0.1);
		}];
	} completion:^(BOOL finished) {
		self.isShowing = NO;
		[self.firstWormShapeLayer removeAnimationForKey:kWormAnimationFirst];
		[self.secondWormShapeLayer removeAnimationForKey:kWormAnimationSecond];
		[self.thirdWormShapeLayer removeAnimationForKey:kWormAnimationThird];
		[self removeFromSuperview];
	}];
}

- (instancetype)initWithFrame:(CGRect)frame HUDStyle:(TWWormHUDStyle)style {
	
	self = [super initWithFrame:frame];
	if (!self) {
		return nil;
	}
	
	_hudStyle = style;
	
	CAShapeLayer *firstWorm = [[CAShapeLayer alloc] init];
	//animation path
	firstWorm.path = [self createWormPath];
	//line width
	firstWorm.lineWidth = wormHUDViewLineWidth;
	//set line start and end shape round
	firstWorm.lineCap = kCALineCapRound;
	//set join shape round
//	firstWorm.lineJoin = kCALineCapRound;
	firstWorm.strokeColor = [UIColor redColor].CGColor;
	//fill the view that path covered
	firstWorm.fillColor = [UIColor clearColor].CGColor;
	firstWorm.actions = [NSDictionary dictionaryWithObjectsAndKeys:
						  [NSNull null],@"strokeStart",
						  [NSNull null],@"strokeEnd", nil];
	
	CAShapeLayer *secondWorm = [[CAShapeLayer alloc] init];
	secondWorm.path = [self createWormPath];
	secondWorm.lineWidth = wormHUDViewLineWidth;
	secondWorm.lineCap = kCALineCapRound;
	secondWorm.lineJoin = kCALineCapRound;
	secondWorm.strokeColor = [UIColor yellowColor].CGColor;
	secondWorm.fillColor = [UIColor clearColor].CGColor;
	secondWorm.actions = [NSDictionary dictionaryWithObjectsAndKeys:
						 [NSNull null],@"strokeStart",
						 [NSNull null],@"strokeEnd", nil];
	
	CAShapeLayer *thirdWorm = [[CAShapeLayer alloc] init];
	thirdWorm.path = [self createWormPath];
	thirdWorm.lineWidth = wormHUDViewLineWidth;
	thirdWorm.lineCap = kCALineCapRound;
	thirdWorm.lineJoin = kCALineCapRound;
	thirdWorm.strokeColor = [UIColor greenColor].CGColor;
	thirdWorm.fillColor = [UIColor clearColor].CGColor;
	thirdWorm.actions = [NSDictionary dictionaryWithObjectsAndKeys:
						 [NSNull null],@"strokeStart",
						 [NSNull null],@"strokeEnd",nil];
	
	[self.layer addSublayer:firstWorm];
	[self.layer addSublayer:secondWorm];
	[self.layer addSublayer:thirdWorm];
	self.firstWormShapeLayer = firstWorm;
	self.secondWormShapeLayer = secondWorm;
	self.thirdWormShapeLayer = thirdWorm;
	return self;
}

- (CGPathRef)createWormPath {
	//set path start position
	CGPoint center = CGPointMake(self.frame.size.width*9/10, self.frame.size.height/2);
	//two hemicycle together
	CGFloat radius = (wormHUDViewWidth/2.0) / 2.0;
	//create first hemicycle bezierPath
	UIBezierPath *wormPath = [UIBezierPath bezierPathWithArcCenter:center
															radius:radius
														startAngle:M_PI
														  endAngle:2*M_PI
														 clockwise:YES];
	//add another after that
	[wormPath addArcWithCenter:CGPointMake(center.x+radius*2, center.y)
						radius:radius
					startAngle:M_PI
					  endAngle:2*M_PI
					 clockwise:YES];
	//return CGPath reference.(CAShapeLayer path is CGPathRef)
	return wormPath.CGPath;
}

- (CABasicAnimation *)wormAnimationWithKeyPath:(NSString *)path toValue:(id)endValue fromValue:(id)value duration:(CGFloat)duration beginTime:(CGFloat)time timingFunction:(CAMediaTimingFunction *)timingFunction fillMode:(NSString *)mode {
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:path];
	animation.toValue = endValue;
	animation.fromValue = value;
	animation.duration = duration;
	animation.beginTime = time;
	animation.timingFunction = timingFunction;
	animation.fillMode = mode;
	return animation;
}

//Core animation of worm stretch
- (CAAnimationGroup *)animateValueA:(CGFloat)valueA fromValue:(CGFloat)endValueA duration:(CGFloat)durationA begintime:(CGFloat)timeA
							  value:(CGFloat)valueB fromValue:(CGFloat)endValueB duration:(CGFloat)durationB begintime:(CGFloat)timeB
							  value:(CGFloat)valueC fromValue:(CGFloat)endValueC duration:(CGFloat)durationC begintime:(CGFloat)timeC
							  value:(CGFloat)valueD fromValue:(CGFloat)endValueD duration:(CGFloat)durationD begintime:(CGFloat)timeD {
	
	//1.worm stretch animation
	//2.keep view after animation
	CAMediaTimingFunction *easeInAndOut = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	CAMediaTimingFunction *customeTime = [CAMediaTimingFunction functionWithControlPoints:0.42 :0.0 :1.0 :0.55];
	
	CABasicAnimation *strokeEndAnimation = [self wormAnimationWithKeyPath:@"strokeEnd"
																  toValue:[NSNumber numberWithFloat:valueA]
																fromValue:[NSNumber numberWithFloat:endValueA]
																 duration:durationA
																beginTime:timeA
														   timingFunction:customeTime
																 fillMode:kCAFillModeForwards];
	//虫子收缩
	CABasicAnimation *strokeStartAnimation = [self wormAnimationWithKeyPath:@"strokeStart"
																	toValue:[NSNumber numberWithFloat:valueB]
																  fromValue:[NSNumber numberWithFloat:endValueB]
																   duration:durationB
																  beginTime:timeB
															 timingFunction:easeInAndOut
																   fillMode:kCAFillModeForwards];
	//虫子拉伸2
	CABasicAnimation *strokeEndAnimation2 = [self wormAnimationWithKeyPath:@"strokeEnd"
																   toValue:[NSNumber numberWithFloat:valueC]
																 fromValue:[NSNumber numberWithFloat:endValueC]
																  duration:durationC
																 beginTime:timeC
															timingFunction:customeTime
																  fillMode:kCAFillModeForwards];
	//虫子收缩2
	CABasicAnimation *strokeStartAnimation2 = [self wormAnimationWithKeyPath:@"strokeStart"
																	 toValue:[NSNumber numberWithFloat:valueD]
																   fromValue:[NSNumber numberWithFloat:endValueD]
																	duration:durationD
																   beginTime:timeD
															  timingFunction:easeInAndOut
																	fillMode:kCAFillModeForwards];
	//X alias moving animation
	CABasicAnimation *xTranslationAnimation = [self wormAnimationWithKeyPath:@"transform.translation.x"
																	 toValue:[NSNumber numberWithFloat:(wormHUDViewWidth/2.0)/-1.0]
																   fromValue:[NSNull null]
																	duration:1.18
																   beginTime:0.0
															  timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]
																	fillMode:kCAFillModeForwards];
	CABasicAnimation *xTranslationAnimation2 = [self wormAnimationWithKeyPath:@"transform.translation.x"
																	  toValue:[NSNumber numberWithFloat:((wormHUDViewWidth/2.0)/-1.0) *2]
																	fromValue:[NSNull null]
																	 duration:1.18
																	beginTime:1.20
															   timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]
																	 fillMode:kCAFillModeForwards];
	
	
	CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
	animationGroup.animations = [NSArray arrayWithObjects: strokeStartAnimation, strokeEndAnimation, xTranslationAnimation,
															strokeEndAnimation2,strokeStartAnimation2,xTranslationAnimation2,nil];
	animationGroup.repeatCount = HUGE_VALF;
	animationGroup.duration = kWormDuration * 2;
	
	return animationGroup;
}

- (void)firstWormAnimation {
	CAAnimationGroup *animationGroup = [self animateValueA:0.5 fromValue:0 duration:0.75 begintime:0
													 value:0.5 fromValue:0 duration:0.45 begintime:0.75
													 value:0.5+0.5 fromValue:0.5+0 duration:0.75 begintime:1.20
													 value:0.5+0.5 fromValue:0.5+0 duration:0.45 begintime:0.75+kWormDuration];
	
	[self.firstWormShapeLayer addAnimation:animationGroup forKey:kWormAnimationFirst];
}

- (void)secondWormAnimation {
	
	CAAnimationGroup *animationGroup = [self animateValueA:0.5 fromValue:0.010 duration:0.75 begintime:0
													 value:0.49 fromValue:0 duration:0.70 begintime:0.50
													 value:0.5+0.5 fromValue:0.5+0 duration:0.75 begintime:1.20+0.15
													 value:0.5+0.5 fromValue:0.5+0 duration:0.30 begintime:0.15+0.75+kWormDuration];
	
	[self.secondWormShapeLayer addAnimation:animationGroup forKey:kWormAnimationSecond];
}

- (void)thirdWormAnimation {
	
	CAAnimationGroup *animationGroup = [self animateValueA:0.5 fromValue:0.010 duration:0.75 begintime:0
													 value:0.490 fromValue:0 duration:0.90 begintime:0.25
													 value:0.5+0.5 fromValue:0.5+0 duration:0.75 begintime:1.20+0.15+0.20
													 value:0.5+0.5 fromValue:0.5+0 duration:0.30 begintime:0.15+0.75+1.20];
	
	[self.thirdWormShapeLayer addAnimation:animationGroup forKey:kWormAnimationThird];
}

@end
