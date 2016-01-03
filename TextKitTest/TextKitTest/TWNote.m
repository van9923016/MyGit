//
//  TWNote.m
//  TextKitTest
//
//  Created by Wen Tan on 1/3/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "TWNote.h"

@implementation TWNote

+ (TWNote *)noteWithText:(NSString *)text {
	TWNote *note = [[TWNote alloc] init];
	note.contents = text;
	note.timestamp = [NSDate date];
	return note;
}

- (NSString *)title {
	//split into lines
	NSArray *lines = [self.contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
	//return the first
	return lines[0];
}
@end
