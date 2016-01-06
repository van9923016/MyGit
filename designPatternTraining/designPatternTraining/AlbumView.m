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
		
		//the KVO design pattern: add observer to self.coverImgView property
		[self.coverImgView addObserver:self forKeyPath:@"image" options:0 context:nil];
		
		//post notification through NSNotificationCenter singleton
		[[NSNotificationCenter defaultCenter] postNotificationName:@"BLDownloadImageNotification"
															object:self
														  userInfo:@{@"imageView" : _coverImgView,
																	 @"coverURL"  : albumCover
																	 }];
	}
	return self;
}

- (void)dealloc {
	[self.coverImgView removeObserver:self forKeyPath:@"image"];
}



#pragma mark -- Observer pattern
//This message is sent to the receiver when the value at the specified key path relative to the given object has changed.
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
	if ([keyPath isEqualToString:@"image"]) {
		[self.indicator stopAnimating];
	}
}


@end
