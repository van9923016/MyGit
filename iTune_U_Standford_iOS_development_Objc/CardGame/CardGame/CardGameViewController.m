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

@interface CardGameViewController ()

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatching *matchingGame;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
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
	[self.matchingGame chooseCardAtIndex:index];
	[self updateUI];
}

- (NSString *)titleForCard:(Card *)card {
	return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
	return [UIImage imageNamed:(card.isChosen) ? @"cardFront" : @"cardBack"];
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
	self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.matchingGame.score];
}

#pragma mark - view lifecycle
- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
