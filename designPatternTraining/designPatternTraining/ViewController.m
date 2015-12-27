//
//  ViewController.m
//  designPatternTraining
//
//  Created by Wen Tan on 12/20/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "ViewController.h"
#import "LibaryAPI.h"
#import "Album+TableRepresentation.h"
#import "AlbumView.h"
#import "HorizontalScroller.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,HorizontalScrollerDelegate>

//always using copy as mutable object as NSArray and NSString
@property (strong, nonatomic)	UITableView			*dataTable;
@property (copy, nonatomic)		NSArray				*allAlbums;
@property (strong, nonatomic)	NSDictionary		*currentAlbum;
@property (assign, nonatomic)	int					currentAlbumIndex;
@property (strong, nonatomic)	HorizontalScroller	*scroller;
@property (strong, nonatomic)	UIToolbar			*toolBar;
@property (strong, nonatomic)	NSMutableArray	    *undoStack;

@end

@implementation ViewController

- (void)showDataForAlbumAtIndex:(int)albumIndex {
	// ensure not out of bounds of array.
	if (albumIndex < self.allAlbums.count) {
		//fetch data
		Album *album = self.allAlbums[albumIndex];
		//save album data to represent it in tableview
		self.currentAlbum = [album tr_tableRepresentation];
		
	}else{
		self.currentAlbum = nil;
	}
	[self.dataTable reloadData];
}

- (void)reloadScroller {

	self.allAlbums = [[LibaryAPI sharedInstance] getAlbums];
	if (self.currentAlbumIndex <= 0) {
		self.currentAlbumIndex = 0;
	}else if (self.currentAlbumIndex >= self.allAlbums.count){
		self.currentAlbumIndex = self.currentAlbumIndex - 1;
	}
	
	
	[self showDataForAlbumAtIndex:self.currentAlbumIndex];
	[self.scroller reload];
}


#pragma mark -- HorizontalScrollerDelegate methods

- (void)horizontalScroller:(HorizontalScroller *)scroller clickedViewAtIndex:(int)index {
	self.currentAlbumIndex = index;
	[self showDataForAlbumAtIndex:index];
}

- (NSInteger)numberOfViewsForHorizontalScroller:(HorizontalScroller *)scroller {
	return self.allAlbums.count;
}

- (UIView *)horizontalScroller:(HorizontalScroller *)scroller viewAtIndex:(int)index {
	Album *album = self.allAlbums[index];
	return [[AlbumView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) albumCover:album.coverURL];
}

#pragma mark -- TableView delegate and data source implementation
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.currentAlbum[@"titles"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
	}
	
	cell.textLabel.text = self.currentAlbum[@"titles"][indexPath.row];
	cell.detailTextLabel.text = self.currentAlbum[@"values"][indexPath.row];
	return cell;
}


#pragma mark -- The Memento design pattern
//save current state

- (void)saveCurrentState {
	// When the user leaves the app and then comes back again, he wants it to be in the exact same state
	// he left it. In order to do this we need to save the currently displayed album.
	// Since it's only one piece of information we can use NSUserDefaults.
	[[NSUserDefaults standardUserDefaults] setInteger:self.currentAlbumIndex forKey:@"currentAlbumIndex"];
	
	//trigger the saving of album data whenever the ViewController saves its state.
	[[LibaryAPI sharedInstance] saveAlbums];
}

//load last sate user quit app
- (void)loadPreviouState {
	self.currentAlbumIndex = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"currentAlbumIndex"];
	[self showDataForAlbumAtIndex:self.currentAlbumIndex];
}


//override current index based on this view controller
- (NSInteger)initialViewIndexForHorizontalScroller:(HorizontalScroller *)scroller {
	return self.currentAlbumIndex;
}



//method for command design pattern
- (void)addAlbum:(Album *)album atIndex:(int)index {
	[[LibaryAPI sharedInstance] addAlbum:album atIndex:index];
	self.currentAlbumIndex = index;
	[self reloadScroller];
	
}

- (void)deleteAlbum {
	if (self.allAlbums.count == 0) {

	}
	// Get the album need to be delete
	Album *deletedAlbum = self.allAlbums[self.currentAlbumIndex];
	
	// Define an object of type NSMethodSignature to create the NSInvocation, reverse the delete action if the user later decides to undo a deletion
	NSMethodSignature *sig = [self methodSignatureForSelector:@selector(addAlbum:atIndex:)];
	NSInvocation	  *undoAction = [NSInvocation invocationWithMethodSignature:sig];
	undoAction.target = self;
	undoAction.selector = @selector(addAlbum:atIndex:);
	[undoAction setArgument:&deletedAlbum atIndex:2];
	[undoAction setArgument:&_currentAlbumIndex atIndex:3];
	[undoAction retainArguments];
	// 3
	[self.undoStack addObject:undoAction];
	
	// 4
	[[LibaryAPI sharedInstance] deleteAlbumAtIndex:self.currentAlbumIndex];
	[self reloadScroller];
	
	// 5
	[self.toolBar.items[0] setEnabled:YES];
	
	if (self.undoStack.count == 5) {
		[self.toolBar.items[2] setEnabled:NO];
		//alert
		UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Error" message:@"No more data, try Undo restore!" preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
		[alertVC addAction:action];
		
		[self presentViewController:alertVC animated:YES completion:nil];
	}
	
}

- (void)undoAction {
	self.toolBar.items[2].enabled = YES;
	if (self.undoStack.count > 0) {
		NSInvocation *undoAction = [self.undoStack lastObject];
		[self.undoStack removeLastObject];
		[undoAction invoke];
		[self reloadScroller];
	}
	
	if (self.undoStack.count == 0) {
		self.toolBar.items[0].enabled = NO;
	}
	
}


#pragma mark -- App Life Cyclyes

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithRed:0.76f
												green:0.81f
												 blue:0.87f
												alpha:1];
	
	//configure toolbar
	self.toolBar = [[UIToolbar alloc] init];

	UIBarButtonItem *undoItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(undoAction)];
	undoItem.enabled = NO;
	
	UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem *delete = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteAlbum)];
	[self.toolBar setItems:@[undoItem, space, delete]];
	
	[self.view addSubview:self.toolBar];
	
	self.undoStack = [[NSMutableArray alloc] init];
	
	self.currentAlbumIndex = 0;
	
	self.allAlbums = [[LibaryAPI sharedInstance] getAlbums];
	
	//UITableView represent album data
	self.dataTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height-120)
												  style:UITableViewStyleGrouped];
	self.dataTable.delegate = self;
	self.dataTable.dataSource = self;
	self.dataTable.backgroundView = nil;
	[self.view addSubview:self.dataTable];
	
	[self loadPreviouState];
	
	self.scroller = [[HorizontalScroller alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 120)];
	self.scroller.backgroundColor = [UIColor colorWithRed:0.24f green:0.35f blue:0.49f alpha:1];
	self.scroller.delegate = self;
	[self.view addSubview:self.scroller];
	[self reloadScroller];

	
	
	//fetch data and reload tableview
	[self showDataForAlbumAtIndex:self.currentAlbumIndex];
	
	
	//whenever user put this app to backround call saveCurrentState to save settings and view
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(saveCurrentState)
												 name:UIApplicationDidEnterBackgroundNotification
											   object:nil];
}

- (void)viewWillLayoutSubviews {
	self.toolBar.frame = CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44);
	self.dataTable.frame = CGRectMake(0, 130, self.view.frame.size.width, self.view.frame.size.height-175);
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
