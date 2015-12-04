//
//  FRPFullSizePhotoViewController.h
//  FRPPixels
//
//  Created by Wen Tan on 12/3/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FRPFullSizePhotoViewController;

@protocol FRPFullSizePhotoViewControllerDelegate <NSObject>

- (void)userDidScroll:(FRPFullSizePhotoViewController *)viewController toPhotoAtIndex:(NSInteger)index;

@end

@interface FRPFullSizePhotoViewController : UIViewController

- (instancetype)initwithPhotoModels:(NSArray *)photoModelArray currentPhotoIndex:(NSInteger)photoIndex;

@property (nonatomic, readonly) NSArray *photoModelArray;
@property (nonatomic, weak) id <FRPFullSizePhotoViewControllerDelegate> delegate;

@end
