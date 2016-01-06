//
//  ViewController.m
//  Attributor
//
//  Created by Wen Tan on 1/5/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;


@end

@implementation ViewController





- (IBAction)changeBodySelectionColorToBackroundOfButton:(UIButton *)sender {
	//add foreground color to attributestring in selected range
	[self.textView.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:self.textView.selectedRange];
}

- (IBAction)outlinePressed:(UIButton *)sender {
	//1.set stroke width
	//2.set stroke color
	[self.textView.textStorage addAttributes:@{
											   NSStrokeWidthAttributeName : @(-3),
											   NSStrokeColorAttributeName : [UIColor blackColor]
											  }
									   range:self.textView.selectedRange];
}

- (IBAction)unOutlinePressed:(UIButton *)sender {
	[self.textView.textStorage removeAttribute:NSStrokeWidthAttributeName
										 range:self.textView.selectedRange];
}

#pragma mark - App lifeCycle
- (void)viewDidLoad {
	[super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
