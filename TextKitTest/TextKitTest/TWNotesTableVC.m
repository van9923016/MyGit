//
//  TWNotesTableVC.m
//  TextKitTest
//
//  Created by Wen Tan on 1/3/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "TWNotesTableVC.h"
#import "TWTableData.h"
#import "TWNote.h"
#import "TWNoteEditVC.h"

@interface TWNotesTableVC ()

@property (strong, nonatomic) NSMutableArray *notes;

@end

@implementation TWNotesTableVC

#pragma mark --TableView life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
	self.notes = [TWTableData sharedInstance].notes;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	// Whenever this view controller appears, reload the table. This allows it to reflect any changes
	// made whilst editing notes.
	[self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	TWNote *noteManager = self.notes[indexPath.row];
	cell.textLabel.text = noteManager.title;
	cell.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	TWNoteEditVC *noteEditVC = (TWNoteEditVC *)segue.destinationViewController;
	
	if ([segue.identifier isEqualToString:@"cellSelected"]) {
		NSIndexPath *path = [self.tableView indexPathForSelectedRow];
		noteEditVC.note = self.notes[path.row];
	}
	
	if ([segue.identifier isEqualToString:@"addNewNote"]) {
		noteEditVC.note = [TWNote noteWithText:@" "];
		[self.notes addObject:noteEditVC.note];
	}
	
}


@end
