//
//  FRPFullSizePhotoViewController.m
//  FRPPixels
//
//  Created by Wen Tan on 12/3/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "FRPFullSizePhotoViewController.h"

@interface FRPFullSizePhotoViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

//private assignment
@property (nonatomic, strong) NSArray *photoModelArray;
@property (nonatomic, strong) UIPageViewController *pageViewController;

@end

@implementation FRPFullSizePhotoViewController

- (instancetype)initwithPhotoModels:(NSArray *)photoModelArray currentPhotoIndex:(NSInteger)photoIndex {
	self = [super init];
	if (!self) {
		return nil;
	}
	
	//Init read only properties
	self.photoModelArray = photoModelArray;
	
	//configure self
	self.title = [self.photoModelArray[photoIndex] photoName];
	
	//View controllers
	self.pageViewController = [[UIPageViewController alloc]
							   initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
							   navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
							   options:@{UIPageViewControllerOptionInterPageSpacingKey:@(30)}];
	self.pageViewController.dataSource = self;
	self.pageViewController.delegate = self;
	[self addChildViewController:self.pageViewController];
	
//	[self.pageViewController setViewControllers:<#(nullable NSArray<UIViewController *> *)#> direction:<#(UIPageViewControllerNavigationDirection)#> animated:<#(BOOL)#> completion:<#^(BOOL finished)completion#>]
	
	return self;
}

- (FRPFullSizePhotoViewController *)photoViewControllerForIndex:(NSInteger)index {
	if (index >= 0 && index < self.photoModelArray.count) {
		FRPPhotoModel *photoModel = self.photoModelArray[index];
		
	}
}



#pragma mark -- UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
	
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
	
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
	
}

#pragma mark -- APP lifecycles

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor blackColor];
	
	//configure subviews
	self.pageViewController.view.frame = self.view.bounds;
	[self.view addSubview:self.pageViewController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
