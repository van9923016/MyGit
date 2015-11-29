//
//  AppDelegate.m
//  FRPPlayground
//
//  Created by Wen Tan on 11/29/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "AppDelegate.h"
#import <RXCollections/RXCollection.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[self mapArray];
	[self filterArray];
	return YES;
}

- (void)mapArray {
	NSArray *array = @[@(1), @(2), @(3)];
	
	//	traditional way map
	NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:array.count];
	for (NSNumber *number in array) {
		[mutableArray addObject:@(pow([number integerValue], 2))];
	}
	NSArray *mappedArr = [NSArray arrayWithArray:mutableArray];
	
	//	functional programming : map
	NSArray *mappedArray = [array rx_mapWithBlock:^id(id each) {
		return @(pow([each integerValue], 2));
	}];
	
	NSLog(@"%@",array);
	NSLog(@"%@", mappedArr);
	NSLog(@"%@",mappedArray);
}

- (void)filterArray {
	NSArray *array = @[@(1), @(2), @(3)];
	
//	traditional way filter array
	NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:array.count];
	
	for (NSNumber *number in array) {
		if ([number integerValue] % 2 == 0) {
			[mutableArray addObject:number];
		}
	}
	NSArray *filteredArr = [NSArray arrayWithArray:mutableArray];
	
//	functional filter
	NSArray *filteredArray = [array rx_filterWithBlock:^BOOL(id each) {
		return ([each integerValue] % 2 == 0);
	}];
	
	NSLog(@"%@",array);
	NSLog(@"%@", filteredArr);
	NSLog(@"%@",filteredArray);
}




- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
