 //
//  ViewController.m
//  CoreDataTest
//
//  Created by Wen Tan on 12/28/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "PickViewViewController.h"

@interface ViewController ()

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UITextField  *chorefield;
@property (weak, nonatomic) IBOutlet UILabel	 *choreLogLabel;
@property (strong, nonatomic) PickViewViewController *choreRollerVC;

@end

@implementation ViewController


- (IBAction)addChoreTapped:(UIButton *)sender {
	
	ChoreMO *choreMO = [self.appDelegate createChoreMO];
	choreMO.chore_name = self.chorefield.text;
	
	[self.appDelegate saveContext];
	[self updateLogList];
}

- (IBAction)deleteChoreTapped:(UIButton *)sender {
	
	NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Chore"];
	
	NSError *error = nil;
	NSArray *results = [moc executeFetchRequest:request error:&error];
	if (!results) {
		NSLog(@"Error fetching Person objects: %@\n%@", [error localizedDescription], [error userInfo]);
		abort();
	}
	
	for (ChoreMO *choreMO in results) {
		[moc deleteObject:choreMO];
	}
	[self.appDelegate saveContext];
	[self updateLogList];
	
}


- (void)updateLogList {
	NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Chore"];
	NSError *error = nil;
	NSArray *results = [moc executeFetchRequest:request error:&error];
	if (!results) {
		NSLog(@"Error fetching person objects: %@\n%@",[error localizedDescription], [error userInfo]);
		abort();
	}
	
	NSMutableString *buffer = [NSMutableString stringWithString:@""];
	for (ChoreMO *choreMO in results) {
		[buffer appendFormat:@"\n%@", choreMO.chore_name] ;
	}
	self.choreLogLabel.text = buffer;

}

- (void)updateChoreRoller {
	NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Chore"];
	NSError *error = nil;
	NSArray *results = [moc executeFetchRequest:request error:&error];
	if (!results) {
		NSLog(@"Error fetching data from Person objects: %@\n\%@", [error localizedDescription], [error userInfo]);
		abort();
	}
	NSMutableArray *choreData = [NSMutableArray arrayWithArray:results];
	[self.choreRollerVC setArray: choreData];
}




#pragma mark - App Lifecycle
- (void)viewDidLoad {
	[super viewDidLoad];
	self.appDelegate = [[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
