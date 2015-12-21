//
//  HTTPClient.m
//  designPatternTraining
//
//  Created by Wen Tan on 12/20/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "HTTPClient.h"

@implementation HTTPClient

- (instancetype)getRequest:(NSString *)URLString {
	return nil;
}

- (instancetype)postRequest:(NSString *)URLString body:(NSString *)body {
	return nil;
}

- (UIImage *)downloadImage:(NSString *)URLString {
	NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:URLString]];
	
	return [UIImage imageWithData:data];
}
@end
