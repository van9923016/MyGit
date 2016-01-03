//
//  ViewController.m
//  CoreTextTest
//
//  Created by Wen Tan on 1/2/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//


#import "ViewController.h"
#import "CoreTextView.h"
#import "MarkupParser.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	NSString *path = [[NSBundle mainBundle] pathForResource:@"zombies" ofType:@"txt"];
	NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
	MarkupParser *parser = [[MarkupParser alloc] init];
	NSAttributedString *attString = [parser attrStringFromMarkup:text];
	//[(CoreTextView *)self.view setAttString:attString];
	[(CoreTextView *)self.view setAttString:attString withImages:parser.images];
	[(CoreTextView *)self.view buildFrames];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
