//
//  List+CoreDataProperties.h
//  iToDo
//
//  Created by Wen Tan on 2/14/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "List.h"

NS_ASSUME_NONNULL_BEGIN

@interface List (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *alarmDate;
@property (nullable, nonatomic, retain) NSNumber *isChecked;
@property (nullable, nonatomic, retain) NSString *notes;
@property (nullable, nonatomic, retain) NSNumber *priority;
@property (nullable, nonatomic, retain) NSString *title;

@end

NS_ASSUME_NONNULL_END
