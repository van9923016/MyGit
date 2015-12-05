//
//  FRPPhotoViewController.m
//  FRPPixels
//
//  Created by Wen Tan on 12/3/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "FRPPhotoModel.h"
#import "FRPPhotoViewController.h"

#import "FRPPhotoImporter.h"
#import <SVProgressHUD.h>

@interface FRPPhotoViewController ()

//Private assignment
@property (nonatomic, assign) NSInteger photoIndex;
@property (nonatomic, strong) FRPPhotoModel *photoModel;

//private properties
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation FRPPhotoViewController


- (instancetype)initWithPhotoModel:(FRPPhotoModel *)photoModel index:(NSInteger)photoIndex {
	self = [self init];
	if (!self) {
		return nil;
	}
	self.photoIndex = photoIndex;
	self.photoModel = photoModel;
	return self;
}



#pragma mark -- App lifecycles
- (void)viewDidLoad {
    [super viewDidLoad];
	//configure self's view
	self.view.backgroundColor = [UIColor blackColor];
	
	//configure subviews
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
	RAC(imageView, image) = [RACObserve(self.photoModel, fullsizedData) map:^id(id value) {
		return [UIImage imageWithData:value];
	}];
	
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	[self.view addSubview:imageView];
	self.imageView = imageView;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[SVProgressHUD show];
	
//	fetch data
	[[FRPPhotoImporter fetchPhotoDetails:self.photoModel]
	 subscribeError:^(NSError *error) {
		[SVProgressHUD showErrorWithStatus:@"error"];
	} completed:^{
		[SVProgressHUD dismiss];
	}];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
