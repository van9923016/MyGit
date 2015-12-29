 //
//  ViewController.m
//  CoreDataTest
//
//  Created by Wen Tan on 12/28/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "PickViewController.h"

@interface ViewController ()

@property (strong, nonatomic)	AppDelegate			*appDelegate;
@property (weak, nonatomic) IBOutlet UITextField	*chorefield;
@property (weak, nonatomic) IBOutlet UIButton		*choreBtn;
@property (weak, nonatomic) IBOutlet UIPickerView	*choreRoller;
@property (weak, nonatomic) IBOutlet UITextField	*personfield;
@property (weak, nonatomic) IBOutlet UIButton		*personBtn;
@property (weak, nonatomic) IBOutlet UIPickerView	*personRoller;
@property (weak, nonatomic) IBOutlet UIButton		*addChoreBtn;
@property (weak, nonatomic) IBOutlet UIButton		*deleteChoreBtn;
@property (weak, nonatomic) IBOutlet UITextView		*choreLogView;
@property (weak, nonatomic) IBOutlet UIDatePicker	* datePicker;
@property (weak, nonatomic) IBOutlet UILabel		*choreListLabel;
@property (strong, nonatomic) PickViewController	*choreRollerHelper;
@property (strong, nonatomic) PickViewController	*personRollerHelper;
@end

@implementation ViewController

