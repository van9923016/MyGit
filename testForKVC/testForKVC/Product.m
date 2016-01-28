//
//  Product.m
//  Test
//
//  Created by Wen Tan on 1/28/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "Product.h"

@implementation Product

- (instancetype)initWithName:(NSString *)name price:(double)price launchedDate:(NSDate *)date {
	self = [super init];
	if (self) {
		_name = name;
		_price = price;
		_launchedOn = date;
	}
	return self;
}
@end
