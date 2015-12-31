//
//  OPGamePiece.m
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/28/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "OPGamePiece.h"

@interface OPGamePiece ()

@end

@implementation OPGamePiece

- (instancetype)initWithValue:(NSString *)value sideLength:(float)sideLength {
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, sideLength, sideLength)];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
        if ([value isEqualToString:@"x"]) {
            imageView.image = [UIImage imageNamed:@"x-mark"];
        } else {
            imageView.image = [UIImage imageNamed:@"o-mark"];
        }
        
        [self addSubview:imageView];
    }
    
    return self;
}

@end
