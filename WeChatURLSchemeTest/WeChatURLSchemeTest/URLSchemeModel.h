//
//  URLSchemeModel.h
//  WeChatURLSchemeTest
//
//  Created by Wen Tan on 1/7/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLSchemeModel : NSObject

@property (copy, nonatomic) NSString *stickers;
@property (copy, nonatomic) NSString *moments;
@property (copy, nonatomic) NSString *scan;
@property (copy, nonatomic) NSString *profile;
@property (copy, nonatomic) NSString *chat;
@property (copy, nonatomic) NSString *officialAccounts;
@property (copy, nonatomic) NSString *myQRCode;

+ (URLSchemeModel *)sharedModel;

@end
