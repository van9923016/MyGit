//
//  ITWTableViewController.m
//  iToDo
//
//  Created by Wen Tan on 2/11/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "ITWTableViewController.h"

#import "TWListEditingView.h"
#import "AppDelegate.h"

@interface ITWTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataLists;

@end

@implementation ITWTableViewController

- (NSMutableArray *)dataLists {
	if (!_dataLists) {
		_dataLists = [[NSMutableArray alloc] init];
	}
	return _dataLists;
}

- (void)fetchData {
	NSError *error = nil;
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"List"];
	NSArray *fetchedData = [[[AppDelegate sharedInstance] managedObjectContext] executeFetchRequest:request error:&error];
	self.dataLists = [NSMutableArray arrayWithArray:fetchedData];
	[self.tableView reloadData];
}

- (NSString *)getDateInFormat:(NSDate *)date {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.timeStyle = kCFDateFormatterShortStyle;
	dateFormatter.dateStyle = kCFDateFormatterShortStyle;
	[dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
	return [dateFormatter stringFromDate:date];
}

- (void)deleteObjectAtIndex:(NSUInteger)row {
	NSError *error = nil;
	NSArray *dataArray = [[[AppDelegate sharedInstance] managedObjectContext] executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"List"] error:nil];
	for (NSManagedObject *a in dataArray) {
		if ([a isEqual:self.dataLists[row]]) {
			[[[AppDelegate sharedInstance] managedObjectContext] deleteObject:a];
			[[[AppDelegate sharedInstance] managedObjectContext] save:&error];
		}
	}

}

#pragma mark - List Order Function
- (IBAction)newestAtTop:(UIBarButtonItem *)sender {
	
}
- (IBAction)oldestAtTop:(UIBarButtonItem *)sender {
	
}
- (IBAction)mostImportantAtTop:(UIBarButtonItem *)sender {
	
}


#pragma mark - View lifecycles
- (void)viewDidLoad {

}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self fetchData];
}


#pragma mark - TableView delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.dataLists.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell =	[tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
	}
		List *list = self.dataLists[indexPath.row];
		cell.textLabel.text = list.title;
	    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ Notes: %@",[self getDateInFormat:list.edittingTime], list.notes];
		cell.accessoryType = [list.isChecked boolValue] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//Set sender to sender, when use prepareForSegue cast sender to indexPath then pass selected row to new ViewController
	[self performSegueWithIdentifier:@"showDetail" sender:indexPath];
}

//Preparing data for destinationViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	if ([[segue identifier] isEqualToString:@"showDetail"]) {
		TWListEditingView *editingVC = [segue destinationViewController];
		if (![sender isKindOfClass:[UIBarButtonItem class]]) {
			NSIndexPath *indexPath = sender;
			//TODO: Passing data to ViewController
			editingVC.editingList = self.dataLists[indexPath.row];
		}
	}
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		//need remove datalist data first
		[self deleteObjectAtIndex:indexPath.row];
		[self.dataLists removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:@[indexPath]
						 withRowAnimation:UITableViewRowAnimationFade]; 
	}
}


@end
