//
//  OPGamePiece.m
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/28/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "OPGamePieceView.h"


@implementation OPGamePieceView

- (instancetype)initWithValue:(OPGameValue)value sideLength:(float)sideLength {
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, sideLength, sideLength)];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
        switch (value) {
            case OPGameValueX:
                imageView.image = [UIImage imageNamed:@"x-mark"];
                break;
            case OPGameValueO:
                imageView.image = [UIImage imageNamed:@"o-mark"];
                
            default:
                break;
        }
        
        [self addSubview:imageView];
    }
    
    return self;
}

@end
