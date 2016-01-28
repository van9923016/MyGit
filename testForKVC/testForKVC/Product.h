//
//  Product.h
//  Test
//
//  Created by Wen Tan on 1/28/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) double price;
@property (nonatomic, strong) NSDate *launchedOn;

- (instancetype)initWithName:(NSString *)name price:(double)price launchedDate:(NSDate *)date;

@end
