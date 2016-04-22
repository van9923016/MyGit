//
//  ViewController.m
//  TWAudioPlayer
//
//  Created by Wen Tan on 3/26/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "ViewController.h"
@import AVFoundation;

@interface ViewController ()

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, weak) IBOutlet UIButton *playButton;

@end

@implementation ViewController

- (IBAction)buttonPressed:(UIButton *)sender {
	if (self.audioPlayer) {
		[self.audioPlayer play];
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	NSURL *musicURL = [[NSBundle mainBundle] URLForResource:@"Adam Levine - No One Else Like You" withExtension:@"mp3"];
	NSError *error;
	self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:&error];
	if (self.audioPlayer) {
		[self.audioPlayer prepareToPlay];
	}
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
