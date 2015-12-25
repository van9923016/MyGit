//
//  HorizontalScroller.m
//  designPatternTraining
//
//  Created by Wen Tan on 12/23/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "HorizontalScroller.h"

#define VIEW_PADDING 10
#define VIEW_DEIMENSIONS 100
#define VIEWS_OFFSET 100

@interface HorizontalScroller()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scroller;

@end

@implementation HorizontalScroller

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		self.scroller.delegate = self;
		[self addSubview:self.scroller];
		
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
											  initWithTarget:self
											  action:@selector(scrollerTapped:)];
		[self.scroller addGestureRecognizer:tapGesture];
	}
	
	return self;
}

- (void)scrollerTapped:(UITapGestureRecognizer *)gesture {
	CGPoint location = [gesture locationInView:gesture.view];
	// we can't use an enumerator here, because we don't want to enumerate over ALL of the UIScrollView subviews.
	// we want to enumerate only the subviews that we added
	
	//detect tapped view in UIScroll view and center it
	for (int index = 0; index < [self.delegate numberOfViewsForHorizontalScroller:self]; index++) {
		UIView *view = self.scroller.subviews[index];
		if (CGRectContainsPoint(view.frame, location)) {
			[self.delegate horizontalScroller:self clickedViewAtIndex:index];
			//set contentoffset to center it in scroll view
			CGPoint contentOffset = CGPointMake(view.frame.origin.x - self.frame.size.width/2 + view.frame.size.width/2, 0);
			[self.scroller setContentOffset:contentOffset animated:YES];
			break;
		}
	}
}

- (void)reload {
	
	//nothing to load if there's no delegate
	if (self.delegate == nil) return;
	
	//remove all subviews
	[self.scroller.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		[obj removeFromSuperview];
	}];
	
	//xValue is the starting point of the views inside the scroller
	CGFloat xValue = VIEWS_OFFSET;
	for (int i = 0; i < [self.delegate numberOfViewsForHorizontalScroller:self]; i++) {
		//add a view at the right position
		xValue += VIEW_PADDING;
		UIView *view = [self.delegate horizontalScroller:self viewAtIndex:i];
		view.frame = CGRectMake(xValue, VIEW_PADDING, VIEW_DEIMENSIONS, VIEW_DEIMENSIONS);
		[self.scroller addSubview:view];
		xValue += VIEW_DEIMENSIONS + VIEW_PADDING;
	}
	
	//set contentSize
	[self.scroller setContentSize:CGSizeMake(xValue+VIEWS_OFFSET, self.frame.size.height)];
	
	//if has an initial view, then center it
	if ([self.delegate respondsToSelector:@selector(initialViewIndexForHorizontalScroller:)]) {
		NSInteger initialView = [self.delegate initialViewIndexForHorizontalScroller:self];
		[self.scroller setContentOffset:CGPointMake(initialView * (VIEW_DEIMENSIONS + (2*VIEW_PADDING)), 0)
							   animated:YES];
	}
	
	
}

- (void)centerCurrentView {
	int xFinal = self.scroller.contentOffset.x + (VIEWS_OFFSET/2) + VIEW_PADDING;
	int viewIndex = xFinal / (VIEW_DEIMENSIONS + (2*VIEW_PADDING));
	xFinal = viewIndex * (VIEW_DEIMENSIONS + (2*VIEW_PADDING));
	[self.scroller setContentOffset:CGPointMake(xFinal, 0) animated:YES];
	[self.delegate horizontalScroller:self clickedViewAtIndex:viewIndex];
	
}

//when this scrollview move to superview then reload it.
//The didMoveToSuperview message is sent to a view when it’s added to another view as a subview.
- (void)didMoveToSuperview {
	[self reload];
}

#pragma mark -- ScrollView delegate 

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	if (!decelerate) {
		[self centerCurrentView];
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	[self centerCurrentView];
}

@end
