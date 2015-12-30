//
//  AppDelegate.m
//  MyInsPhoto
//
//  Created by Wen Tan on 12/19/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "AppDelegate.h"
#import <NXOAuth2.h>
#import "PasswordInputWindow.h"

NSString *const clientID = @"d5f53a5eed3e48cda70e9124679bee39";
NSString *const clientSecret = @"859726ff8f80400eb1ce9b3d81c5bc3e";
NSString *const accountType = @"Instagram";


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	//singleton model for account
	[[NXOAuth2AccountStore sharedStore] setClientID:clientID
											 secret:clientSecret
								   authorizationURL:[NSURL URLWithString:@"https://api.instagram.com/oauth/authorize"]
										   tokenURL:[NSURL URLWithString:@"https://api.instagram.com/oauth/access_token"]
										redirectURL:[NSURL URLWithString:@"scheme://itaen.com"]
									 forAccountType:accountType];
	return YES;
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
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// Recieve callback to open custom URL
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
	NSLog(@"We received a callback");
	return [[NXOAuth2AccountStore sharedStore] handleRedirectURL:url];
}

@end
