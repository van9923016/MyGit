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
NSString *const kWormAniamtionSecond = @"kWormAnimationSecond";
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



@interface TWWormView ()

@property (nonatomic, strong) CAShapeLayer *firstWormShapeLayer;
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
	firstWorm.fillColor = [UIColor clearColor].CGColor;
	firstWorm.actions = [NSDictionary dictionaryWithObjectsAndKeys:
						  [NSNull null],@"strokeStart",
						  [NSNull null],@"strokeEnd", nil];
	
	[self.layer addSublayer:firstWorm];
	self.firstWormShapeLayer = firstWorm;
	[self firstWormAnimation];
	
	
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
	
	
	
	CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
	animationGroup.animations = [NSArray arrayWithObjects: strokeEndAnimation, strokeStartAnimation, nil];
	animationGroup.repeatCount = HUGE_VALF;
	//动画总时间应该以组中动画时间最长为标准
	animationGroup.duration = kWormDuration * 2;
	[self.firstWormShapeLayer addAnimation:animationGroup forKey:kWormAnimationFirst];
	

}

@end
