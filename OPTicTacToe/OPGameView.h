//
//  OPGameView.h
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/28/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OPGamePieceView.h"


@protocol OPGameViewDelegate <NSObject>

@required
- (void)cellTapped:(CGPoint)point;

@end

@interface OPGameView : UIView

- (instancetype)initWithDelegate:(NSObject<OPGameViewDelegate>*)delegate gameCellLength:(int)cells;
- (void)drawValue:(OPGameValue)value atX:(int)x Y:(int)y;

@end
