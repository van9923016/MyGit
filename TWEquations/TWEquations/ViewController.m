//
//  ViewController.m
//  TWEquations
//
//  Created by Wen Tan on 4/1/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//
//***************************特征根方程样本********************************/
//1.特征根方程：r^2-2r-3 = 0， 通解为：C1＊e^(-t)+C2＊e^3t					/
//2.特征根方程：r^2-2r+5 = 0,  通解为：	C1+C2*sin⁡((2t)e^t)+C3*cos((2t)e^t)	/
//3.特征根方程: r^2-4r+4 = 0,  通解为: C1*e^(2t)							/
//***************************特征根方程样本********************************/

#import "ViewController.h"

@interface ViewController ()

//代表特征根方程2次项系数
@property (nonatomic, assign) double a;
//特征跟方程一次项系数
@property (nonatomic, assign) double b;
//特征根方程常数项系数
@property (nonatomic, assign) double c;
//特征根方程实数根
@property (nonatomic, assign) double t1;
@property (nonatomic, assign) double t2;
//特征根方程虚数根
@property (nonatomic, assign) double realPart;
@property (nonatomic, assign) double imaginePart;
//录入用户输入的系数
@property (nonatomic, weak) IBOutlet UILabel     *equationLabel;
@property (nonatomic, weak) IBOutlet UITextField *aTextField;
@property (nonatomic, weak) IBOutlet UITextField *bTextField;
@property (nonatomic, weak) IBOutlet UITextField *cTextField;
@property (nonatomic, weak) IBOutlet UIButton    *solveButton;


@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.equationLabel.hidden = YES;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

//求解一元二次方程的根，分相同根，不同实数根，不同虚数根三种情况讨论
- (void)solveEquations {
	
	double delta;
	if (fabs(self.a)<=1e-6) {
		[self errorAlert];
		return;
	}
	//特征跟方程的判别式
	delta = self.b * self.b - 4 * self.a * self.c;
	if (fabs(delta)<=1e-6) {
		//得到两相同实数根
		self.t1 = self.t2 = -self.b/(2*self.a);
		NSLog(@"\n有两个相等实数根:\n");
		NSLog(@"\nx1 = x2 = %8.4f\n",-self.b/(2*self.a));
		NSString *answer = [NSString stringWithFormat:@"C1*e^(%ft)",self.t1];
		NSLog(@"方程通解为: %@",answer);
		self.equationLabel.text = [NSString stringWithFormat:@"方程通解为:\n %@",answer];
		
	}else if (delta>1e-6) {
		//得到两个不同实数根
		self.t1 = (-self.b + sqrt(delta))/(2*self.a);
		self.t2 = (-self.b - sqrt(delta))/(2*self.a);
		NSLog(@"\n有两个不同实数根:\n");
		NSLog(@"\nx1 = %8.4f\nx2 = %8.4f\n",self.t1,self.t2);
		NSString *answer = [NSString stringWithFormat:@"C1*e^(%ft)+C2*e^(%ft)",self.t1,self.t2];
		NSLog(@"方程通解为: %@",answer);
		self.equationLabel.text = [NSString stringWithFormat:@"方程通解为:\n %@",answer];
	}else{
		//得到虚数根
		self.realPart = -self.b/(2*self.a);
		self.imaginePart = sqrt(-delta)/(2*self.a);
		NSLog(@"\n有两个复根：\n");
		NSLog(@"\nx1 = %8.4f + %8.4f\n",self.realPart,self.imaginePart);
		NSString *answer = [NSString stringWithFormat:@"(e^%fx)*(C1*Cos(%ft)+C2*Cos(%ft))",self.realPart,self.imaginePart,self.imaginePart];
		NSLog(@"方程通解为: %@",answer);
		self.equationLabel.text = [NSString stringWithFormat:@"方程通解为:\n %@",answer];
	
	}
	//显示结果标签
	self.equationLabel.hidden = NO;
}

//执行求解摁钮动作
- (IBAction)solveEquationPressed:(UIButton *)sender {
	[self enlargeView:self.solveButton completion:^(BOOL finished) {
		self.a = [self.aTextField.text doubleValue];
		self.b = [self.bTextField.text doubleValue];
		self.c = [self.cTextField.text doubleValue];
		[self solveEquations];
		[self enlargeView:self.equationLabel completion:nil];
	}];

}

//录入数据有误，弹窗提示
- (void)errorAlert {
	//提示录入数据有误
	UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提供系数有误" message:@"该方程不是标准特征根方程" preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
		[self resetAll];
	}];
	[alertVC addAction:doneAction];
	[self presentViewController:alertVC animated:YES completion:nil];
}

//动画放大显示通解结果
- (void)enlargeView:(UIView *)view completion:(void (^ __nullable)(BOOL finished))completion {
	
	view.transform = CGAffineTransformMakeScale(0.1, 0.1);
	[UIView animateKeyframesWithDuration:0.6 delay:0.0 options:0 animations:^{
		
		[UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
			view.transform = CGAffineTransformMakeScale(1.3, 1.3);
		}];
		[UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
			view.transform = CGAffineTransformIdentity;
		}];
		
	} completion:completion];
}

//执行重置摁钮动作
- (IBAction)resetValue:(UIButton *)sender {
	[self resetAll];
}
//重置当前显示所有结果
- (void)resetAll {
	self.aTextField.text = nil;
	self.bTextField.text = nil;
	self.cTextField.text = nil;
	self.equationLabel.text = nil;
	self.equationLabel.hidden = YES;
}

@end