//layer corneradius helper
- (void)roundViewWithLayer:(CALayer *)layer {
	layer.cornerRadius = 10.0;
	layer.masksToBounds = YES;
}
//alert helper method
- (void)alertHelplerWithTitle:(NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle {
	
	UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title
																	 message:message
															  preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle
													 style:UIAlertActionStyleCancel
												   handler:^(UIAlertAction * _Nonnull action) {return ;}];
	[alertVC addAction:action];
	[self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - Chore field implementation
- (IBAction)addChoreTapped:(UIButton *)sender {
	ChoreMO *choreMO = [self.appDelegate createChoreMO];
	choreMO.chore_name = self.chorefield.text;
	[self.appDelegate saveContext];
	[self updateChoreRoller];
	[self updateLogList];
}

- (void)updateChoreRoller {
	NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Chore"];
	NSError *error = nil;
	NSArray *results = [moc executeFetchRequest:request error:&error];
	if (!results) {
		NSLog(@"Error fetching data from Chore objects: %@\n\%@", [error localizedDescription], [error userInfo]);
		abort();
	}
	NSMutableArray *choreData = [NSMutableArray arrayWithArray:results];
	[self.choreRollerHelper setArray: choreData];
	//after fetch data and give it to choreRoller, refresh it immediatelly
	[self.choreRoller reloadAllComponents];
}

#pragma mark - Person field implementation

- (IBAction)addPersonTapped:(UIButton *)sender {
	PersonMO *personMO = [self.appDelegate createPersonMO];
	personMO.name = self.personfield.text;
	[self.appDelegate saveContext];
	[self updatePersonRoller];
	[self updateLogList];
}

- (void)updatePersonRoller {
	NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
	NSError *error = nil;
	NSArray *results = [moc executeFetchRequest:request error:&error];
	if (!results) {
		NSLog(@"Error fetching data from Person objects: %@\n\%@",[error localizedDescription],[error userInfo]);
		abort();
	}
	NSMutableArray *personData = [NSMutableArray arrayWithArray:results];
	[self.personRollerHelper setArray:personData];
	[self.personRoller reloadAllComponents];
}

#pragma mark - Update Chore list

- (IBAction)addNewChoreListTapped:(UIButton *)sender {
	
	NSUInteger personIndex = [self.personRoller selectedRowInComponent:0];
	NSUInteger choreIndex = [self.choreRoller selectedRowInComponent:0];
	
	NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
	NSError *error = nil;
	
	//fetch person data
	NSFetchRequest *requestPerson = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
	NSArray *personResults = [moc executeFetchRequest:requestPerson error:&error];
	if (!personResults) {
		NSLog(@"Error fetching person objects: %@\n%@",[error localizedDescription], [error userInfo]);
		abort();
	}
	
	//fetch chore data
	NSFetchRequest *requestChore = [NSFetchRequest fetchRequestWithEntityName:@"Chore"];
	NSArray *choreResults = [moc executeFetchRequest:requestChore error:&error];
	if (!choreResults) {
		NSLog(@"Error fetching chore objects: %@\n%@",[error localizedDescription], [error userInfo]);
		abort();
	}
	
	if (personIndex >= personResults.count || choreIndex >= choreResults.count ) {
		//alert and then return nothing
		[self alertHelplerWithTitle:@"No data found!"
							message:@"Add Chore and Person data first."
						actionTitle:@"Okay"];
	}else{
		PersonMO *personMO = personResults[personIndex];
		ChoreMO *choreMO = choreResults[choreIndex];
		ChoreLogMO *logMO = [self.appDelegate createChoreLogMO];
		logMO.when = self.datePicker.date;
		logMO.person_who_did_it = personMO;
		logMO.chore_done = choreMO;
		[self.appDelegate saveContext];
		[self updateLogList];
	}
}

- (IBAction)deleteOldestChoreListTapped:(UIButton *)sender {
	
	NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ChoreLog"];
	
	NSError *error = nil;
	NSArray *results = [moc executeFetchRequest:request error:&error];
	if (!results) {
		NSLog(@"Error fetching ChoreLog objects: %@\n%@", [error localizedDescription], [error userInfo]);
		abort();
	}
	
	if (results.count == 0)	{
		[self alertHelplerWithTitle:@"Empty List!"
							message:@"Please add data to list first."
						actionTitle:@"Okay"];
	}else{
		[moc deleteObject:results[results.count-1]];
		[self.appDelegate saveContext];
		[self updateLogList];
	}
}

- (void)updateLogList {
	
	NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
	NSError *error = nil;
	
	NSMutableString *buffer = [NSMutableString stringWithString:@""];
	
	//fetch Person data
	NSFetchRequest *requestPerson = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
	NSArray *personResults = [moc executeFetchRequest:requestPerson error:&error];
	if (!personResults) {
		NSLog(@"Error fetching person objects: %@\n%@",[error localizedDescription], [error userInfo]);
		abort();
	}
	
	//fetch Chore data
	NSFetchRequest *requestChore = [NSFetchRequest fetchRequestWithEntityName:@"Chore"];
	NSArray *choreResults = [moc executeFetchRequest:requestChore error:&error];
	if (!choreResults) {
		NSLog(@"Error fetching chore objects: %@\n%@",[error localizedDescription], [error userInfo]);
		abort();
	}
	
	//fetch ChoreList data
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ChoreLog"];
	NSArray *choreLists = [moc executeFetchRequest:request error:&error];
	if (!choreLists) {
		NSLog(@"Error fetching chore lists objects: %@\n%@",[error localizedDescription], [error userInfo]);
		abort();
	}
	NSString *dateString;
	for (ChoreLogMO *choreLogMO in choreLists) {
		dateString = [NSDateFormatter localizedStringFromDate:choreLogMO.when
															  dateStyle:NSDateFormatterShortStyle
															  timeStyle:NSDateFormatterFullStyle];
		[buffer appendFormat:@"(%@) (%@) on (%@)\n",choreLogMO.person_who_did_it, choreLogMO.chore_done, dateString];
	}
	self.choreLogView.text = buffer;
	self.choreListLabel.text = [NSString stringWithFormat:@"There were %ld person %ld chores %ld lists stored.",(unsigned long)personResults.count,(unsigned long)choreResults.count,(unsigned long)choreLists.count];

}

#pragma mark - App Lifecycle
- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.appDelegate = [[UIApplication sharedApplication] delegate];
	
	self.choreRollerHelper = [[PickViewController alloc] init];
	self.choreRoller.delegate = self.choreRollerHelper;
	self.choreRoller.dataSource = self.choreRollerHelper;
	[self updateChoreRoller];
	
	self.personRollerHelper = [[PickViewController alloc] init];
	self.personRoller.delegate = self.personRollerHelper;
	self.personRoller.dataSource = self.personRollerHelper;
	[self updatePersonRoller];
	
	[self updateLogList];
}
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.view.backgroundColor = [UIColor grayColor];
	self.choreLogView.backgroundColor = [UIColor grayColor];
	[self roundViewWithLayer:self.chorefield.layer];
	[self roundViewWithLayer:self.personfield.layer];
	[self roundViewWithLayer:self.addChoreBtn.layer];
	[self roundViewWithLayer:self.deleteChoreBtn.layer];
	[self roundViewWithLayer:self.choreBtn.layer];
	[self roundViewWithLayer:self.personBtn.layer];
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
