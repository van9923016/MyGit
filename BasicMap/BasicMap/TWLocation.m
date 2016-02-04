//
//  TWLocation.m
//  BasicMap
//
//  Created by Wen Tan on 2/4/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "TWLocation.h"

@implementation TWLocation

- (instancetype)initWithName:(NSString *)locationName details:(NSString *) details latitude:(double)latitude longitude:(double)longitude {
	self = [super init];
	if (self) {
		_name = locationName;
		_details = details;
		_latitude = latitude;
		_longitude = longitude;
	}
	return self;
}

- (instancetype)init {
	return [self initWithName:@"未找到" details:@"Not Found" latitude:0 longitude:0];
}
@end
