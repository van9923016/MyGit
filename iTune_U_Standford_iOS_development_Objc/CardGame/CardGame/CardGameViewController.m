//
//  ViewController.m
//  CardGame
//
//  Created by Wen Tan on 1/7/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatching.h"

static const NSUInteger MODEEASY = 2;
static const NSUInteger MODEHARD = 3;

@interface CardGameViewController ()

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatching *matchingGame;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardModeSeg;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;
@property (weak, nonatomic) IBOutlet UILabel *matchStateLabel;
//view create by xib and IBOutCollection should be strong
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation CardGameViewController

- (Deck *)creatDeck {
	return [[PlayingCardDeck alloc] init];;
}

- (CardMatching *)matchingGame {
	if (!_matchingGame) {
		_matchingGame = [[CardMatching alloc] initWithCardCount:self.cardButtons.count
														   deck:[self creatDeck]];
	}
	return _matchingGame;
}

- (IBAction)cardButtonPressed:(UIButton *)sender {
	NSInteger index = [self.cardButtons indexOfObject:sender];
	//FIXME: card match status!!!
	[self.matchingGame chooseCardAtIndex:index];
	[self updateUI];
}

- (NSString *)titleForCard:(Card *)card {
	return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
	return [UIImage imageNamed:(card.isChosen) ? @"cardFront" : @"cardBack"];
}

- (void)updateScoreLabel {
	self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.matchingGame.score];
}
- (void)updateMatchingLabelStatus {
	
}
- (void)updateUI {

	for (UIButton *cardButton in self.cardButtons) {
		
		NSInteger index = [self.cardButtons indexOfObject:cardButton];
		Card *card = [self.matchingGame cardAtIndex:index];
		[cardButton setTitle:[self titleForCard:card]
					forState:UIControlStateNormal];
		[cardButton setBackgroundImage:[self backgroundImageForCard:card]
							  forState:UIControlStateNormal];
		cardButton.enabled = !card.isMatched;
	}
	[self updateScoreLabel];
	[self updateMatchingLabelStatus];
}



- (IBAction)switchButtonPressed:(UISwitch *)sender {
	self.cardModeSeg.enabled = sender.isOn ? YES : NO;
}

- (IBAction)segmentChanged:(UISegmentedControl *)sender {
	//TODO: Segment changed action
}

- (IBAction)resetScore:(UIButton *)sender {
	
	UIAlertController *resetAlertVC = [UIAlertController alertControllerWithTitle:@"清零分数？"
																		  message:@"将重置您的积分，且不可恢复"
																   preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *resetAction = [UIAlertAction actionWithTitle:@"确定"
														  style:UIAlertActionStyleDefault
														handler:^(UIAlertAction * _Nonnull action) {
															[self.matchingGame resetScore];
															[self updateScoreLabel];
														}];
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
														   style:UIAlertActionStyleCancel
														 handler:nil];
	[resetAlertVC addAction:resetAction];
	[resetAlertVC addAction:cancelAction];
	[self presentViewController:resetAlertVC animated:YES completion:nil];
}

#pragma mark - view lifecycle
- (void)viewDidLoad {
	[super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
