//
//  APIClient.h
//  ITWReactiveCocoaTest
//
//  Created by Wen Tan on 11/28/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>

@class RACSignal;

@interface APIClient : NSObject

+ (instancetype)sharedClient;

- (RACSignal *)createAccountForEmail:(NSString *)email
						   firstName:(NSString *)firstName
							lastName:(NSString *)lastName;

@end
