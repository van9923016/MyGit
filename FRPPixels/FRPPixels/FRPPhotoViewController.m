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
	return self;
}



#pragma mark -- App lifecycles
- (void)viewDidLoad {
    [super viewDidLoad];
	
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
