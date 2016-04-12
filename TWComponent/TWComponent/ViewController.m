//
//  ViewController.m
//  TWComponent
//
//  Created by Wen Tan on 4/11/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "ViewController.h"
#import <HandyFrame/UIView+LayoutMethods.h>
#import "TWMediator+ModuleAActions.h"

NSString *const kCellIdentifier = @"kCellIdentifier";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.tableView fill];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
	cell.textLabel.text = self.dataSource[indexPath.row];
	return cell;
}



#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if (indexPath.row == 0) {
		UIViewController *viewController = [[TWMediator sharedInstance] TWMediator_viewControllerForDetail];
		[self presentViewController:viewController animated:YES completion:nil];
	}
	
	if (indexPath.row == 1) {
		UIViewController *viewController = [[TWMediator sharedInstance] TWMediator_viewControllerForDetail];
		[self.navigationController pushViewController:viewController animated:YES];
	}
	
	if (indexPath.row == 2) {
		[[TWMediator sharedInstance] TWMediator_presentImage:[UIImage imageNamed:@"image"]];
	}
	
	if (indexPath.row == 3) {
		[[TWMediator sharedInstance] TWMediator_presentImage:nil];
	}
	
	if (indexPath.row == 4) {
		[[TWMediator sharedInstance] TWMediator_showAlertWithMessage:@"itaen" cancelAction:nil completion:^(NSDictionary *info) {
			NSLog(@"Done!");
		}];
	}
}

#pragma mark - Getters and Setters

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		[_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
	}
	return _tableView;
}

- (NSArray *)dataSource {
	if (!_dataSource) {
		_dataSource = @[@"present detail view controller",
						@"push detail view controller",
						@"present image",
						@"present image when error",
						@"show alert"];
	}
	return _dataSource;
}



@end
