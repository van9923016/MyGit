//
//  AppDelegate.h
//  iToDo
//
//  Created by Wen Tan on 2/11/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "List.h"
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (List *)createList;
+ (instancetype)sharedInstance;

@end

