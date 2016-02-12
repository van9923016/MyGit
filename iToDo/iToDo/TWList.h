//
//  List.h
//  iToDo
//
//  Created by Wen Tan on 2/12/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
	ListPriorityNone = 0,
	ListPriorityNormal = 1,
	ListPriorityMedium = 2,
	ListPriorityHigh = 3
} ListPriority;

@interface TWList : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) ListPriority priority;
@property (nonatomic, strong) NSDate *editedDate;
@property (nonatomic, strong) NSDate *alarmDate;
@property (nonatomic, copy) NSString *notes;
@property (nonatomic, assign, getter = isChecked) BOOL checked;

- (instancetype)initWithTitle:(NSString *)title priority:(ListPriority)priority alarmDate:(NSDate *)date notes:(NSString *)notes;

@end
