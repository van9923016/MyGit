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

#import <RACDelegateProxy.h>

@interface FRPGalleryViewController ()
//photoModel array
@property (nonatomic, strong) NSArray *photosArray;
@property (nonatomic, strong) id collectionViewDelegate;

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

#pragma mark --- RacDelegate replace delegate-type protocol method
//	RACDelegateProxy *vcDelegate = [[RACDelegateProxy alloc] initWithProtocol:@protocol(FRPFullSizePhotoViewControllerDelegate)];
//	
//	[[vcDelegate rac_signalForSelector:@selector(userDidScroll:toPhotoAtIndex:) fromProtocol:@protocol(FRPFullSizePhotoViewControllerDelegate)] subscribeNext:^(RACTuple *value) {
//		@strongify(self);
//		NSLog(@"sdvsd");
//		[self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:[value.second integerValue] inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
//	}];
//	
//	self.collectionViewDelegate = [[RACDelegateProxy alloc] initWithProtocol:@protocol(UICollectionViewDelegate)];
//	[[self.collectionViewDelegate rac_signalForSelector:@selector(collectionView:didSelectItemAtIndexPath:)] subscribeNext:^(RACTuple *arguments) {
//		@strongify(self);
//		FRPFullSizePhotoViewController *vc = [[FRPFullSizePhotoViewController alloc] initWithPhotoModels:self.photosArray
//																								   currentPhotoIndex:[(NSIndexPath *)arguments.second item]];
//		vc.delegate = (id<FRPFullSizePhotoViewControllerDelegate>)vcDelegate;
//		[self.navigationController pushViewController:vc animated:YES];
//	}];
	
	
	//load data
	//	[self loadPopularPhotos];
	
	//Refactor loadPopularPhotos method
	
	//Level 1
	//	RACSignal *photoSignal = [FRPPhotoImporter importPhotos];
	//	RACSignal *photoIsLoaded = [photoSignal catch:^RACSignal *(NSError *error) {
	//		NSLog(@"Could't fetch photos from 500px: %@", error);
	//		return [RACSignal empty];
	//	}];
	//	RAC(self, photosArray) = photoIsLoaded;
	//	photoIsLoaded subscribeCompleted:^{
	//		@strongify(self);
	//		[self.collectionView reloadData];
	//	}
	
	//Level 2
	RAC(self,photosArray) = [[[[FRPPhotoImporter importPhotos]
							   doCompleted:^{
								   @strongify(self);
								   [self.collectionView reloadData];
							   }] logError] catchTo:[RACSignal empty]];
	
	[RACObserve(self, photosArray) subscribeNext:^(id x) {
		@strongify(self);
		[self.collectionView reloadData];
	}];
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

//#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	FRPFullSizePhotoViewController *fullsizeViewController = [[FRPFullSizePhotoViewController alloc] initWithPhotoModels:self.photosArray currentPhotoIndex:indexPath.item];
	fullsizeViewController.delegate = self;
	[self.navigationController pushViewController:fullsizeViewController animated:YES];
}

//#pragma mark <FRPFullSizePhotoViewControllerDelegate>

- (void)userDidScroll:(FRPFullSizePhotoViewController *)viewController toPhotoAtIndex:(NSInteger)index {
	[self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]
								atScrollPosition:UICollectionViewScrollPositionCenteredVertically
										animated:YES];
}




@end
