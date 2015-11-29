//
//  ITWViewController.m
//  ITWReactiveCocoaTest
//
//  Created by Wen Tan on 11/28/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "ITWViewController.h"
#import "ITWSignUpVC.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ITWViewController ()

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (copy, nonatomic) NSString *username;



@end

@implementation ITWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.username = @"itaen";
//	[RACAble(self.username) subscribeNext:^(NSString *newName) {
//		NSLog(@"%@",newName);
//	}];
	
//	observe textField dynamically
	[self.usernameTextField.rac_textSignal subscribeNext:^(NSString *text) {
		NSLog(@"Incoming text signal: %@", text);
	}];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)updateUsername:(UIButton *)sender {
	self.username = self.usernameTextField.text;
	self.usernameLabel.text = self.username;
	NSLog(@"Username is %@",self.username);
}

- (IBAction)signUp:(UIButton *)sender {
	ITWSignUpVC *signUpVC = [[ITWSignUpVC alloc]initWithNibName:@"ITWSignUpVC" bundle:nil];
	[self presentViewController:signUpVC animated:YES completion:nil];
}


@end
