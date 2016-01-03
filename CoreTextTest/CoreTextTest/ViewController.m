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
	
	//1.import resources text file into project
	NSString *path = [[NSBundle mainBundle] pathForResource:@"zombies" ofType:@"txt"];
	NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
	
	//2.using parser help class parsing txt file into attributestring and image data(filename,width,height,location)
	MarkupParser *parser = [[MarkupParser alloc] init];
	NSAttributedString *attString = [parser attrStringFromMarkup:text];
	
	//3.passing parsing data to CoreTextView Class using CoreText engine forming proper frame and display data.
	//[(CoreTextView *)self.view setAttString:attString];
	[(CoreTextView *)self.view setAttString:attString withImages:parser.images];
	[(CoreTextView *)self.view buildFrames];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
