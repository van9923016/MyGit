//
//  AppDelegate.m
//  ITWReactiveCocoaTest
//
//  Created by Wen Tan on 11/28/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "AppDelegate.h"
#import "ITWViewController.h"
#import "PasswordProtecterVC.h"
#import "PasswordInputWindow.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	ITWViewController *mainVC = [[ITWViewController alloc]initWithNibName:@"ITWViewController" bundle:nil];
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
	UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:mainVC];
	self.window.rootViewController = navigationVC;
	[self.window makeKeyAndVisible];
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
//	PasswordProtecterVC *passwordVC = [[PasswordProtecterVC alloc] initWithNibName:@"PasswordProtecterVC" bundle:nil];
//	[(UINavigationController *)self.window.rootViewController setNavigationBarHidden:YES animated:NO];
//	[(UINavigationController *)self.window.rootViewController pushViewController:passwordVC animated:NO];
//	self.window.rootViewController = passwordVC;
//	[self.window makeKeyAndVisible];
	[[PasswordInputWindow sharedInstance] show];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
