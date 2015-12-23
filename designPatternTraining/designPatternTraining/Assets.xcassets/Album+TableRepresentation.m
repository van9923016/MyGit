//
//  Album+TableRepresentation.m
//  designPatternTraining
//
//  Created by Wen Tan on 12/23/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//


//Decorator design pattern: category, category template using to enhance super class function.
//Album model provide basic model value, using category extended album class without modify it.
//let it have key value pairs to be using in table view.

#import "Album+TableRepresentation.h"

@implementation Album (TableRepresentation)

- (NSDictionary *)tr_tableRepresentation {
	return @{
			 @"titles":@[@"Artist",	@"Album", @"Genre", @"Year"],
			 @"value":@[self.artist, self.title, self.genre, self.year]
			 };
}
@end
