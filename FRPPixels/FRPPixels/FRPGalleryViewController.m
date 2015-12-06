//
//  FRPGalleryViewController.m
//  FRPPixels
//
//  Created by Wen Tan on 12/2/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "FRPGalleryViewController.h"
#import "FRPGalleryFlowLayout.h"
#import "FRPCell.h"
#import "FRPFullSizePhotoViewController.h"

@interface FRPGalleryViewController ()
//photoModel array
@property (nonatomic, strong) NSArray *photosArray;

@end

@implementation FRPGalleryViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init {
	FRPGalleryFlowLayout *flowLayout = [[FRPGalleryFlowLayout alloc] init];
	self = [self initWithCollectionViewLayout:flowLayout];
	if (!self) return nil;
	return self;
}


- (void)loadPopularPhotos {
	[[FRPPhotoImporter importPhotos] subscribeNext:^(id x) {
		self.photosArray = x;
		NSLog(@"Array is %@",self.photosArray);
	} error:^(NSError *error) {
		NSLog(@"Could't fetch photos from 500px: %@",error);
	}];
}

#pragma mark <AppLifecycles>

- (void)viewDidLoad {
    [super viewDidLoad];

	//configure self
	self.title  = @"Popular on 500px";
	//configure view
	[self.collectionView registerClass:[FRPCell class] forCellWithReuseIdentifier:reuseIdentifier];
	
	//Reactive Stuff, avoid strong reference cycle, once array change view will reload
	@weakify(self);
	[RACObserve(self, photosArray) subscribeNext:^(id x) {
		@strongify(self);
		[self.collectionView reloadData];
	}];
	
	//load data
	[self loadPopularPhotos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photosArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	// Configure the cell
	FRPCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
	[cell setPhotoModel:self.photosArray[indexPath.row]];
	
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	FRPFullSizePhotoViewController *fullsizeViewController = [[FRPFullSizePhotoViewController alloc] initWithPhotoModels:self.photosArray currentPhotoIndex:indexPath.item];
	fullsizeViewController.delegate = self;
	[self.navigationController pushViewController:fullsizeViewController animated:YES];
}

#pragma mark <FRPFullSizePhotoViewControllerDelegate>

- (void)userDidScroll:(FRPFullSizePhotoViewController *)viewController toPhotoAtIndex:(NSInteger)index {
	[self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]
								atScrollPosition:UICollectionViewScrollPositionCenteredVertically
										animated:YES];
}




@end
