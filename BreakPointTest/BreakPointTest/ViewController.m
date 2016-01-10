//
//  ViewController.m
//  BreakPointTest
//
//  Created by Wen Tan on 1/10/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//	project original from http://jeffreysambells.com blog

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (IBAction)simpleBreakPointPressed:(UIButton *)sender {
	//simple break point, or using (cmd + \) add
	NSLog(@"Demo: (%s)" , __PRETTY_FUNCTION__ );
	NSLog(@"<- This simple breakpoint will stop until you continue execution or step over it");
	NSLog(@"<- This simple breakpoint will stop until you continue execution or step over it");
	
}

- (IBAction)conditionalBreakPointPressed:(UIButton *)sender {
	NSLog(@"Demo: Simple Breakpoint (%s)" , __PRETTY_FUNCTION__ );
	//conditional break point can set to anything that return an BOOL to argue
	BOOL stop = YES;
	NSLog(@"Stop was set to: %@", stop ? @"YES" : @"NO");
	// <- This conditional breakpoint will only work if stop==YES (change it to see)
}

- (IBAction)ignoredBreakPointPressed:(UIButton *)sender {
	NSLog(@"Demo: (%s)" , __PRETTY_FUNCTION__ );
	int i = 0;
	while (++i <= 6) {
		NSLog(@"i = %d", i);
		// <- This breakpoint is ignored 3 times before stopping
		//after that each time u pressed it will trigger breakpoint
	}
}

- (IBAction)logMessageAndContinueBreakPointPressed:(UIButton *)sender {
	NSLog(@"Demo: (%s)" , __PRETTY_FUNCTION__ );
	// A new message will be in you debug log
}

- (IBAction)logMessageOrValuesAndContinueBreakPointPressed:(UIButton *)sender {
	NSLog(@"Demo: (%s)" , __PRETTY_FUNCTION__ );
	// A new message will be in you debug log
}

- (IBAction)mutipleActionBreakPointPressed:(UIButton *)sender {
	NSLog(@"Demo: (%s)" , __PRETTY_FUNCTION__ );
	// A new message will be in you debug log
}

- (IBAction)symbolicBreakPointPressed:(UIButton *)sender {
	
	// The symbolic breakpoint will stop at the beginning of this method
	// There's also a symbolic breakpoint for
	NSLog(@"Demo: (%s)" , __PRETTY_FUNCTION__ );
	
}

- (IBAction)exceptionBreakPointPressed:(UIButton *)sender {
	@try {
		// The Breakpoint Navigation has an Exception Breakpoint which will stop here.
		@throw [NSException exceptionWithName:@"Example" reason:@"Testing Breakpoints" userInfo:nil];
	} @catch (NSException *e) {
		// Nothing since this is an example.
	}
}

#pragma mark -View life cycle
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
