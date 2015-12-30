//
//  PasswordInputWindow.m
//  MyInsPhoto
//
//  Created by Wen Tan on 12/30/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "PasswordInputWindow.h"

@interface PasswordInputWindow()

@property (strong, nonatomic) UITextField *textfield;
@property (strong, nonatomic) UILabel *label;
@end

@implementation PasswordInputWindow

+ (PasswordInputWindow *)sharedInstance {
	//Singleton init
	static id sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	});
	return sharedInstance;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 200, 20)];
		label.text = @"请输入密码";
		[self addSubview:label];
		
		UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, 200, 20)];
		textfield.backgroundColor = [UIColor whiteColor];
		textfield.secureTextEntry = YES;
		[self addSubview:textfield];
		
		UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 110, 200, 44)];
		button.backgroundColor = [UIColor blueColor];
		button.titleLabel.textColor = [UIColor blackColor];
		[button setTitle:@"确定"
						forState:UIControlStateNormal];
		[button addTarget:self
							 action:@selector(unlockButtonPressed:)
		 forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:button];
		
		self.backgroundColor = [UIColor yellowColor];
		self.textfield = textfield;
		self.label = label;
	}
	return self;
}

- (void)show {
	[self makeKeyWindow];
	self.hidden = NO;
}

- (void)unlockButtonPressed:(UIButton *)sender {
	if ([self.textfield.text isEqualToString:@"abcd"]) {
		[self.textfield resignFirstResponder];
		[self resignKeyWindow];
		self.hidden = YES;
		self.textfield.text = nil;
	}else{
		self.label.text = @"重新输入";
		self.label.textColor = [UIColor redColor];
		[self showErrorAlert];
	}
}

- (void)showErrorAlert {
	UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil
																																	 message:@"密码错误，重新输入！"
																														preferredStyle: UIAlertControllerStyleAlert];
	UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认"
																									 style:UIAlertActionStyleCancel
																								 handler:nil];
	[alertVC addAction:action];
	UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
	[rootVC presentViewController:alertVC
											 animated:YES
										 completion:nil];
}
@end
