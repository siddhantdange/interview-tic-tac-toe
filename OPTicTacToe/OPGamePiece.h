//
//  OPGamePiece.h
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/28/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OPGameConfig.h"


@interface OPGamePiece : UIView

- (instancetype)initWithValue:(OPGameValue)value sideLength:(float)sideLength;

@end
