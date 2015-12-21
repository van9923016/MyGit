//
//  PersistencyManager.m
//  designPatternTraining
//
//  Created by Wen Tan on 12/21/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "PersistencyManager.h"

@interface PersistencyManager ()

@property (nonatomic, copy, readwrite) NSMutableArray *albums;

@end
@implementation PersistencyManager

- (instancetype)init {
	self = [super init];
	if (self) {
		_albums = [NSMutableArray arrayWithArray:@[[[Album alloc] initWithTitle:@"Best of Bowie"
																		 artist:@"David Bowie"
																	   coverURL:@"http://www.coversproject.com/static/thumbs/album/album_david%20bowie_best%20of%20bowie.png"
																		   year:@"1992"],
												   [[Album alloc] initWithTitle:@"It's My Life"
																		 artist:@"No Doubt"
																	   coverURL:@"http://www.coversproject.com/static/thumbs/album/album_no%20doubt_its%20my%20life%20%20bathwater.png"
																		   year:@"2003"],
												   [[Album alloc] initWithTitle:@"Nothing Like The Sun"
																		 artist:@"Sting"
																	   coverURL:@"http://www.coversproject.com/static/thumbs/album/album_sting_nothing%20like%20the%20sun.png"
																		   year:@"1999"],
												   [[Album alloc] initWithTitle:@"Staring at the Sun"
																		 artist:@"U2"
																	   coverURL:@"http://www.coversproject.com/static/thumbs/album/album_u2_staring%20at%20the%20sun.png"
																		   year:@"2000"],
												   [[Album alloc] initWithTitle:@"American Pie"
																		 artist:@"Madonna" coverURL:@"http://www.coversproject.com/static/thumbs/album/album_madonna_american%20pie.png"
																		   year:@"2000"]
												   ]];
	}
	
	return self;
}

- (NSArray *)getAlbums {
	return _albums;
}

- (void)addAlbum:(Album *)album atIndex:(int)index {
	
	if (_albums.count >= index) {
		[_albums insertObject:album atIndex:index];
	}else{
		[_albums addObject:album];
	}
}

- (void)deleteAlbumAtIndex:(int)index {
	[_albums removeObjectAtIndex:index];
}

@end
