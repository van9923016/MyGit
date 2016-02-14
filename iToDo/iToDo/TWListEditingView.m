//
//  TWListEditingView.m
//  iToDo
//
//  Created by Wen Tan on 2/12/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "TWListEditingView.h"
#import "AppDelegate.h"

@interface TWListEditingView ()

@property (nonatomic, weak) IBOutlet UITextField *titleField;
@property (nonatomic, weak) IBOutlet UISegmentedControl *prioritySeg;
@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, weak) IBOutlet UITextView *notesField;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (nonatomic, strong, getter=isChecked) NSNumber *checked;


@end
@implementation TWListEditingView

- (void)checkButtonState {
	UIImage *buttonImage = [self.checked boolValue] ? [UIImage imageNamed:@"Checked Checkbox 2"] : nil ;
	[self.checkButton setImage:buttonImage forState:UIControlStateNormal];
}
- (void)createNewList {
	List *list = [[AppDelegate sharedInstance] createList];
	list.title = self.titleField.text;
	list.priority = [NSNumber numberWithInteger:self.prioritySeg.selectedSegmentIndex];
	list.notes = self.notesField.text;
	list.alarmDate = self.datePicker.date;
	list.isChecked = self.checked;
	list.edittingTime = [NSDate date];
	[[AppDelegate sharedInstance] saveContext];
}

- (void)deleteObject {
	NSError *error = nil;
	NSArray *dataArray = [[[AppDelegate sharedInstance] managedObjectContext] executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"List"] error:nil];
	for (NSManagedObject *a in dataArray) {
		if ([a isEqual:self.editingList]) {
			[[[AppDelegate sharedInstance] managedObjectContext] deleteObject:a];
			[[[AppDelegate sharedInstance] managedObjectContext] save:&error];
		}
	}
	self.editingList = nil;
}

- (IBAction)deleteList:(UIButton *)sender {
	//delete stored data
	[self deleteObject];
	[self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)saveList:(UIBarButtonItem *)sender {
	
	if (self.editingList) {
		[self deleteObject];
	}
	[self createNewList];

	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)checkButtonPressed:(UIButton *)sender {
	self.checked = [NSNumber numberWithBool:![self.checked boolValue]];
	[self checkButtonState];
}
#pragma mark - View Life Cycles
- (void)viewDidLoad {
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	
	if (self.editingList) {
		self.titleField.text = self.editingList.title;
		self.prioritySeg.selectedSegmentIndex = [self.editingList.priority integerValue];
		self.datePicker.date = self.editingList.alarmDate;
		self.notesField.text = self.editingList.notes;
		self.checked = self.editingList.isChecked;
		[self checkButtonState]; 
	}

}

@end
