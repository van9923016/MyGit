//
//  FRPGalleryFlowLayout.m
//  FRPPixels
//
//  Created by Wen Tan on 12/2/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "FRPGalleryFlowLayout.h"

@implementation FRPGalleryFlowLayout

- (instancetype)init {
	self = [super init];
	if (!self)return nil;
	
	//define collectionview cell frame
	self.itemSize = CGSizeMake(150, 150);
	self.minimumInteritemSpacing = 10;
	self.minimumLineSpacing = 10;
	self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
	
	return self;
}


@end
