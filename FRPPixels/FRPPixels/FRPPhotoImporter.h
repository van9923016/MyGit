//
//  FRPPhotoImporter.h
//  FRPPixels
//
//  Created by Wen Tan on 12/2/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRPPhotoImporter : NSObject

//Tool to use FRP import photoModel to ViewController Array and show

//import thumbnail image
+ (RACSignal *)importPhotos;

//fetch full size photo data from photoModel
+ (RACReplaySubject *)fetchPhotoDetails:(FRPPhotoModel *)photoModel;

@end
