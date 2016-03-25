//
//  TWBubbleTableViewController.m
//  TWBubbleTalk
//
//  Created by Wen Tan on 3/25/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "TWBubbleTableViewController.h"
#import "TWSpeechController.h"
#import "TWBubbleCell.h"

@import AVFoundation;
@interface TWBubbleTableViewController ()<AVSpeechSynthesizerDelegate>

@property (nonatomic, strong) TWSpeechController *speechController;
@property (nonatomic, strong) NSMutableArray *speechStrings;

@end

@implementation TWBubbleTableViewController


#pragma mark - View lifecycles
- (void)viewDidLoad {
    [super viewDidLoad];
	self.tableView.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 20.0f, 0.0f);
	self.speechController = [TWSpeechController speechController];
	self.speechController.synthesizer.delegate = self;
	self.speechStrings = [NSMutableArray array];
	[self.speechController beginConversation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.speechStrings.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *cellIdentifier = (indexPath.row % 2 == 0)? @"siriCell": @"jackCell";
	
    TWBubbleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
	cell.messageLabel.text = self.speechStrings[indexPath.row];

    return cell;
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
	[self.speechStrings addObject:utterance.speechString];
	[self.tableView reloadData];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.speechStrings.count - 1 inSection:0];
	[self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
	
}

@end
