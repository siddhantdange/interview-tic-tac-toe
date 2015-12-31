//
//  OPGameConfig.h
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/30/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OPGameConfig : NSObject

- (instancetype)initWithGameCellLength:(int)gameCellLength;
- (int)gameCellLength;

@end
