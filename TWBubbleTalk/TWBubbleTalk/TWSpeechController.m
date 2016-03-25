//
//  TWSpeechController.m
//  TWAVFoundation
//
//  Created by Wen Tan on 3/25/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "TWSpeechController.h"

@interface TWSpeechController ()

@property (nonatomic, strong, readwrite) AVSpeechSynthesizer *synthesizer;
@property (nonatomic, strong) NSArray *voices;
@property (nonatomic, strong) NSArray *speechStrings;

@end

@implementation TWSpeechController

+ (instancetype)speechController {
	return [[self alloc] init];
}

- (instancetype)init {
	self = [super init];
	if (self) {
		_synthesizer = [[AVSpeechSynthesizer alloc] init];
		_voices = @[[AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"],[AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"]];
		_speechStrings = [self buildSpeechStrings];
	}
	return self;
}

//create speech string in array format
- (NSArray*)buildSpeechStrings {
	return @[@"Hello, I'm Siri.Who are you?",
			 @"I'm Cook, Are you OK?",
			 @"I'm fine,I think i am hungry",
			 @"Well, We can have lunch together!",
			 @"Yeah,it's a good idea!",
			 @"By the way,You are beautiful.",
			 @"Aha! You are so sweet.",
			 @"Oh yeah? Today is a really fantastic day!"];
}
- (void)beginConversation {
	for (NSUInteger i = 0; i < self.speechStrings.count; i++) {
		AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.speechStrings[i]];
		//播放的声音，速率，音调，语句之间的暂停时间
		utterance.voice = self.voices[i%2];
		utterance.rate = 0.5f;
		utterance.pitchMultiplier = 0.8f;
		utterance.postUtteranceDelay = 0.1f;
		[self.synthesizer speakUtterance:utterance];
	}
}


@end
