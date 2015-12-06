//
//  FRPFullSizePhotoViewController.m
//  FRPPixels
//
//  Created by Wen Tan on 12/3/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "FRPFullSizePhotoViewController.h"
#import "FRPPhotoViewController.h"

@interface FRPFullSizePhotoViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

//private assignment
@property (nonatomic, strong) NSArray *photoModelArray;
@property (nonatomic, strong) UIPageViewController *pageViewController;

@end

@implementation FRPFullSizePhotoViewController

- (instancetype)initWithPhotoModels:(NSArray *)photoModelArray currentPhotoIndex:(NSInteger)photoIndex {
	self = [self init];
	if (!self) {
		return nil;
	}
	
	//Init readonly properties
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
	
	[self.pageViewController setViewControllers:@[[self photoViewControllerForIndex:photoIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
	
	return self;
}

- (FRPPhotoViewController *)photoViewControllerForIndex:(NSInteger)index {
	if (index >= 0 && index < self.photoModelArray.count) {
		FRPPhotoModel *photoModel = self.photoModelArray[index];
		
		FRPPhotoViewController *photoViewController = [[FRPPhotoViewController alloc] initWithPhotoModel:photoModel index:index];
		return photoViewController;
	}
	//Index out of bounds, return nil
	return nil;
}



#pragma mark -- UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
	self.title = [[self.pageViewController.viewControllers.firstObject photoModel] photoName];
	[self.delegate userDidScroll:self toPhotoAtIndex:[self.pageViewController.viewControllers.firstObject photoIndex]];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(FRPPhotoViewController *)viewController {
	return [self photoViewControllerForIndex:viewController.photoIndex - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(FRPPhotoViewController *)viewController {
	return [self photoViewControllerForIndex:viewController.photoIndex + 1];
}

#pragma mark <APPLifecycles>

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
