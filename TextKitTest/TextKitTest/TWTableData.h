//
//  TWTableData.h
//  TextKitTest
//
//  Created by Wen Tan on 1/3/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWTableData : NSObject

@property (strong, nonatomic) NSMutableArray *notes;

+ (TWTableData *)sharedInstance;

@end
