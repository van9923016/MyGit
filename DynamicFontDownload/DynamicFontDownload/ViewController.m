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

//async download font from apple
- (void)asyncchronouslySetFontName:(NSString *)fontname {
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
	NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:fontname,kCTFontAttributeName, nil];
	
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
		double progressValue = [[(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingPercentage] doubleValue];
		
		switch (state) {
			case kCTFontDescriptorMatchingDidBegin:
				//TODO:
				break;
			case kCTFontDescriptorMatchingDidFinish:
				//TODO:
				break;
			case kCTFontDescriptorMatchingWillBeginDownloading:
				//TODO:
				break;
			case kCTFontDescriptorMatchingDidFinishDownloading:
				//TODO:
				break;
			case kCTFontDescriptorMatchingDidFailWithError:
				//TODO:
				break;
			default:
				//TODO:
				NSLog(@"Nothing special~~");
				break;
		}
		return YES;
	});
	
}


#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	BOOL isChecked = [self.checkMarks[indexPath.row] boolValue];
	[self.checkMarks replaceObjectAtIndex:indexPath.row
							   withObject:[NSNumber numberWithBool:!isChecked]];
	NSLog(@"%@",self.checkMarks);
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
	
	//TODO: set up cell
	cell.textLabel.text = self.fontNames[indexPath.row];
	BOOL isCheck = [self.checkMarks[indexPath.row] boolValue] ;
	NSLog(@"%d",isCheck);
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
