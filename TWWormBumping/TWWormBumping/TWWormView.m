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
NSString *const kWormAnimationFirst  = @"kWormAnimationFirst";
NSString *const kWormAnimationSecond = @"kWormAnimationSecond";
NSString *const kWormAnimationThird  = @"kWormAnimationThird";

//动画半径为HUD尺寸的一半
static NSUInteger kHUDLineWidthSmall     = 4.0f;
static NSUInteger kHUDWidthSmall     = 25.0f;
static NSUInteger kHUDHeightSmall    = 25.0f;

static NSUInteger kHUDLineWidth         = 6.0f;
static NSUInteger kHUDWidth          = 40.0f;
static NSUInteger kHUDHeight         = 40.0f;

static NSUInteger kHUDLineWidthLarge    = 8.0f;
static NSUInteger kHUDWidthLarge     = 80.0f;
static NSUInteger kHUDHeightLarge    = 80.0f;

static NSUInteger kWormDuration      = 1.2f;

static NSInteger wormHUDViewWidth   = 0;
static NSInteger wormHUDViewHeight  = 0;
static NSInteger wormHUDViewLineWidth   = 0;
//////////////////////////////////////////////////

@interface TWWormView ()

@property (nonatomic, strong) CAShapeLayer *firstWormShapeLayer;
@property (nonatomic, strong) CAShapeLayer *secondWormShapeLayer;
@property (nonatomic, strong) CAShapeLayer *thirdWormShapeLayer;
@property (nonatomic, assign) TWWormHUDStyle hudStyle;
@property (nonatomic,weak) UIView *presentingView;

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
	firstWorm.lineJoin = kCALineCapRound;
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

- (CABasicAnimation *)wormAnimationWithKeyPath:(NSString *)path toValue:(id)endValue fromValue:(id)value duration:(float)duration beginTime:(float)time timingFunction:(CAMediaTimingFunction *)timingFunction fillMode:(NSString *)mode {
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:path];
	animation.toValue = endValue;
	animation.fromValue = value;
	animation.duration = duration;
	animation.beginTime = time;
	animation.timingFunction = timingFunction;
	animation.fillMode = mode;
	return animation;
}

- (void)firstWormAnimation {
	//1.worm stretch animation
	CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
	strokeEndAnimation.toValue = [NSNumber numberWithFloat:0.5];
	strokeEndAnimation.fromValue = [NSNumber numberWithFloat:0];
	strokeEndAnimation.duration = 0.75;
	strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.42 :0.0 :1.0 :0.55];
	//keep view after animation
	strokeEndAnimation.fillMode = kCAFillModeForwards;
	
	//2.虫子缩小
	CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
	strokeStartAnimation.toValue = [NSNumber numberWithFloat:0.5];
	strokeStartAnimation.fromValue = [NSNumber numberWithFloat:0];
	strokeStartAnimation.duration = 0.45;
	//如果不被Group加入的话,CACurrentMediaTime() + 0.75 才表示延迟0.75秒.
	strokeStartAnimation.beginTime = 0.75;//延迟一秒执行
	strokeStartAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	strokeStartAnimation.fillMode = kCAFillModeForwards;
	
	//虫子拉伸2
	CABasicAnimation *strokeEndAnimation2= [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
	strokeEndAnimation2.toValue = [NSNumber numberWithFloat:0.5+0.5];
	strokeEndAnimation2.fromValue = [NSNumber numberWithFloat:0.5+0];
	strokeEndAnimation2.duration = 0.75;
	strokeEndAnimation2.beginTime = 1.2;
	strokeEndAnimation2.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.42 :0.0 :1.0 :0.55];
	strokeEndAnimation2.fillMode = kCAFillModeForwards;
	
	//虫子收缩2
	CABasicAnimation *strokeStartAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
	strokeStartAnimation2.toValue = [NSNumber numberWithFloat:0.5+0.5];
	strokeStartAnimation2.fromValue = [NSNumber numberWithFloat:0.5+0];
	strokeStartAnimation2.duration = 0.45;
	strokeStartAnimation2.beginTime = 1.2+0.75;
	strokeStartAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	strokeStartAnimation2.fillMode= kCAFillModeForwards;
	
	//X alias moving animation
	CABasicAnimation *xTranslationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
	xTranslationAnimation.toValue = [NSNumber numberWithFloat:(40/-1.0)];
	xTranslationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	xTranslationAnimation.duration = 1.18;
	xTranslationAnimation.fillMode = kCAFillModeForwards;
	
	CABasicAnimation *xTranslationAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
	xTranslationAnimation2.toValue = [NSNumber numberWithFloat:(40/-1.0)*2];
	xTranslationAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	xTranslationAnimation2.duration = 1.18;
	xTranslationAnimation2.beginTime = 1.20;
	xTranslationAnimation2.fillMode = kCAFillModeForwards;
	
	//Animation Group
	CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
	animationGroup.animations = [NSArray arrayWithObjects: strokeEndAnimation, strokeStartAnimation, strokeEndAnimation2,strokeStartAnimation2,xTranslationAnimation,xTranslationAnimation2,nil];
	animationGroup.repeatCount = HUGE_VALF;
	//动画总时间应该以组中动画时间最长为标准
	animationGroup.duration = kWormDuration * 2;
	[self.firstWormShapeLayer addAnimation:animationGroup forKey:nil];
}

