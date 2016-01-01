//
//  ViewController.m
//  InAppPurchaseTest
//
//  Created by Wen Tan on 1/1/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

@import StoreKit;
#import "ViewController.h"

@interface ViewController ()<SKProductsRequestDelegate,SKPaymentTransactionObserver>

@end

@implementation ViewController

- (void)getProductInfo {
	//get product id from itunes connect
	NSSet *set = [NSSet setWithArray:@[@"ProductId"]];
	SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
	request.delegate = self;
	[request start];
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
	//implement two method
	NSString *productIndentifier = transaction.payment.productIdentifier;
	NSString *reciept = [transaction.transactionReceipt base64Encoding];
	if ([productIndentifier length] > 0) {
		//send receipt to u own server
		NSLog(@"%@", reciept);
	}
	
	// remove the transaction from the payment queue
	[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
	
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
	if (transaction.error.code != SKErrorPaymentCancelled) {
		NSLog(@"购买失败");
	}else{
		NSLog(@"用户取消交易");
	}
	[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}
- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
	//restore purchased logic
	[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
	
}
- (void)deferTransaction:(SKPaymentTransaction *)transaction {
	
}


- (IBAction)purchaseButtonPressed:(UIButton *)sender {
	if ([SKPaymentQueue canMakePayments]) {
		[self getProductInfo];
	}else{
		NSLog(@"失败，用户禁止应用程序内购买。");
	}
}

#pragma mark -- SKProductRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
	NSArray *myProduct = response.products;
	NSLog(@"%@",response);
	if (myProduct.count == 0) {
		NSLog(@"无法获得产品信息，购买失败");
		return;
	}
	
	SKPayment *payment = [SKPayment paymentWithProduct:myProduct[0]];
	[[SKPaymentQueue defaultQueue] addPayment:payment];
	
}

#pragma mark -- SKPaymentTransactionObserver delegate
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
	for (SKPaymentTransaction *transaction in transactions) {
		switch (transaction.transactionState) {
			case SKPaymentTransactionStatePurchasing: {
				NSLog(@"商品已经加入购物列表。");
				break;
			}
			case SKPaymentTransactionStatePurchased: {
				NSLog(@"商品已经购买。");
				[self completeTransaction:transaction];
				break;
			}
			case SKPaymentTransactionStateFailed: {
				NSLog(@"购买出现错误。");
				[self failedTransaction:transaction];
				break;
			}
			case SKPaymentTransactionStateRestored: {
				NSLog(@"执行购买恢复动作。");
				[self restoreTransaction:transaction];
				break;
			}
			case SKPaymentTransactionStateDeferred: {
				NSLog(@"购买推迟。");
				break;
			}
		}
	}
}


- (void)viewDidLoad {
	[super viewDidLoad];
	//this method only load once before it is dealloc ,if it is contained by composite controllers
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	//adding listeners in viewDidLoad and removing them in viewDidUnload.
	//This is acceptable only if you have simple UIViewControllers
	//don’t work in composite controllers hierarchy (UINavigationController,UITabBarController)
	// observer payment response
	[[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	//always remove specific observer when u dont need it do not remove all observer unless sure about that
	[[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
