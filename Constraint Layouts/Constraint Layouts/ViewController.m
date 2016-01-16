//
//  ViewController.m
//  Constraint Layouts
//
//  Created by Wen Tan on 1/16/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

@import MapKit;
#import "ViewController.h"

static NSString *webURL = @"https://www.apple.com";

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:webURL]];
	[self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
