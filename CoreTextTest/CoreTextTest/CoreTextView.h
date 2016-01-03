//
//  CoreTextView.h
//  CoreTextTest
//
//  Created by Wen Tan on 1/2/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreTextView : UIScrollView<UIScrollViewDelegate>

@property (assign, nonatomic) float frameXOffset;
@property (assign, nonatomic) float frameYOffset;
@property (strong, nonatomic) NSAttributedString *attString;
@property (strong, nonatomic) NSMutableArray *frames;
@property (copy, nonatomic) NSArray		*images;


- (void)buildFrames;
- (void)setAttString:(NSAttributedString *)attString withImages:(NSArray *)imgs;

@end
