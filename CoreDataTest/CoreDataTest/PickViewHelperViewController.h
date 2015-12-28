//
//  PickViewHelperViewController.h
//  CoreDataTest
//
//  Created by Wen Tan on 12/28/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickViewHelperViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

- (void)setArray:(NSArray *)incoming;
- (void) addItemToArray:(NSObject *)thing;
- (NSObject *)getItemFromArray:(NSUInteger)index;

@end
