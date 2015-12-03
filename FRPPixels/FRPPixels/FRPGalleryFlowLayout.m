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
	if (!(self = [super init])) {
		return nil;
	}
	
	self.itemSize = CGSizeMake(145, 145);
	self.minimumInteritemSpacing = 10;
	self.minimumLineSpacing = 10;
	self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
	
	return self;
}


@end
