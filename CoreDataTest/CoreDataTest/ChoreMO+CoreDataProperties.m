//
//  ChoreMO+CoreDataProperties.m
//  CoreDataTest
//
//  Created by Wen Tan on 12/28/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ChoreMO+CoreDataProperties.h"

@implementation ChoreMO (CoreDataProperties)

@dynamic chore_name;
@dynamic chore_log;

- (NSString *)description {
	return self.chore_name;
}
@end
