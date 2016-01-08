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

@property (weak, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel  *countLabel;
@property (assign, nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatching *matchingGame;

@end

@implementation CardGameViewController

- (void)setFlipCount:(int)flipCount {
	//lazy loading
	_flipCount = flipCount;
	self.countLabel.text = [NSString stringWithFormat:@"Flip count: %d", self.flipCount];
}

-(Deck *)deck {
	if (!_deck) {
		_deck = [self creatDeck];
	}
	return _deck;
}

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
	
	
	//flip one card action
	if ([sender.currentTitle length]) {
		[sender setBackgroundImage:[UIImage imageNamed:@"cardBack"]
						  forState:UIControlStateNormal];
		[sender setTitle:@""
				forState:UIControlStateNormal];
		self.flipCount++;
	}else{
		//put card init in here or right below sender action is not same!!!
		Card *card = [self.deck drawRandomCard];
		if (card) {
			[sender setBackgroundImage:[UIImage imageNamed:@"cardFront"]
							  forState:UIControlStateNormal];
			[sender setTitle:card.contents
					forState:UIControlStateNormal];
			self.flipCount++;
		}
	}	
}

- (NSString *)titleForCard:(Card *)card {
	return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
	return [UIImage imageNamed:(card.isChosen) ? @"cardFront" : @"cardBack"];
}


- (void)updateUI {
	for (UIButton *cardButton  in self.cardButtons) {
		NSInteger index = [self.cardButtons indexOfObject:cardButton];
		Card *card = [self.matchingGame cardAtIndex:index];
		[cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
		[cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
		cardButton.enabled = !card.isMatched;
	}
}



#pragma mark - view lifecycle
- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
