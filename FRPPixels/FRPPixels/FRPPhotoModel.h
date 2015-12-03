//
//  FRPPhotoModel.h
//  FRPPixels
//
//  Created by Wen Tan on 12/2/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRPPhotoModel : NSObject

@property (strong, nonatomic) NSString *photoName;
@property (strong, nonatomic) NSNumber *identifier;
@property (strong, nonatomic) NSString *photographerName;
@property (strong, nonatomic) NSNumber *rating;
@property (strong, nonatomic) NSString *thumbnailURL;
@property (strong, nonatomic) NSData   *thumbnailData;
@property (strong, nonatomic) NSString *fullsizedURL;
@property (strong, nonatomic) NSData   *fullsizedData;

@end
