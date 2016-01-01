//
//  mainViewController.m
//  DynamicFontDownload
//
//  Created by Wen Tan on 12/30/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "ViewController.h"
@import CoreText;

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITableView *fontTable;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (copy, nonatomic) NSArray *fontNames;
@property (copy, nonatomic) NSArray *fontSamples;
//copy property means it cant be mutable object
@property (strong, nonatomic) NSMutableArray *checkMarks;

@end

@implementation ViewController


- (IBAction)downloadButtonPressed:(UIButton *)sender {
	for (int line = 0; line < 6; line++ ) {
		if ([self.checkMarks[line] boolValue]) {
			[self asynchronouslySetFontName:self.fontNames[line]];
		}
	}
}
//async download font from apple
- (void)asynchronouslySetFontName:(NSString *)fontname {
	UIFont *aFont = [UIFont fontWithName:fontname size:12.f];
	//if font is already download
	if (aFont && ([aFont.fontName compare:fontname] == NSOrderedSame || [aFont.familyName compare:fontname] == NSOrderedSame)) {
		//display font sample text
		NSUInteger sampleIndex = [self.fontNames indexOfObject:fontname];
		self.textView.text = [self.fontSamples objectAtIndex:sampleIndex];
		self.textView.font = [UIFont fontWithName:fontname size:24.f];
		return;
	}
	
	//Create a dictionary with the font's PostScript name.
	NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:fontname,kCTFontNameAttribute, nil];
	
	// Create a new font descriptor reference from the attributes dictionary.
	CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrs);
	NSMutableArray *descs = [NSMutableArray arrayWithCapacity:0];
	[descs addObject:(__bridge id)desc];
	//manually release
	CFRelease(desc);
	
	__block BOOL errorDuringDownload = NO;
	// Start processing the font descriptor..
	// This function returns immediately, but can potentially take long time to process.
	// The progress is notified via the callback block of CTFontDescriptorProgressHandler type.
	// See CTFontDescriptor.h for the list of progress states and keys for progressParameter dictionary.
	
	CTFontDescriptorMatchFontDescriptorsWithProgressHandler((__bridge CFArrayRef)descs, NULL, ^bool(CTFontDescriptorMatchingState state, CFDictionaryRef  _Nonnull progressParameter) {
		NSLog( @"state %d - %@", state, progressParameter);
		
		double progressValue = [[(__bridge NSDictionary *)progressParameter
								 objectForKey:(id)kCTFontDescriptorMatchingPercentage] doubleValue];
		if(state == kCTFontDescriptorMatchingWillBeginDownloading) {
			dispatch_async(dispatch_get_main_queue(), ^{
				// show initial progress bar
				self.progress.progress = 0.0;
				self.progress.hidden = NO;
				NSLog(@"0.Begin downloading");
			});
		}
		else if (state == kCTFontDescriptorMatchingDidBegin) {
				dispatch_async(dispatch_get_main_queue(), ^{
					// show indicator
					self.indicator.hidden = NO;
					[self.indicator startAnimating];
					
					self.textView.text = [NSString stringWithFormat:@"字体 %@ 下载中。",fontname];
					self.textView.font = [UIFont systemFontOfSize:14.f];
					NSLog(@"1.Dynamic Downloading begin.");
				});
			}
		else if (state == kCTFontDescriptorMatchingDownloading) {
			dispatch_async(dispatch_get_main_queue(), ^{
				// use progress view to show indicator of progress of downloading
				[self.progress setProgress:progressValue/100.0 animated:YES];
				NSLog(@"2.Downloading %.0f%% complete", progressValue);
			});
		}
		else if (state == kCTFontDescriptorMatchingDidFinishDownloading) {
			dispatch_async(dispatch_get_main_queue(), ^{
				//remove progress bar
				self.progress.hidden = YES;
				NSLog(@"3.Finish downloading");
			});
		}
		else if (state == kCTFontDescriptorMatchingDidFinish) {
			dispatch_async(dispatch_get_main_queue(), ^{
				//remove indicator view
				[self.indicator stopAnimating];
				self.indicator.hidden = YES;
				
				//display sample text
				NSUInteger sampleIndex = [self.fontNames indexOfObject:fontname];
				self.textView.text = [self.fontSamples objectAtIndex:sampleIndex];
				self.textView.font = [UIFont fontWithName:fontname size:24.f];
				
				// Log the font URL in the console
				CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)fontname, 0., NULL);
				CFStringRef fontURL = CTFontCopyAttribute(fontRef, kCTFontURLAttribute);
				NSLog(@"4.%@", (__bridge NSString*)(fontURL));
				CFRelease(fontURL);
				CFRelease(fontRef);
				
				
				if (!errorDuringDownload) {
					//pop up complete alert
					NSLog(@"%@ downloaded", fontname);
				}
			});
		}
		else if (state == kCTFontDescriptorMatchingDidFailWithError) {
			// An error has occurred.Get the error message
			NSError *error = [(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingError];
			if (error) {
				NSLog(@"5.Download error: %@", [error description]);
			}else{
				NSLog(@"5.Error message is not avaliable!");
			}
			//set download flag
			errorDuringDownload = YES;
			dispatch_async(dispatch_get_main_queue(), ^{
				self.progress.hidden = YES;
			});
		}

		return (bool)YES;
	});	
}


#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (![self.checkMarks[indexPath.row] boolValue]) {
		[self asynchronouslySetFontName:self.fontNames[indexPath.row]];
	}
	BOOL isChecked = [self.checkMarks[indexPath.row] boolValue];
	isChecked = !isChecked;
	[self.checkMarks replaceObjectAtIndex:indexPath.row
							   withObject:[NSNumber numberWithBool:isChecked]];
	NSLog(@"%@",self.checkMarks);
	
	// Dismiss keyboard
	if ([self.textView isFirstResponder]) {
		[self.textView resignFirstResponder];
	}
	[self.fontTable reloadData];
}

#pragma mark - UITableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.fontSamples.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString  *myIdentifier = @"Cell";
	
	UITableViewCell *cell = [self.fontTable dequeueReusableCellWithIdentifier:myIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
	}
	
	cell.textLabel.text = self.fontNames[indexPath.row];
	cell.accessoryType = [self.checkMarks[indexPath.row] boolValue] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	
	return cell;
}

#pragma mark - App lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
	self.fontTable.delegate = self;
	self.fontTable.dataSource = self;
	
	self.fontNames = [NSArray arrayWithObjects:
					  @"STXingkai-SC-Light",
					  @"DFWaWaSC-W5",
					  @"FZLTXHK--GBK1-0",
					  @"STLibian-SC-Regular",
					  @"LiHeiPro",
					  @"HiraginoSansGB-W3",
					  nil];
	self.fontSamples = [NSArray arrayWithObjects:
						@"宋体行楷字体示范嘻嘻嘻",
						@"娃娃字体示范哈哈哈",
						@"方字兰亭黑示范嘿嘿嘿",
						@"宋体普通示范吼吼吼",
						@"离黑字体专业版喔喔喔",
						@"新奇不认识字体示范嘤嘤嘤",
						nil];
	self.checkMarks = [[NSMutableArray alloc] init];
	for (int i = 0; i < 6; i++) {
		[self.checkMarks addObject:[NSNumber numberWithBool:false]];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	self.indicator.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
