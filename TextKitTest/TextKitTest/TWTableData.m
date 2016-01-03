//
//  TWTableData.m
//  TextKitTest
//
//  Created by Wen Tan on 1/3/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "TWTableData.h"
#import "TWNote.h"

@interface TWTableData ()

@property (strong, nonatomic) TWNote *noteManager;

@end
@implementation TWTableData

+ (TWTableData *)sharedInstance {
	//Singleton design pattern
	static TWTableData *_sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedInstance = [[TWTableData alloc] init];
	});
	return _sharedInstance;
}



- (instancetype)init {
	self = [super init];
	if (self) {
		//init some notes
		_noteManager = [[TWNote alloc] init];
		_notes =  [NSMutableArray arrayWithArray: @[
													[TWNote noteWithText:@"Shopping List\r\r1. Cheese\r2. Biscuits\r3. Sausages\r4. IMPORTANT Cash for going out!\r5. -potatoes-\r6. A copy of iOS6 by tutorials\r7. A new iPhone\r8. A present for mum"],
													[TWNote noteWithText:@"Meeting notes\rA long and drawn out meeting, it lasted hours and hours and hours!"],
													[TWNote noteWithText:@"Perfection ... \n\nPerfection is achieved not when there is nothing left to add, but when there is nothing left to take away - Antoine de Saint-Exupery"],
													[TWNote noteWithText:@"Notes on iOS7\nThis is a big change in the UI design, it's going to take a *lot* of getting used to!"],
													[TWNote noteWithText:@"Meeting notes\rA dfferent meeting, just as long and boring"],
													[TWNote noteWithText:@"A collection of thoughts\rWhy do birds sing? Why is the sky blue? Why is it so hard to create good test data?"]]];
	}
	return self;
}
@end
