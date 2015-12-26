//
//  LibaryAPI.m
//  designPatternTraining
//
//  Created by Wen Tan on 12/21/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "LibaryAPI.h"
#import "HTTPClient.h"
#import "PersistencyManager.h"

@interface LibaryAPI()

@property (nonatomic, strong) PersistencyManager *persistencyManager;
@property (nonatomic, strong) HTTPClient		 *httpClient;
@property (nonatomic, assign) BOOL				  isOnline;

@end

@implementation LibaryAPI

+ (LibaryAPI *)sharedInstance {
	//Singleton design pattern
	static LibaryAPI *_sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedInstance = [[LibaryAPI alloc] init];
	});
	
	return _sharedInstance;
}

- (instancetype)init {
	self = [super init];
	if (self) {
		_persistencyManager = [[PersistencyManager alloc] init];
		_httpClient			= [[HTTPClient alloc] init];
		_isOnline			= NO;
		
		//once someone post a notification named BOLDownloadImageNotification then trigger downloadImage method.
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadImage:) name:@"BLDownloadImageNotification" object:nil];
	}
	return self;
}

- (void)dealloc {
	//add each observer must remove it at proper time
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

	//Facade design pattern
- (NSArray *)getAlbums {
	return [self.persistencyManager getAlbums];
}

- (void)addAlbum:(Album *)album atIndex:(int)index {
	
	[self.persistencyManager addAlbum:album atIndex:index];
	
	if (self.isOnline) {
		[self.httpClient postRequest:@"/api/addAlbum" body:[@(index) description]];
	}
}
- (void)deleteAlbumAtIndex:(int)index {
	
	[self.persistencyManager deleteAlbumAtIndex:index];
	
	if (self.isOnline) {
		[self.httpClient postRequest:@"/api/deleteAlbum" body:[@(index) description]];
	}
}

- (void)downloadImage:(NSNotification *)notification {
	//get data from notification
	UIImageView *imageView = notification.userInfo[@"imageView"];
	NSString *coverURL = notification.userInfo[@"coverURL"];
	
	imageView.image = [self.persistencyManager getImage:[coverURL lastPathComponent]];
	
	if (imageView.image == nil) {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
			UIImage *image = [self.httpClient downloadImage:coverURL];
			
			dispatch_sync(dispatch_get_main_queue(), ^{
				imageView.image = image;
				[self.persistencyManager saveImage:image
										  filename:[coverURL lastPathComponent]];
			});
		});
	}
}

- (void)saveAlbums {
	[self.persistencyManager saveAlbums];
}


@end
