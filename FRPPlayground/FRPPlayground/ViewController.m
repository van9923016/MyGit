//
//  ViewController.m
//  FRPPlayground
//
//  Created by Wen Tan on 11/30/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIButton *createBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//	observe textfield and react to filed change
	[self.emailField.rac_textSignal subscribeNext:^(id x) {
		NSLog(@"new value is %@",x);
	}];
	
//	toggle button state and react to button pressed
//	reuse signal
	RACSignal *validEmailSignal = [self.emailField.rac_textSignal map:^id(id value) {
		return @([value rangeOfString:@"@"].location != NSNotFound);
	}];
	
//	RAC(self.createBtn, enabled) = validEmailSignal;
	
//	RAC(self.createBtn, enabled) = [self.emailField.rac_textSignal map:^id(id value) {
//		return @([value rangeOfString:@"@"].location != NSNotFound);
//	}];
	
	RAC(self.emailField, textColor) = [validEmailSignal map:^id(id value) {
		return ([value boolValue] ? [UIColor greenColor]: [UIColor redColor]);
	}];
	
//	Commands, combine button state and its action
	self.createBtn.rac_command = [[RACCommand alloc] initWithEnabled:validEmailSignal
														 signalBlock:^RACSignal *(id input) {
		NSLog(@"Create account button has pressed!");
		return [RACSignal empty];
															 
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
