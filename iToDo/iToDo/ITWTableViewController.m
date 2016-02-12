//
//  ITWTableViewController.m
//  iToDo
//
//  Created by Wen Tan on 2/11/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "ITWTableViewController.h"
#import "TWList.h"

@interface ITWTableViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ITWTableViewController

- (void)testExample {
	
	TWList *a = [[TWList alloc] initWithTitle:@"Buy Milk" priority:ListPriorityHigh alarmDate:[NSDate dateWithTimeIntervalSinceNow:100] notes:@"Alarm me buy milk at saturday afternoon 3 o'clock"];
	a.checked = NO;
	TWList *b = [[TWList alloc] initWithTitle:@"Buy Fruits" priority:ListPriorityNone alarmDate:[NSDate dateWithTimeIntervalSinceNow:200] notes:@"Hello fruits"];
	b.checked = YES;
	TWList *c = [[TWList alloc] initWithTitle:@"exericise" priority:ListPriorityMedium alarmDate:[NSDate dateWithTimeIntervalSinceNow:300] notes:@"Running for 30 minutes"];
	c.checked = YES;
	self.dataArray = @[a,b,c,a,b,c,a,b,c];
	
}

//TODO: Order
#pragma mark - List Order Function
- (IBAction)newestAtTop:(UIBarButtonItem *)sender {
	
}
- (IBAction)oldestAtTop:(UIBarButtonItem *)sender {
	
}
- (IBAction)mostImportantAtTop:(UIBarButtonItem *)sender {
	
}
#pragma mark - View lifecycles
- (void)viewDidLoad {
	[self testExample];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

#pragma mark - TableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell =	[tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
	}
	TWList *list = self.dataArray[indexPath.row];
	cell.textLabel.text = list.title;
	cell.detailTextLabel.text = list.notes;
	cell.accessoryType = list.isChecked ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
}
@end
