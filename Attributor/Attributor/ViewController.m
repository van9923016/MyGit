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
@property (weak, nonatomic) IBOutlet UIButton	*outlineBtn;

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


#pragma mark - View Geometry changed
//this will automatically handled with autolayout
//called anytime view's frame changed and its subviews wer re-layed out
//eg: rotation
//reset frames of subviews or other geometry-affectin properties

- (void)viewWillLayoutSubviews {
	
}

//autolayout occur during will and did method

 - (void)viewDidLayoutSubviews {
	
}


#pragma mark - App lifeCycle

- (void)awakeFromNib {
	//load before viewDidLoad, sent to all objects come from storyboard, before outlets are set!
	//before MVC is loaded
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nil bundle:nil];
	//blah blah setup for u view
	return self;
}




//in lifecycle on time call, most of init code should put in here,
//except geometry code, something related to bounds and frame may have not ready.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.outlineBtn.currentTitle];
	[title setAttributes:@{
						  NSStrokeWidthAttributeName : @(3),
						  NSStrokeColorAttributeName : self.outlineBtn.tintColor
						  }
				   range:NSMakeRange(0, [title length])];
	
	[self.outlineBtn setAttributedTitle:title
							   forState:UIControlStateNormal];

}
//in lifecycle every time this view appear will recall this method
//sync model data changed
//something costs a lot resources like networking should put in here and optimize it
//It's okay code about geometry in here if it is changed often
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

//put code remember what is going on in this view and cleanup some code.
//eg:remember scrollPosition
//save data to permanentStore(storedata may be put in didDissappear is also properly)
//not do anything time-cosuming otherwise will sluggish app
//kick off a thread to do what needs doing here
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
