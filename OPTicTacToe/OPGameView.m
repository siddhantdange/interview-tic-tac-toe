//
//  OPGameView.m
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/28/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "OPGameView.h"

#import "OPGamePiece.h"

@implementation OPGameView

- (instancetype)init {
    self = (OPGameView*)[[[NSBundle mainBundle] loadNibNamed:@"OPGameView" owner:self options:nil] objectAtIndex:0];
    return self;
}


- (void)drawValue:(NSString *)value atX:(int)x Y:(int)y {
    OPGamePiece *piece = [[OPGamePiece alloc] initWithValue:value];
    
    float centerX = x * 100 + 50;
    float centerY = y * 100 + 50;
    
    piece.center = CGPointMake(centerX, centerY);
    [self addSubview:piece];
}

@end
