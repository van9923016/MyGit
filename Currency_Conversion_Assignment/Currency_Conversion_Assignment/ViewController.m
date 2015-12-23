//
//  ViewController.m
//  Currency_Conversion_Assignment
//
//  Created by Wen Tan on 12/22/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "ViewController.h"
#import <CRCurrencyRequest.h>
#import <CRCurrencyResults.h>

@interface ViewController ()<CRCurrencyRequestDelegate>

@property (strong, nonatomic) CRCurrencyRequest *request;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UILabel *BGNLabel;
@property (weak, nonatomic) IBOutlet UILabel *EURLabel;
@property (weak, nonatomic) IBOutlet UILabel *JPYLabel;
@property (weak, nonatomic) IBOutlet UIButton *convertBtn;


@end

@implementation ViewController




- (IBAction)convert:(UIButton *)sender {
	self.convertBtn.enabled = NO;
	self.request = [[CRCurrencyRequest alloc]init];
	self.request.delegate = self;
	
	
	//Notice!!! the result this request got is slightlly different to current currency. so i will just ignore it.
	[self.request start];


}

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


- (void)currencyRequest:(CRCurrencyRequest *)req retrievedCurrencies:(CRCurrencyResults *)currencies {
	self.convertBtn.enabled = YES;
	double inputValue = [self.inputField.text doubleValue];
	double euroValue = inputValue * currencies.EUR;
	double bgnValue = inputValue *currencies.BGN;
	double jpyValue = inputValue *currencies.JPY;
	self.EURLabel.text = [NSString stringWithFormat:@"%.2f", euroValue];
	self.BGNLabel.text = [NSString stringWithFormat:@"%.2f", bgnValue];
	self.JPYLabel.text = [NSString stringWithFormat:@"%.2f", jpyValue];
	
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[self.view endEditing:YES];
}
@end
