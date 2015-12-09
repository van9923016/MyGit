//
//  Person.m
//  MMVCTest
//
//  Created by Wen Tan on 12/8/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "Person.h"

@interface Person ()

@property (nonatomic) NSString *salutation;
@property (nonatomic) NSString *firstname;
@property (nonatomic) NSString *lastname;
@property (nonatomic) NSDate   *birthDate;

@end

@implementation Person

- (instancetype)initWithSalutation:(NSString *)salutation firstname:(NSString *)firstname lastname:(NSString *)lastname birthDate:(NSDate *)birthDate {
	
	self = [super init];
	if (!self) {
		return nil;
	}
	_salutation = salutation;
	_firstname = firstname;
	_lastname = lastname;
	_birthDate = birthDate;
	return self;
}

@end
