//
//  TWNoteVC.m
//  TextKitTest
//
//  Created by Wen Tan on 1/3/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "TWNoteEditVC.h"
#import "TWNotesTableVC.h"
#import "TWNote.h"

@interface TWNoteEditVC ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *noteView;
@property (strong, nonatomic) NSString *noteString;

@end

@implementation TWNoteEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
	self.noteView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
	self.noteView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
	self.noteView.text = self.note.contents;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TextView delegate

- (void)textViewDidEndEditing:(UITextView *)textView {
	// copy the updated note text to the underlying model.
	self.note.contents = textView.text;
}

@end
