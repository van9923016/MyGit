//
//  AppDelegate.h
//  CoreDataTest
//
//  Created by Wen Tan on 12/28/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ChoreMO.h"
#import "ChoreLogMO.h"
#import "PersonMO.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

//Create My Managed Object Method
- (ChoreMO *)createChoreMO;
- (ChoreLogMO *)createChoreLogMO;
- (PersonMO *)createPersonMO;

@end

