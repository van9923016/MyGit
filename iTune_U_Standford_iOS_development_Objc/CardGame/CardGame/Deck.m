//
//  Deck.m
//  CardGame
//
//  Created by Wen Tan on 1/7/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "Deck.h"

@interface Deck ()

@property (strong, nonatomic) NSMutableArray *cards;
@end


@implementation Deck

//compare to put this into big init method, this is more lay loading and more logic
-(NSMutableArray *)cards {
	if (!_cards) {
		_cards = [[NSMutableArray alloc] init];
	}
	return _cards;
}

- (void)addCard:(Card *)card {
	[self addCard:card atTop:NO];
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop {
	
	if (atTop) {
		[self.cards insertObject:card atIndex:0];
	}else{
		[self.cards addObject:card];
	}
}

- (Card *)drawRandomCard {
	
	Card *randomCard = nil;
	
	if ([self.cards count]) {
		unsigned index = arc4random() % [self.cards count];
		randomCard = self.cards[index];
		[self.cards removeObjectAtIndex:index];
	}

	return randomCard;
}
@end
