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

// call encodeWithCoder archive an instance of this class
- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.year forKey:@"year"];
	[aCoder encodeObject:self.title forKey:@"album"];
	[aCoder encodeObject:self.artist forKey:@"artist"];
	[aCoder encodeObject:self.coverURL forKey:@"coverURL"];
	[aCoder encodeObject:self.genre forKey:@"genre"];
}

//call initWithCoder when you unarchive an instance
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
	if (self) {
		_year = [aDecoder decodeObjectForKey:@"year"];
		_title = [aDecoder decodeObjectForKey:@"title"];
		_artist = [aDecoder decodeObjectForKey:@"artist"];
		_coverURL = [aDecoder decodeObjectForKey:@"coverURL"];
		_genre = [aDecoder decodeObjectForKey:@"genre"];
	}
	return self;
}

@end
