//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Wen Tan on 1/10/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()

@property (nonatomic, weak) IBOutlet UILabel *colorfulCharactersLabel;
@property (nonatomic, weak) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController


- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze {
	_textToAnalyze = textToAnalyze;
	//check if this view is valid, if it is then update using getting of property
	//if not using viewWillAppear method update
	//prepare for segue method segue into this view can pass value to its public properties but those view outlets are not set yet
	if (self.view.window) {
		[self updateUI];
	}
}

//analyze NSAttributedString using its attributeName
- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName {
	
	NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
	
	unsigned index = 0;
	
	while (index < [self.textToAnalyze length]) {
		NSRange range;
		id value = [self.textToAnalyze attribute:attributeName
										 atIndex:index
								  effectiveRange:&range];
		if (value) {
			[characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
			//jump out this range
			index = (int)(range.location + range.length);
		}else{
			//not found keep finding
			index++;
		}
	}
	return characters;
}
- (void)updateUI {
	self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%lu colorful characters", (unsigned long)[[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
	self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%lu outlined characters", [[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}

#pragma mark - View life cycles
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self updateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
