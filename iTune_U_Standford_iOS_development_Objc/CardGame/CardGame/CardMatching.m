//
//  CardMatching.m
//  CardGame
//
//  Created by Wen Tan on 1/8/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "CardMatching.h"

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

@interface CardMatching ()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;//of Cards
@end

@implementation CardMatching

- (NSMutableArray *)cards {
	if (!_cards) _cards = [[NSMutableArray alloc] init];
	return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count deck:(Deck *)deck {
	
	self = [super init];
	
	if (self) {
		self.score = 0;
		for (int i = 0; i < count; i++) {
			Card *card = [deck drawRandomCard];
			if (card) {
				//self.cards[i] = card;
				[self.cards addObject:card];
			}else{
				self = nil;
				break;
			}
		}
	}
	return self;
}


- (void)chooseCardAtIndex:(NSUInteger)index {
	
	Card *card = [self cardAtIndex:index];
	
	if (!card.isMatched) {
		
		if (card.isChosen) {
			card.chosen = NO;
		}else{
			//match against other card in deck
			
			for (Card *otherCard in self.cards) {
				if (otherCard.isChosen && !otherCard.isMatched) {
					//
					int matchScore = [card match:@[otherCard]];
					if (matchScore) {
						self.score += matchScore * MATCH_BONUS;
						card.matched = YES;
						otherCard.matched = YES;
					}else{
						self.score -= MISMATCH_PENALTY;
						card.matched = NO;
						otherCard.chosen = NO;
					}
					break;
				}
			}
			NSLog(@"%ld",(long)self.score);
			self.score -= COST_TO_CHOOSE;
			NSLog(@"%ld",(long)self.score);
			card.chosen = YES;
		}
	}
}

- (Card *)cardAtIndex:(NSUInteger)index {
	return (index < self.cards.count) ? self.cards[index] : nil;
}

- (void)resetScore {
	self.score = 0;
}

@end
