//
//  List.m
//  iToDo
//
//  Created by Wen Tan on 2/12/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "TWList.h"

@implementation TWList

- (instancetype)initWithTitle:(NSString *)title priority:(ListPriority)priority alarmDate:(NSDate *)date notes:(NSString *)notes {
	self = [super init];
	if (self) {
		_title = title;
		_priority = priority;
		_alarmDate = date;
		_notes = notes;
	}
	return self;
}

@end
