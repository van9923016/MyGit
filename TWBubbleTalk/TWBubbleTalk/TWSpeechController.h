//
//  TWSpeechController.h
//  TWAVFoundation
//
//  Created by Wen Tan on 3/25/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

@import AVFoundation;

@interface TWSpeechController : NSObject

@property (nonatomic,strong, readonly) AVSpeechSynthesizer *synthesizer;

+ (instancetype)speechController;

- (void)beginConversation;


@end
