
//
//  FRPPhotoImporter.m
//  FRPPixels
//
//  Created by Wen Tan on 12/2/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "FRPPhotoImporter.h"

@implementation FRPPhotoImporter


+ (RACReplaySubject *)importPhotos {
	RACReplaySubject *subject = [[RACReplaySubject alloc] init];
	NSURLRequest *urlRequest = [self popularURLRequest];
	
//	depcreated async method
//	[NSURLConnection sendAsynchronousRequest:urlRequest
//									   queue:[NSOperationQueue mainQueue]
//						   completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//							   
//							   if (data) {
//								   id results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//								   NSLog(@"%@",results);
//								   //map block for subject
//								   id (^mapBlock)(NSDictionary *) = ^id(NSDictionary *photoDict) {
//									   //init model
//									   FRPPhotoModel *photoModel = [FRPPhotoModel new];
//									   //store fetched data to local model.
//									   [self configurePhotoModel:photoModel withDict:photoDict];
//									   [self downloadThumbnailForPhotoModel:photoModel];
//									   return photoModel;
//								   };
//								//FRP
//								   [subject sendNext:[[[results[@"photos"] rac_sequence] map:mapBlock] array]];
//								   [subject sendCompleted];
//							   }else{
//								   [subject sendError:connectionError];
//							   }
//						   }];
	
	NSURLSession *session = [NSURLSession sharedSession];
	NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
		if (data) {
			id results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
			NSLog(@"%@",results);
			//map block for subject
			id (^mapBlock)(NSDictionary *) = ^id(NSDictionary *photoDict) {
				//init model
				FRPPhotoModel *photoModel = [FRPPhotoModel new];
				//store fetched data to local model.
				[self configurePhotoModel:photoModel withDict:photoDict];
				[self downloadThumbnailForPhotoModel:photoModel];
				return photoModel;
			};
			//FRP
			[subject sendNext:[[[results[@"photos"] rac_sequence] map:mapBlock] array]];
			[subject sendCompleted];
		}else{
			[subject sendError:error];
		}
	}];
	[dataTask resume];
	return subject;
}

+ (NSURLRequest *)photoURLRequest:(FRPPhotoModel *)photoModel {
	return [myAppDelegate.apiHelper
			urlRequestForPhotoID:photoModel.identifier.integerValue];
}

+ (NSURLRequest *)popularURLRequest {
	return [myAppDelegate.apiHelper
			urlRequestForPhotoFeature:PXAPIHelperPhotoFeaturePopular
			resultsPerPage:100	page:0
			photoSizes:PXPhotoModelSizeThumbnail
			sortOrder:PXAPIHelperSortOrderRating
			except:PXPhotoModelCategoryNude];
}

+ (void)configurePhotoModel:(FRPPhotoModel *)photoModel withDict:(NSDictionary *)dict {
	//basic details fetched with the first basic request
    photoModel.photoName        = dict[@"name"];
    photoModel.identifier       = dict[@"id"];
    photoModel.photographerName = dict[@"user"][@"username"];
    photoModel.rating           = dict[@"rating"];
    photoModel.thumbnailURL     = [self urlForImageSize:3 inArray:dict[@"images"]];
	
	//extended attributes fetched with subsequent request
	if (dict[@"comments_count"]) {
		photoModel.fullsizedURL = [self urlForImageSize:4 inArray:dict[@"images"]];
	}
}

//parsing an array of dictionaries, each dict has a size and a URL, use FRP to return the url
+ (NSString *)urlForImageSize:(NSInteger)size inArray:(NSArray *)array {
	
	//define filter and map block
//	void (^testBlock)() = ^(){
//		NSLog(@"This is a block for test");
//	};
	
	BOOL (^filterBlock)(id) = ^BOOL(id value){
		return [value[@"size"] integerValue] == size;
	};
	
	id (^mapBlock)(id) = ^id(id value) {
		return value[@"url"];
	};
	
	return [[[[[array rac_sequence] filter:filterBlock] map:mapBlock] array] firstObject];
}

//+ (void)downloadThumbnailForPhotoModel:(FRPPhotoModel *)photoModel {
//	NSAssert(photoModel.thumbnailURL, @"Thumbnail URL must not be nil");
//	
//	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:photoModel.thumbnailURL]];
//	
//	[NSURLConnection sendAsynchronousRequest:request
//									   queue:[NSOperationQueue mainQueue]
//						   completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//							   photoModel.thumbnailData = data;
//	}];
//}

//+ (void)downloadFullsizedImageForPhotoModel:(FRPPhotoModel *)photoModel {
//	NSAssert(photoModel.fullsizedURL, @"Fullsize URL must not be nil");
//	
//	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:photoModel.fullsizedURL]];
//	[NSURLConnection sendAsynchronousRequest:request
//									   queue:[NSOperationQueue mainQueue]
//						   completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//							   photoModel.fullsizedData = data;
//	}];
//}


#pragma mark -- Refactor download thumbnail and full size picture
+ (void)downloadThumbnailForPhotoModel:(FRPPhotoModel *)photoModel {
	[self download:photoModel.thumbnailURL withCompletionHandler:^(NSData *data) {
		photoModel.thumbnailData = data;
	}];
}

+ (void)downloadFullsizedImageForPhotoModel:(FRPPhotoModel *)photoModel {
	[self download:photoModel.fullsizedURL withCompletionHandler:^(NSData *data) {
		photoModel.fullsizedData = data;
	}];
	
}

+ (void)download:(NSString *)urlString withCompletionHandler:(void(^)(NSData *data))completion {
	NSAssert(urlString, @"URL must not be nil");
	
//	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];

//	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//		if (completion) {
//			completion(data);
//		}
//	}];
	
	NSURLSession *session = [NSURLSession sharedSession];
	NSURLSessionDataTask *dataTask =  [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
		if(completion) {
			completion(data);
		}
	}];
	
	[dataTask resume];
	
}

+ (RACReplaySubject *)fetchPhotoDetails:(FRPPhotoModel *)photoModel {
	RACReplaySubject *subject = [RACReplaySubject subject];
	NSURLRequest *request = [self photoURLRequest:photoModel];
	
//	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//		if (data) {
//			id results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil][@"photo"];
//			[self configurePhotoModel:photoModel withDict:results];
//			[self downloadFullsizedImageForPhotoModel:photoModel];
//			[subject sendNext:photoModel];
//			[subject sendCompleted];
//
//		}else{
//			[subject sendError:connectionError];
//		}
//	}];
	
	NSURLSession *session = [NSURLSession sharedSession];
	NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
		if (data) {
			id results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil][@"photo"];
			
			[self configurePhotoModel:photoModel withDict:results];
			[self downloadFullsizedImageForPhotoModel:photoModel];
			
			[subject sendNext:photoModel];
			[subject sendCompleted];
		}else{
			[subject sendError:error];
		}
	}];
	
	[dataTask resume];
	return subject;
}
							   
							   
@end
