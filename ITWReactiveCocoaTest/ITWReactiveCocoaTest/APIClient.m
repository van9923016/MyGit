//
//  APIClient.m
//  ITWReactiveCocoaTest
//
//  Created by Wen Tan on 11/28/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "APIClient.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

static NSString * const APIClientDefaultEndpoint = @"http://localhost:1234";

@interface APIClient ()

@property (strong, nonatomic) AFHTTPRequestOperationManager *requestManager;

@end

@implementation APIClient

//create sharedClient Singleton
+ (instancetype)sharedClient {
	static APIClient *apiClient = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		apiClient = [[APIClient alloc] init];
	});
	return apiClient;
}

- (id)init {
	self = [super init];
	if (self) {
		self.requestManager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:APIClientDefaultEndpoint]];
	}
	return self;
}

- (RACSignal *)createAccountForEmail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName {
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		AFHTTPRequestOperation *operation = [self.requestManager
											 POST:@"/accounts"
											 parameters:@{
														  @"first_name": firstName,
														  @"last_name": lastName,
														  @"email": email,
														  }
											 success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
												 [subscriber sendNext:responseObject];
												 [subscriber sendCompleted];
											 }
											 failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
												 [subscriber sendError:[NSError errorWithDomain:@"com.example"
																						   code:error.code
																					   userInfo:@{NSLocalizedFailureReasonErrorKey : error.localizedFailureReason ?: @"Failed to createAccount"}]];
											 }];
		return [RACDisposable disposableWithBlock:^{
//			return disposable racsignal and cancel network operation
			[operation cancel];
		}];
	}];
}
@end
