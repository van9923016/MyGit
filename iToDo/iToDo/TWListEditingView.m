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

- (void)adjustUI {
	self.notesField.layer.borderWidth = 2.0f;
	self.notesField.layer.cornerRadius = 8.0f;
	self.notesField.layer.borderColor = [UIColor grayColor].CGColor;
}

- (void)changeButtonState {
	UIImage *buttonImage = [self.checked boolValue] ? [UIImage imageNamed:@"Checked Checkbox 2"] : nil ;
	[self.checkButton setImage:buttonImage forState:UIControlStateNormal];
}

- (void)showSelectedList {
	self.titleField.text = self.editingList.title;
	self.prioritySeg.selectedSegmentIndex = [self.editingList.priority integerValue];
	self.datePicker.date = self.editingList.alarmDate;
	self.notesField.text = self.editingList.notes;
	self.checked = self.editingList.isChecked;
	[self changeButtonState];
}

- (void)saveList {
	self.editingList.title = self.titleField.text;
	self.editingList.priority = [NSNumber numberWithInteger:self.prioritySeg.selectedSegmentIndex];
	self.editingList.notes = self.notesField.text;
	self.editingList.alarmDate = self.datePicker.date;
	self.editingList.isChecked = self.checked;
	self.editingList.edittingTime = [NSDate date];
	[[AppDelegate sharedInstance] saveContext];
}

- (void)deleteList {
	[[[AppDelegate sharedInstance] managedObjectContext] deleteObject:self.editingList];
	[[AppDelegate sharedInstance] saveContext];
}

- (IBAction)checkButtonPressed:(UIButton *)sender {
	self.checked = [NSNumber numberWithBool:![self.checked boolValue]];
	[self changeButtonState];
}

- (IBAction)deleteList:(UIButton *)sender {
	//delete stored data
	[self deleteList];
	self.editingList = nil;
	[self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)saveList:(UIBarButtonItem *)sender {
	[self saveList];
	[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - View Life Cycles
- (void)viewDidLoad {
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	[self adjustUI];
	
	if (self.editingList) {
		[self showSelectedList];
	} else {
		self.editingList = [[AppDelegate sharedInstance] createList];
	}
	
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	if (self.editingList)
		[self saveList];
	

}


@end
