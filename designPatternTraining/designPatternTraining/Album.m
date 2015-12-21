//
//  Album.m
//  designPatternTraining
//
//  Created by Wen Tan on 12/21/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "Album.h"

@implementation Album

//init Album model instance
- (instancetype)initWithTitle:(NSString *)title artist:(NSString *)artist coverURL:(NSString *)URL year:(NSString *)year {
	self = [super init];
	if (self) {
		_title = title;
		_artist = artist;
		_coverURL = URL;
		_year = year;
		_genre = @"Pop";
	}
	return self;
}

@end
