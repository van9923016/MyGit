
//
//  FRPPhotoImporter.m
//  FRPPixels
//
//  Created by Wen Tan on 12/2/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "FRPPhotoImporter.h"

@implementation FRPPhotoImporter

//using parsed dict from urlRequest JSON Object.Give it to local photoModel
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

//Use this urlRequest to get full size image data
+ (NSURLRequest *)photoURLRequest:(FRPPhotoModel *)photoModel {
	return [myAppDelegate.apiHelper
			urlRequestForPhotoID:photoModel.identifier.integerValue];
}

//Use this urlQUest to get a series of image group data, like thumbnail collection
+ (NSURLRequest *)popularURLRequest {
	return [myAppDelegate.apiHelper
			urlRequestForPhotoFeature:PXAPIHelperPhotoFeatureFreshWeek
			resultsPerPage:100	page:0
			photoSizes:PXPhotoModelSizeThumbnail
			sortOrder:PXAPIHelperSortOrderRating
			except:PXPhotoModelCategoryNude];
}

//fetch thumbnail size image data
+ (RACReplaySubject *)importPhotos {
	RACReplaySubject *subject = [[RACReplaySubject alloc] init];
	NSURLRequest *urlRequest = [self popularURLRequest];
	
//	depcreated async method
	[NSURLConnection sendAsynchronousRequest:urlRequest
									   queue:[NSOperationQueue mainQueue]
						   completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
							   
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
								   [subject sendError:connectionError];
							   }
						   }];
	return subject;
}

//parsing an array of dictionaries, each dict has a size and a URL, use FRP to return the url
+ (NSString *)urlForImageSize:(NSInteger)size inArray:(NSArray *)array {
	
	//define filter and map block
	BOOL (^filterBlock)(id) = ^BOOL(id value){
		return [value[@"size"] integerValue] == size;
	};
	
	id (^mapBlock)(id) = ^id(id value) {
		return value[@"url"];
	};
	
	return [[[[[array rac_sequence] filter:filterBlock] map:mapBlock] array] firstObject];
}


#pragma mark -- Refactor download thumbnail and full size picture
+ (void)downloadThumbnailForPhotoModel:(FRPPhotoModel *)photoModel {
//	[self download:photoModel.thumbnailURL withCompletionHandler:^(NSData *data) {
//		photoModel.thumbnailData = data;
//	}];
	
	RAC(photoModel, thumbnailData) = [self download:photoModel.thumbnailURL];
}

+ (void)downloadFullsizedImageForPhotoModel:(FRPPhotoModel *)photoModel {
//	[self download:photoModel.fullsizedURL withCompletionHandler:^(NSData *data) {
//		photoModel.fullsizedData = data;
//	}];
	RAC(photoModel, fullsizedData) = [self download:photoModel.fullsizedURL];
	
}




//normal download way
+ (void)download:(NSString *)urlString withCompletionHandler:(void(^)(NSData *data))completion {
	NSAssert(urlString, @"URL must not be nil");
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];

	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
		if (completion) {
			completion(data);
		}
	}];
	
	//new session dataTaskWithURL method replace sendAsynchronousRequest
//	NSURLSession *session = [NSURLSession sharedSession];
//	NSURLSessionDataTask *dataTask =  [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//		if(completion) {
//			completion(data);
//		}
//	}];
//	
//	[dataTask resume];
	
}


+(RACSignal *)download:(NSString *)urlString {
	NSAssert(urlString, @"URL must not be nil");
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
	id(^mapBlock)(RACTuple *) = ^id(RACTuple *value) {
		return [value second];
	};
	return ([[[NSURLConnection rac_sendAsynchronousRequest:request]
			  map:mapBlock] deliverOn:[RACScheduler mainThreadScheduler]]);
}
//Fetch fullsize image data
//+ (RACReplaySubject *)fetchPhotoDetails:(FRPPhotoModel *)photoModel {
//	RACReplaySubject *subject = [RACReplaySubject subject];
//	NSURLRequest *request = [self photoURLRequest:photoModel];
//	
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
//	
//	return subject;
//}

//Refactor fetchPhotoDetails method
+ (RACSignal *)fetchPhotoDetails:(FRPPhotoModel *)photoModel {
	NSURLRequest *request = [self photoURLRequest:photoModel];
	
	id(^mapBlock)(RACTuple *) = ^id(RACTuple *value) {
		return [value second];
	};
	
	id(^parsingBlock)(NSData *) = ^id(NSData *data) {
		id results = [NSJSONSerialization JSONObjectWithData:data
													 options:0
													   error:nil][@"photo"];
		
		[self configurePhotoModel:photoModel withDict:results];
		[self downloadFullsizedImageForPhotoModel:photoModel];
		return photoModel;
	};
	
	return [[[[[[NSURLConnection rac_sendAsynchronousRequest:request] map:mapBlock] deliverOn:[RACScheduler mainThreadScheduler]] map:parsingBlock] publish] autoconnect];
}
							   
@end
