//
//  CardMatching.h
//  CardGame
//
//  Created by Wen Tan on 1/8/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"
@interface CardMatching : NSObject

@property (nonatomic, readonly) NSInteger *score;

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count deck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@end
