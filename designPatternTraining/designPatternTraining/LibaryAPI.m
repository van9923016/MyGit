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
	}
	return self;
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








@end
