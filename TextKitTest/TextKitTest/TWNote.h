//
//  TWNote.h
//  TextKitTest
//
//  Created by Wen Tan on 1/3/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWNote : NSObject

@property (strong, nonatomic) NSString *contents;
@property (strong, nonatomic) NSDate *timestamp;
@property (readonly, nonatomic) NSString *title;


+ (TWNote *)noteWithText:(NSString *)text;
@end
