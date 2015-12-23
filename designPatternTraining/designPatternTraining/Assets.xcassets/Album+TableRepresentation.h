//
//  Album+TableRepresentation.h
//  designPatternTraining
//
//  Created by Wen Tan on 12/23/15.
//  Copyright © 2015 Wen Tan. All rights reserved.
//

#import "Album.h"

@interface Album (TableRepresentation)

//extended album model value to key value pairs dictionary using in table view
- (NSDictionary *)tr_tableRepresentation;

@end
