//
//  PlayingCard.h
//  CardGame
//
//  Created by Wen Tan on 1/7/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

//inheritence from card object
@interface PlayingCard : Card

@property (copy, nonatomic) NSString *suit;
@property (assign, nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
