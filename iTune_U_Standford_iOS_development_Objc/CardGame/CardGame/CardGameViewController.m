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

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UIButton *cardBtn;
@property (weak, nonatomic) IBOutlet UILabel  *countLabel;
@property (assign, nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;

@end

@implementation CardGameViewController

-(Deck *)deck {
	if (!_deck) {
		_deck = [self creatDeck];
	}
	[_deck.cards count];
	return _deck;
}

- (Deck *)creatDeck {
	return [[PlayingCardDeck alloc] init];;
}



- (IBAction)cardButtonPressed:(UIButton *)sender {
	
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

- (void)setFlipCount:(int)flipCount {
	//lazy loading
	_flipCount = flipCount;
	self.countLabel.text = [NSString stringWithFormat:@"Flip count: %d", self.flipCount];
}

#pragma mark - view lifecycle
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
