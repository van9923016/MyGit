//
//  FRPPhotoViewController.h
//  FRPPixels
//
//  Created by Wen Tan on 12/3/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FRPPhotoModel;

@interface FRPPhotoViewController : UIViewController

@property (nonatomic, readonly) NSInteger photoIndex;
@property (nonatomic, readonly) FRPPhotoModel *photoModel;

- (instancetype)initWithPhotoModel:(FRPPhotoModel *)photoModel index:(NSInteger)photoIndex;

@end
