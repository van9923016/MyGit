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
																	   coverURL:@"https://pic4.zhimg.com/76dc02d5a95fcf5284d1f0caca3e8827_b.png"
																		   year:@"1992"],
												   [[Album alloc] initWithTitle:@"It's My Life"
																		 artist:@"No Doubt"
																	   coverURL:@"https://pic4.zhimg.com/02ad7374a3ac2280e251861c027f16f3_b.jpg"
																		   year:@"2003"],
												   [[Album alloc] initWithTitle:@"Nothing Like The Sun"
																		 artist:@"Sting"
																	   coverURL:@"https://pic4.zhimg.com/4ae77c82154afddaa618f845e0a4b36f_b.jpg"
																		   year:@"1999"],
												   [[Album alloc] initWithTitle:@"Staring at the Sun"
																		 artist:@"U2"
																	   coverURL:@"https://pic2.zhimg.com/7b7f9734fd9524b4160410cc56127d55_b.jpg"
																		   year:@"2000"],
												   [[Album alloc] initWithTitle:@"American Pie"
																		 artist:@"Madonna"
																	   coverURL:@"https://pic3.zhimg.com/145c3de5dc89de8694fe29fe9dfaa616_b.jpg"
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

- (void)saveImage:(id)image filename:(NSString *)filename {
	//wirte UIImage as NSData to home directory
	filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",filename];
	NSData *data = UIImagePNGRepresentation(image);
	[data writeToFile:filename atomically:YES];
	
}

- (UIImage *)getImage:(NSString *)filename {
	//Get UIImage as NSData from home directory convert to UIImage;
	filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
	NSData *data = [NSData dataWithContentsOfFile:filename];
	return [UIImage imageWithData:data];
}

@end
