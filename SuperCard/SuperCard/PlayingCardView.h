//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Wen Tan on 1/10/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic, assign) NSUInteger rank;
@property (nonatomic, copy) NSString *suit;
@property (nonatomic, assign) BOOL faceUp;

@end
