//
//  ViewController.m
//  CoreDataTest
//
//  Created by Wen Tan on 12/28/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
@property (strong, nonatomic) AppDelegate *delegate;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.delegate = [[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
