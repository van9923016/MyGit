//
//  HorizontalScroller.h
//  designPatternTraining
//
//  Created by Wen Tan on 12/23/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HorizontalScroller;

@protocol HorizontalScrollerDelegate <NSObject>

//protocol method declaration
@required
//ask the delegate how many view he wants to repsent inside the horizontal scroller
- (NSInteger)numberOfViewsForHorizontalScroller:(HorizontalScroller *)scroller;

//ask the delegate to return the view that should appear at <index>
- (UIView *)horizontalScroller:(HorizontalScroller *)scroller viewAtIndex:(int)index;

//inform the delegate what the view at <index> has been clicked
- (void)horizontalScroller:(HorizontalScroller *)scroller clickedViewAtIndex:(int)index;

@optional
//ask delegate for the index of the initial view to display.
//defaults is 0 if it's not implemented bby the delegate
- (NSInteger)initialViewIndexForHorizontalScroller:(HorizontalScroller *)scroller;


@end


@interface HorizontalScroller : UIView

//Prevent a retain cycle.
//If a class keeps a strong pointer to its delegate and the delegate keeps a strong pointer back to the conforming class
@property (weak) id<HorizontalScrollerDelegate> delegate;

- (void)reload;

@end
