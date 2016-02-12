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
	
}

- (void)viewWillAppear:(BOOL)animated {
	self.titleField.text = @"Hello";
	self.prioritySeg.selectedSegmentIndex = 2;
	self.datePicker.date = [NSDate dateWithTimeIntervalSinceNow:2000];
	self.notesField.text = @"跟酸菜一起学习Objective-C和Cocoa鲜为人知的技巧(该系列文章是题主翻译以及总结自Matt Tompson著作）NSHipster Obscure Topics in Cocoa & Objective C)";
}

@end
