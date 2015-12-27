//
//  designPatternTrainingTests.m
//  designPatternTrainingTests
//
//  Created by Wen Tan on 12/27/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AlbumView.h"
@interface designPatternTrainingTests : XCTestCase

@property (nonatomic, strong) AlbumView *albumView;

@end

@implementation designPatternTrainingTests

- (void)setUp {
    [super setUp];
	self.albumView = [[AlbumView alloc]init];
}

- (void)tearDown {
    [super tearDown];
	self.albumView = nil;
}

- (void)testExample {
	//Generates a failure when ((\a expression) == nil).
	
	XCTAssertNotNil(self.albumView,@"It is not nil");
	
	
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
