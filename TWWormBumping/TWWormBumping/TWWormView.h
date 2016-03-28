//
//  TWWormView.h
//  TWWormBumping
//
//  Created by Wen Tan on 3/28/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import <UIKit/UIKit.h>

//define HUD Style
typedef NS_ENUM(NSUInteger, TWWormHUDStyle) {
	TWWormHUDStyleSmall,	//25*25
	TWWormHUDStyleNormal,	//40*40
	TWWormHUDStyleLarge		//80*80
};


@interface TWWormView : UIView

@property (nonatomic) BOOL isShowing;

+ (instancetype)addWormHUDWithStyle:(TWWormHUDStyle)style toView:(UIView *)toView;
- (void)loadingWorm;
- (void)endLoading;

@end
