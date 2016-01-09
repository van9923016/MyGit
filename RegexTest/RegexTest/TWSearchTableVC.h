//
//  TWSearchTableVC.h
//  RegexTest
//
//  Created by Wen Tan on 1/9/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import <UIKit/UIKit.h>

// Search options keys
// The values of these keys are BOOL
#define kTWSearchCaseSensitiveKey    @"TWSearchCaseSensitiveKey"
#define kTWSearchWholeWordsKey       @"TWSearchWholeWordsKey"
#define kTWReplacementKey            @"TWReplacementKey"

@protocol TWSearchTableVCDelegate;

@interface TWSearchTableVC : UITableViewController

@property (weak, nonatomic) id <TWSearchTableVCDelegate> delegate;

// If you start off with a default or previous
// search string, pass it in
@property (strong, nonatomic) NSString *searchString;

@property (strong, nonatomic) NSDictionary *searchOptions;

@property (strong, nonatomic) NSString *replacementString;

@end


@protocol TWSearchTableVCDelegate <NSObject>

// Return self, the search string and the search options and replacement string (if any)
// If there is no replacement string, it will be nil.
- (void)controller:(TWSearchTableVC *)controller didFinishWithSearchString:(NSString *)string options:(NSDictionary *)options replacement:(NSString *)replacement;

@end
