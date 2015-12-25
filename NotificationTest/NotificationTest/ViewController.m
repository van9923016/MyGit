//
//  ViewController.m
//  NotificationTest
//
//  Created by Wen Tan on 12/24/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController


- (void)requestPermissionToNotify {
	
	//add alert action category
	UIMutableUserNotificationAction *ignoreAction = [[UIMutableUserNotificationAction alloc] init];
	ignoreAction.identifier = @"IGNORE_ACTION";
	ignoreAction.title = @"ignore";
	ignoreAction.activationMode = UIUserNotificationActivationModeBackground;
	ignoreAction.destructive = YES;
	ignoreAction.authenticationRequired = NO;
	
	UIMutableUserNotificationAction *stingAction = [[UIMutableUserNotificationAction alloc] init];
	stingAction.identifier = @"STING_ACTION";
	stingAction.title = @"😁😁😁";
	stingAction.activationMode = UIUserNotificationActivationModeForeground;
	stingAction.destructive = NO;
	stingAction.authenticationRequired = NO;
	
	UIMutableUserNotificationCategory *alertCategory = [[UIMutableUserNotificationCategory alloc] init];
	alertCategory.identifier = @"MAIN_CATEGORY";

	//first one on the right
	[alertCategory setActions:@[ignoreAction,stingAction]
				   forContext:UIUserNotificationActionContextDefault];
	
	UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeBadge;
	
	NSSet *categories = [NSSet setWithObjects:alertCategory, nil];
	UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
																			 categories:categories];
	
	[[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}

- (void)createNotification:(int)secondsInFuture {
	UILocalNotification *localNotify = [[UILocalNotification alloc]init];
	
	localNotify.fireDate = [[NSDate date] dateByAddingTimeInterval:secondsInFuture];
	localNotify.timeZone = nil;
	localNotify.alertTitle = @"Alert Title!";
	localNotify.alertBody = @"This is an alert body";
	localNotify.alertAction = @"Okay";
	localNotify.soundName = UILocalNotificationDefaultSoundName;
	localNotify.applicationIconBadgeNumber = 777;
	localNotify.category = @"MAIN_CATEGORY";
	[[UIApplication sharedApplication] scheduledLocalNotifications];
	[[UIApplication sharedApplication] scheduleLocalNotification:localNotify];
}


- (IBAction)notificationButtonPressed:(UIButton *)sender {
	[self requestPermissionToNotify];
	[self createNotification:15];
}


#pragma mark -- APP Lifecycles
- (void)viewDidLoad {
	[super viewDidLoad];
	self.button.layer.cornerRadius = 8.0;
	self.button.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
