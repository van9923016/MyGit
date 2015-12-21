//
//  Album.h
//  designPatternTraining
//
//  Created by Wen Tan on 12/21/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *artist;
@property (nonatomic, copy, readonly) NSString *genre;
@property (nonatomic, copy, readonly) NSString *coverURL;
@property (nonatomic, copy, readonly) NSString *year;

- (instancetype)initWithTitle:(NSString *)title artist:(NSString *)artist coverURL:(NSString *)URL year:(NSString *)year;

@end
