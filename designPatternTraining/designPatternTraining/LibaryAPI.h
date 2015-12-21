//
//  LibaryAPI.h
//  designPatternTraining
//
//  Created by Wen Tan on 12/21/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Album.h"

@interface LibaryAPI : NSObject

+ (LibaryAPI *)sharedInstance;

- (NSArray *)getAlbums;
- (void)addAlbum:(Album *)album atIndex:(int)index;
- (void)deleteAlbumAtIndex:(int)index;

@end
