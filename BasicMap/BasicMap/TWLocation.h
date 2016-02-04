//
//  TWLocation.h
//  BasicMap
//
//  Created by Wen Tan on 2/4/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWLocation : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *details;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

- (instancetype)initWithName:(NSString *)locationName details:(NSString *) details latitude:(double)latitude longitude:(double)longitude;

@end
