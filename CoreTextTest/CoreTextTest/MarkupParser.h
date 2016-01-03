//
//  MarkupParser.h
//  CoreTextTest
//
//  Created by Wen Tan on 1/2/16.
//  Copyright © 2016 Wen Tan. All rights reserved.
//

@import CoreText;
@import UIKit;
@import Foundation;

@interface MarkupParser : NSObject

@property (copy,   nonatomic) NSString       *aFont;
@property (strong, nonatomic) UIColor        *color;
@property (strong, nonatomic) UIColor        *strokeColor;
@property (assign, nonatomic) float          strokeWidth;
@property (strong, nonatomic) NSMutableArray *images;

- (NSAttributedString *)attrStringFromMarkup:(NSString *)markup;

@end
