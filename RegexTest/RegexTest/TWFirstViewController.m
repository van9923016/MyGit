//
//  TWFirstViewController.m
//  RegexTest
//
//  Created by Wen Tan on 1/9/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

#import "TWFirstViewController.h"


@interface TWFirstViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchBarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editBarButton;
@property (strong, nonatomic) NSString *lastSearchString;
@property (strong, nonatomic) NSString *lastReplacementString;
@property (strong, nonatomic) NSDictionary *lastSearchOptions;


@end

@implementation TWFirstViewController

#pragma mark - View life cycle

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSString *segueIdentifier = segue.identifier;
	if ([segueIdentifier isEqualToString:@"TWSearchTableVCSegue"]){
		UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
		TWSearchTableVC *controller = [navigationController.viewControllers objectAtIndex:0];
		controller.delegate = self;
		controller.searchString = self.lastSearchString;
		controller.searchOptions = self.lastSearchOptions;
		controller.replacementString = self.lastReplacementString;
	}
}


#pragma mark - IBActions

- (IBAction)findInterestingData:(id)sender {
	[self underlineAllDates];
	[self underlineAllTimes];
	[self underlineAllLocations];
}


#pragma mark - RWSearchViewController delegate

- (void)controller:(TWSearchTableVC *)controller didFinishWithSearchString:(NSString *)string options:(NSDictionary *)options replacement:(NSString *)replacement {
	if (![string isEqualToString:self.lastSearchString] ||
		![options isEqual:self.lastSearchOptions] ||
		![replacement isEqualToString:self.lastReplacementString])
	{
		// Keep a reference
		self.lastSearchString = string;
		self.lastReplacementString = replacement;
		self.lastSearchOptions = options;
		
		// Do a clean up of the last time. Remove all the highlights
		[self removeAllHighlightedTextInTextView:self.textView];
		
		if (replacement)
			// Start search and replace
			[self searchAndReplaceText:string withText:replacement inTextView:self.textView options:options];
		else
			// Start the search
			[self searchText:string inTextView:self.textView options:options];
	}
}


#pragma mark - Manage search to find and replace

// Search for a searchString in the given text view with search options
- (void)searchText:(NSString *)searchString inTextView:(UITextView *)textView options:(NSDictionary *)options {
	// TODO: To be implemented from tutorial.
}

// Search for a searchString and replace it with the replacementString in the given text view with search options
- (void)searchAndReplaceText:(NSString *)searchString withText:(NSString *)replacementString inTextView:(UITextView *)textView options:(NSDictionary *)options {
	// TODO: To be implemented from tutorial.
}

#pragma mark - Helper methods
// Create a regular expression with given string and options
- (NSRegularExpression *)regularExpressionWithString:(NSString *)string options:(NSDictionary *)options {
	return nil;
}

// Return range of text in text view that is visible
- (NSRange)visibleRangeOfTextView:(UITextView *)textView {
	CGRect bounds = textView.bounds;
	UITextPosition *start = [textView characterRangeAtPoint:bounds.origin].start;
	UITextPosition *end = [textView characterRangeAtPoint:CGPointMake(CGRectGetMaxX(bounds), CGRectGetMaxY(bounds))].end;
	NSRange visibleRange = NSMakeRange([textView offsetFromPosition:textView.beginningOfDocument toPosition:start],
									   [textView offsetFromPosition:start toPosition:end]);
	return visibleRange;
}

// Compare the two ranges and return YES if range1 contains range2
bool NSRangeContainsRange (NSRange range1, NSRange range2) {
	BOOL contains = NO;
	if (range1.location < range2.location && range1.location+range1.length > range2.length+range2.location) {
		contains = YES;
	}
	return contains;
}

// Remove all highlighted text (the background color) of NSAttributedString
// in a given UITextView
- (void)removeAllHighlightedTextInTextView:(UITextView *)textView {
	NSMutableAttributedString *mutableAttributedString = self.textView.attributedText.mutableCopy;
	NSRange wholeRange = NSMakeRange(0, mutableAttributedString.length);
	[mutableAttributedString addAttribute:NSBackgroundColorAttributeName value:[UIColor clearColor] range:wholeRange];
	textView.attributedText = mutableAttributedString.copy;
}


#pragma mark - Find interesting data

- (void)underlineAllDates {
	// TODO: To be implemented from tutorial.
}

- (void)underlineAllTimes {
	// TODO: To be implemented from tutorial.
}

- (void)underlineAllLocations {
	// TODO: To be implemented from tutorial.
}

// Matches is an array with object of type NSTextCheckingResult
- (void)highlightMatches:(NSArray *)matches {
	__block NSMutableAttributedString *mutableAttributedString = self.textView.attributedText.mutableCopy;
	
	[matches enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		
		if ([obj isKindOfClass:[NSTextCheckingResult class]]) {
			NSTextCheckingResult *match = (NSTextCheckingResult *)obj;
			NSRange matchRange = match.range;
			[mutableAttributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:matchRange];
			[mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:matchRange];
		}
	}];
	
	self.textView.attributedText = mutableAttributedString.copy;
}

@end
