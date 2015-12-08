//
//  FRPCollectionCellCollectionViewCell.m
//  FRPPixels
//
//  Created by Wen Tan on 12/3/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "FRPCell.h"
#import "FRPPhotoModel.h"

@interface FRPCell ()

@property (nonatomic, weak) UIImageView *imageView;
//@property (nonatomic, strong) RACDisposable *subscription;
//replace subscription property
@property (nonatomic, strong) FRPPhotoModel *photoModel;

@end

@implementation FRPCell

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (!self) {
		return nil;
	}
	//confgure self
	self.backgroundColor = [UIColor darkGrayColor];
	
	//configure subviews
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
	imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	[self.contentView addSubview:imageView];
	self.imageView = imageView;
	
	RAC(self.imageView, image) = [[RACObserve(self, photoModel.thumbnailData) ignore:nil] map:^id(id value) {
		return [UIImage imageWithData:value];
	}];
	
	return self;
}

//configure cell data and subview image
//- (void)setPhotoModel:(FRPPhotoModel *)photoModel {
//	
//	self.subscription = [[[RACObserve(photoModel, thumbnailData) filter:^BOOL(id value) {
//		return value != nil;
//	}] map:^id(id value) {
//		return [UIImage imageWithData:value];
//	}] setKeyPath:@keypath(self.imageView, image) onObject:self.imageView];
//	
//}

- (void)prepareForReuse {
	[super prepareForReuse];
	
//	[self.subscription dispose];
//	self.subscription = nil;
}
@end
