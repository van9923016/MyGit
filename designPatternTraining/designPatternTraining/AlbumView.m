//
//  AlbumView.m
//  designPatternTraining
//
//  Created by Wen Tan on 12/21/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "AlbumView.h"

@interface AlbumView ()

@property (nonatomic, strong) UIImageView *coverImgView;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end


@implementation AlbumView

- (instancetype)initWithFrame:(CGRect)frame albumCover:(NSString *)albumCover {
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor blackColor];
		_coverImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, frame.size.width-10, frame.size.height-10)];
		[self addSubview:_coverImgView];
		
		_indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		_indicator.center = self.center;
		[_indicator startAnimating];
		[self addSubview:_indicator];
		
		//post notification through NSNotificationCenter singleton
		[[NSNotificationCenter defaultCenter] postNotificationName:@"BLDownloadImageNotification"
															object:self
														  userInfo:@{@"imageView" : _coverImgView,
																	 @"coverURL"  : albumCover
																	 }];
	}
	return self;
}
@end
