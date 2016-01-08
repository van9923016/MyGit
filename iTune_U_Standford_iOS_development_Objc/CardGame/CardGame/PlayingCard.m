//
//  PlayingCard.m
//  CardGame
//
//  Created by Wen Tan on 1/7/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

//self implement suit property so have to put @synthesize of suit
@synthesize suit = _suit;
@synthesize rank = _rank;

//class method for creating things or  utilities
+ (NSArray *)validSuits {
	return @[@"♥︎", @"♦︎", @"♠︎", @"♣︎"];
}

+ (NSArray *)rankStrings {
	return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}


//override superclass property
- (NSString *)contents {
	NSArray *rankStrings = [PlayingCard rankStrings];
	return [rankStrings[self.rank] stringByAppendingString:self.suit];
}


- (void)setSuit:(NSString *)suit {
	if ([[PlayingCard validSuits] containsObject:suit]) {
		_suit = suit;
	}
}

//override ensure suit has value then show value or show ?
- (NSString *)suit {
	return _suit ? _suit : @"?";
}

+ (NSUInteger)maxRank {
	return ([[self rankStrings] count] - 1);
}

- (void)setRank:(NSUInteger)rank {
	if (rank <= [PlayingCard maxRank]) {
		_rank = rank;
	}
	
}


@end
