//
//  CoreTextView.h
//  CoreTextTest
//
//  Created by Wen Tan on 1/2/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTColumnView.h"
@interface CoreTextView : UIScrollView<UIScrollViewDelegate>

@property (assign, nonatomic) float frameXOffset;
@property (assign, nonatomic) float frameYOffset;
@property (strong, nonatomic) NSAttributedString *attString;
@property (strong, nonatomic) NSMutableArray *frames;
@property (strong, nonatomic) NSArray		*images;


- (void)buildFrames;
- (void)setAttString:(NSAttributedString *)attString withImages:(NSArray *)imgs;
- (void)attachImagesWithframe:(CTFrameRef)ref inColumnView:(CTColumnView *)col;

@end
