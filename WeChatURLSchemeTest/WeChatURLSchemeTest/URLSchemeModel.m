//
//  URLSchemeModel.m
//  WeChatURLSchemeTest
//
//  Created by Wen Tan on 1/7/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "URLSchemeModel.h"


@interface URLSchemeModel ()

@property (copy, nonatomic) NSString *games;
@property (copy, nonatomic) NSString *add;
@property (copy, nonatomic) NSString *shopping;
@property (copy, nonatomic) NSString *groupChat;
@property (copy, nonatomic) NSString *settings;
@property (copy, nonatomic) NSString *general;
@property (copy, nonatomic) NSString *help;
@property (copy, nonatomic) NSString *notification;
@property (copy, nonatomic) NSString *terms;
@property (copy, nonatomic) NSString *features;
@property (copy, nonatomic) NSString *clear;
@property (copy, nonatomic) NSString *feedback;
@property (copy, nonatomic) NSString *faq;
@property (copy, nonatomic) NSString *recommendation;
@property (copy, nonatomic) NSString *groups;
@property (copy, nonatomic) NSString *tags;
@property (copy, nonatomic) NSString *posts;
@property (copy, nonatomic) NSString *favorites;
@property (copy, nonatomic) NSString *privacy;
@property (copy, nonatomic) NSString *security;
@property (copy, nonatomic) NSString *wallet;
@property (copy, nonatomic) NSString *businessPay;
@property (copy, nonatomic) NSString *wechatOut;
@property (copy, nonatomic) NSString *protection;
@property (copy, nonatomic) NSString *card;
@property (copy, nonatomic) NSString *about;
@property (copy, nonatomic) NSString *blacklist;
@property (copy, nonatomic) NSString *textSize;
@property (copy, nonatomic) NSString *sight;
@property (copy, nonatomic) NSString *languages;
@property (copy, nonatomic) NSString *chatHistory;
@property (copy, nonatomic) NSString *bindQQ;
@property (copy, nonatomic) NSString *bindMobile;
@property (copy, nonatomic) NSString *bindEmail;
@property (copy, nonatomic) NSString *securityAssitant;
@property (copy, nonatomic) NSString *broadcastMessage;
@property (copy, nonatomic) NSString *setname;
@property (copy, nonatomic) NSString *myAddress;
@property (copy, nonatomic) NSString *hideMoments;
@property (copy, nonatomic) NSString *blockMoments;
@property (copy, nonatomic) NSString *stickerSetting;
@property (copy, nonatomic) NSString *log;
@property (copy, nonatomic) NSString *wechatCoupon;
@property (copy, nonatomic) NSString *phoneView;
@property (copy, nonatomic) NSString *commonView;
@property (copy, nonatomic) NSString *businessTempSession;
@property (copy, nonatomic) NSString *businessGameDetail;
@property (copy, nonatomic) NSString *businessGameLibrary;
@property (copy, nonatomic) NSString *businessWebviewLink;
@property (copy, nonatomic) NSString *updateNewestVersion;

@end

//common api for wechat url schemes
/*
 "weixin://dl/stickers"
 "weixin://dl/games"
 "weixin://dl/moments"
 "weixin://dl/add"
 "weixin://dl/shopping"
 "weixin://dl/groupchat"
 "weixin://dl/scan"
 "weixin://dl/profile"
 "weixin://dl/settings"
 "weixin://dl/general"
 "weixin://dl/help"
 "weixin://dl/notifications"
 "weixin://dl/terms"
 "weixin://dl/chat"
 "weixin://dl/features"
 "weixin://dl/clear"
 "weixin://dl/feedback"
 "weixin://dl/faq"
 "weixin://dl/recommendation"
 "weixin://dl/groups"
 "weixin://dl/tags"
 "weixin://dl/officialaccounts"
 "weixin://dl/posts"
 "weixin://dl/favorites"
 "weixin://dl/privacy"
 "weixin://dl/security"
 "weixin://dl/wallet"
 "weixin://dl/businessPay"
 "weixin://dl/businessPay/"
 "weixin://dl/wechatout"
 "weixin://dl/protection"
 "weixin://dl/card"
 "weixin://dl/about"
 "weixin://dl/blacklist"
 "weixin://dl/textsize"
 "weixin://dl/sight"
 "weixin://dl/languages"
 "weixin://dl/chathistory"
 "weixin://dl/bindqq"
 "weixin://dl/bindmobile"
 "weixin://dl/bindemail"
 "weixin://dl/securityassistant"
 "weixin://dl/broadcastmessage"
 "weixin://dl/setname"
 "weixin://dl/myQRcode"
 "weixin://dl/myaddress"
 "weixin://dl/hidemoments"
 "weixin://dl/blockmoments"
 "weixin://dl/stickersetting"
 "weixin://dl/log"
 "weixin://dl/wechatoutcoupon"
 "weixin://dl/login/phone_view"
 "weixin://dl/login/common_view"
 "weixin://dl/businessPay"
 "weixin://dl/businessTempSession/"
 "weixin://dl/businessGame/detail/"
 "weixin://dl/businessGame/detail"
 "weixin://dl/businessGame/library/"
 "weixin://dl/businessGame/library"
 "weixin://dl/businessWebview/link/"
 "weixin://dl/businessWebview/link"
 "weixin://dl/business/tempsession/"
 "weixin://dl/businessTempSession/"
 "weixin://dl/business"
 "weixin://dl/wechatout"
 "weixin://dl/update_newest_version"
 "weixin://dl/moments"
 "weixin://dl/recommendation"
 */


@implementation URLSchemeModel

- (instancetype)init {
	self = [super init];
	if (self) {
		_stickers = @"weixin://dl/stickers";
		_moments = @"weixin://dl/moments";
		_scan = @"weixin://dl/scan";
		_profile = @"weixin://dl/profile";
		_chat = @"weixin://dl/chat";
		_officialAccounts = @"weixin://dl/officialaccounts";
		_myQRCode = @"weixin://dl/myQRCode";
		
		
	}
	
	return self;
}

+ (URLSchemeModel *)sharedModel {
	static id _shareModel = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_shareModel = [[URLSchemeModel alloc] init];
		
	});
	return _shareModel;
}

@end
