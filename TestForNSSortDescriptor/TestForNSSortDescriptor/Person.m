//
//  Person.m
//  TestForNSSortDescriptor
//
//  Created by Wen Tan on 2/1/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "Person.h"

@implementation Person

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ %@ age %@", self.firstName, self.lastName,self.age];
}
@end
