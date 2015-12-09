//
//  Person.h
//  MMVCTest
//
//  Created by Wen Tan on 12/8/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, readonly) NSString *salutation;
@property (nonatomic, readonly) NSString *firstname;
@property (nonatomic, readonly) NSString *lastname;
@property (nonatomic, readonly) NSDate   *birthDate;

- (instancetype)initWithSalutation:(NSString *)salutation firstname:(NSString *)firstname lastname:(NSString *)lastname birthDate:(NSDate *)birthDate;

@end
