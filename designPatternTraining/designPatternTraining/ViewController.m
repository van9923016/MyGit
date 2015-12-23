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

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView	*dataTable;
@property (assign, nonatomic) NSArray		*allAlbums;
@property (strong, nonatomic) NSDictionary	*currentAlbum;
@property (assign, nonatomic) int			currentAlbumIndex;

@end

@implementation ViewController

- (void)showDataForAlbumAtIndex:(int)albumIndex {
	// ensure not out of bounds of array.
	if (albumIndex < self.allAlbums.count) {
		//fetch data
		Album *album = self.allAlbums[albumIndex];
		//save album data to represent it in tableview
		self.currentAlbum = [album tr_tableRepresentation];
		NSLog(@"%@",self.currentAlbum);
	}else{
		self.currentAlbum = nil;
	}
	[self.dataTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@"%lu",[self.currentAlbum[@"titles"] count]);
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


#pragma mark --App Life Cyclyes

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithRed:0.76f
												green:0.81f
												 blue:0.87f
												alpha:1];
	self.currentAlbumIndex = 0;
	
	self.allAlbums = [[LibaryAPI sharedInstance] getAlbums];
	
	//UITableView represent album data
	self.dataTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height-120)
												  style:UITableViewStyleGrouped];
	self.dataTable.delegate = self;
	self.dataTable.dataSource = self;
	self.dataTable.backgroundView = nil;
	[self.view addSubview:self.dataTable];
	
	//fetch data and reload tableview
	[self showDataForAlbumAtIndex:self.currentAlbumIndex];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