- (void)secondWormAnimation {
	
	CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
	strokeEndAnimation.toValue = [NSNumber numberWithFloat:0.5];
	strokeEndAnimation.fromValue = [NSNumber numberWithFloat:0.010];
	strokeEndAnimation.duration = 0.75;
	strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.42 :0.0 :1.0 :0.55];
	strokeEndAnimation.fillMode = kCAFillModeForwards;
	
	
	CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
	strokeStartAnimation.toValue = [NSNumber numberWithFloat:0.490];
	strokeStartAnimation.fromValue = [NSNumber numberWithFloat:0];
	strokeStartAnimation.duration = 0.70;
	strokeStartAnimation.beginTime = 0.50;
	strokeStartAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	strokeStartAnimation.fillMode = kCAFillModeForwards;
	
	
	CABasicAnimation *strokeEndAnimation2= [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
	strokeEndAnimation2.toValue = [NSNumber numberWithFloat:0.5+0.5];
	strokeEndAnimation2.fromValue = [NSNumber numberWithFloat:0.5+0];
	strokeEndAnimation2.duration = 0.75;
	strokeEndAnimation2.beginTime = 1.2+0.15;
	strokeEndAnimation2.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.42 :0.0 :1.0 :0.55];
	strokeEndAnimation2.fillMode = kCAFillModeForwards;
	
	CABasicAnimation *strokeStartAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
	strokeStartAnimation2.toValue = [NSNumber numberWithFloat:0.5+0.5];
	strokeStartAnimation2.fromValue = [NSNumber numberWithFloat:0.5+0];
	strokeStartAnimation2.duration = 0.30;
	strokeStartAnimation2.beginTime = 0.15+0.75+1.2;
	strokeStartAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	strokeStartAnimation2.fillMode= kCAFillModeForwards;
	
	
	CABasicAnimation *xTranslationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
	xTranslationAnimation.toValue = [NSNumber numberWithFloat:(40/-1.0)];
	xTranslationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	xTranslationAnimation.duration = 1.18;
	NSLog(@"%@",xTranslationAnimation.fromValue);
	xTranslationAnimation.fillMode = kCAFillModeForwards;
	
	CABasicAnimation *xTranslationAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
	xTranslationAnimation2.toValue = [NSNumber numberWithFloat:(40/-1.0)*2];
	xTranslationAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	xTranslationAnimation2.duration = 1.18;
	xTranslationAnimation2.beginTime = 1.20;
	xTranslationAnimation2.fillMode = kCAFillModeForwards;
	
	CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
	animationGroup.animations = [NSArray arrayWithObjects: strokeEndAnimation, strokeStartAnimation, strokeEndAnimation2,strokeStartAnimation2,xTranslationAnimation,xTranslationAnimation2,nil];
	animationGroup.repeatCount = HUGE_VALF;
	
	animationGroup.duration = kWormDuration * 2;
	[self.secondWormShapeLayer addAnimation:animationGroup forKey:nil];
}

- (void)thirdWormAnimation {
	
	CABasicAnimation *strokeEndAnimation = [self wormAnimationWithKeyPath:@"strokeEnd"
																  toValue:[NSNumber numberWithFloat:0.5]
																fromValue:[NSNumber numberWithFloat:0.010]
																 duration:0.75
																beginTime:0
														   timingFunction:[CAMediaTimingFunction functionWithControlPoints:0.42 :0.0 :1.0 :0.55]
																 fillMode:kCAFillModeForwards];
	
	CABasicAnimation *strokeStartAnimation = [self wormAnimationWithKeyPath:@"strokeStart"
																	toValue:[NSNumber numberWithFloat:0.490]
																  fromValue:[NSNumber numberWithFloat:0.0]
																   duration:0.90
																  beginTime:0.25
															 timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
																   fillMode:kCAFillModeForwards];
	
	CABasicAnimation *strokeEndAnimation2 = [self wormAnimationWithKeyPath:@"strokeEnd"
																   toValue:[NSNumber numberWithFloat:0.5+0.5]
																 fromValue:[NSNumber numberWithFloat:0.5+0]
																  duration:0.75
																 beginTime:1.2+0.15+0.20
															timingFunction:[CAMediaTimingFunction functionWithControlPoints:0.42 :0.0 :1.0 :0.55]
																  fillMode:kCAFillModeForwards];
	
	CABasicAnimation *strokeStartAnimation2 = [self wormAnimationWithKeyPath:@"strokeStart"
																	 toValue:[NSNumber numberWithFloat:0.5+0.5]
																   fromValue:[NSNumber numberWithFloat:0.5+0]
																	duration:0.30
																   beginTime:0.15+0.75+1.2
															  timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
																	fillMode:kCAFillModeForwards];
	
	
	
	CABasicAnimation *xTranslationAnimation = [self wormAnimationWithKeyPath:@"transform.translation.x"
																	 toValue:[NSNumber numberWithFloat:(40/-1.0)]
																   fromValue:0
																	duration:1.18
																   beginTime:0.0
															  timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
																	fillMode:kCAFillModeForwards];
	CABasicAnimation *xTranslationAnimation2 = [self wormAnimationWithKeyPath:@"transform.translation.x"
																	  toValue:[NSNumber numberWithFloat:(40/-1.0)*2]
																	fromValue:0
																	 duration:1.18
																	beginTime:1.20
															   timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
																	 fillMode:kCAFillModeForwards];

	CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
	animationGroup.animations = [NSArray arrayWithObjects: strokeStartAnimation, strokeEndAnimation, xTranslationAnimation,strokeEndAnimation2,strokeStartAnimation2,xTranslationAnimation2,nil];
	animationGroup.repeatCount = HUGE_VALF;
	
	animationGroup.duration = kWormDuration * 2;
	[self.thirdWormShapeLayer addAnimation:animationGroup forKey:nil];
}



@end
