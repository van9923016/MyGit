//
//  ViewController.m
//  CardGame
//
//  Created by Wen Tan on 1/7/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *cardBtn;
@property (weak, nonatomic) IBOutlet UILabel  *countLabel;
@property (assign, nonatomic) int filpCount;
@end

@implementation ViewController





- (IBAction)cardButtonPressed:(UIButton *)sender {
	if ([sender.currentTitle length]) {
		[sender setBackgroundImage:[UIImage imageNamed:@"cardBack"]
						  forState:UIControlStateNormal];
		[sender setTitle:@""
				forState:UIControlStateNormal];
	}else{
		[sender setBackgroundImage:[UIImage imageNamed:@"cardFront"]
						  forState:UIControlStateNormal];
		[sender setTitle:@"A♣︎"
				forState:UIControlStateNormal];
	}
	
	self.filpCount++;
	self.countLabel.text = [NSString stringWithFormat:@"Flip count: %d", self.filpCount];
	
}

#pragma mark - view lifecycle
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
