//
//  PersonMO+CoreDataProperties.m
//  CoreDataTest
//
//  Created by Wen Tan on 12/28/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PersonMO+CoreDataProperties.h"

@implementation PersonMO (CoreDataProperties)

@dynamic name;
@dynamic chore_log;

- (NSString *)description {
	return self.name;
}

@end
