//
//  OPGameConfig.h
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/30/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, OPGameValue) {
    OPGameValueOpen,
    OPGameValueX,
    OPGameValueO
};

@interface OPGameConfig : NSObject

- (instancetype)initWithGameCellLength:(int)gameCellLength;
- (int)gameCellLength;

@end
