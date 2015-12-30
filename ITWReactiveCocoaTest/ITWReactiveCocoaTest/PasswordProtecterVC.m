//
//  PasswordProtecterVC.m
//  MyInsPhoto
//
//  Created by Wen Tan on 12/30/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "PasswordProtecterVC.h"

@interface PasswordProtecterVC ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;

@end

@implementation PasswordProtecterVC

- (IBAction)enterBtnPressed:(UIButton *)sender {
	
	if ([self.password.text isEqualToString:@"abcd"]) {
		self.label.text = @"Login success!";
		self.label.textColor = [UIColor greenColor];
	}else{
		self.label.text = @"Wrong password, try again!";
		self.label.textColor = [UIColor redColor];
	}
}



#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
