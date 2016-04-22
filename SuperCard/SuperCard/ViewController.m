//
//  ViewController.m
//  SuperCard
//
//  Created by Wen Tan on 1/10/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet PlayingCardView *playingCardView;

@end

@implementation ViewController

#pragma mark - view life cycle
- (void)viewDidLoad {
	[super viewDidLoad];
	self.playingCardView.suit = @"❤️";
	self.playingCardView.rank = 13;
	NSLog(@"%d",[NSThread isMainThread]);
	__block NSMutableString *testString = [NSMutableString stringWithFormat:@"sdfvjdfvjhsdbfv "];
	//1
	[UIView animateWithDuration:3.0 animations:^{
		self.playingCardView.center = self.view.center;
		//2
		self.playingCardView.alpha = .7;
		NSLog(@"%d",[NSThread isMultiThreaded ]);
		[testString appendString:@"123"];
		
	} completion:^(BOOL finished) {
		//6
		if (finished) NSLog(@"Completed!");
//		NSLog(@"Hello %@",testString);
	}];
	
	
	[UIView animateWithDuration:3.0 animations:^{
		//3
		self.playingCardView.alpha = .3;
		[testString appendString:@"343434"];
	} completion:^(BOOL finished) {
		//5
		
		if (finished) [self.playingCardView removeFromSuperview];
	}];
	
	//4
	NSLog(@"Hello %@",testString);
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
