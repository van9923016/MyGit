//
//  TWListEditingView.m
//  iToDo
//
//  Created by Wen Tan on 2/12/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "TWListEditingView.h"

@interface TWListEditingView ()

@property (nonatomic, weak) IBOutlet UITextField *titleField;
@property (nonatomic, weak) IBOutlet UISegmentedControl *prioritySeg;
@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, weak) IBOutlet UITextView *notesField;


@end
@implementation TWListEditingView

- (IBAction)deleteList:(UIButton *)sender {
	//delete stored data
}
- (IBAction)saveList:(UIBarButtonItem *)sender {
	//TODO: Persistent store data
}

#pragma mark - View Life Cycles
- (void)viewDidLoad {
	if (self.editingList) {
		
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	if (self.editingList) {
		self.titleField.text = self.editingList.title;
		self.prioritySeg.selectedSegmentIndex = self.editingList.priority;
		self.datePicker.date = self.editingList.alarmDate;
		self.notesField.text = self.editingList.notes;
	}

}

@end
