//
//  OPGameView.m
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/28/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "OPGameView.h"

#import "OPGamePiece.h"

@interface OPGameView ()

@property (nonatomic, weak) NSObject<OPGameViewDelegate> *delegate;

@end

@implementation OPGameView

- (instancetype)initWithDelegate:(NSObject<OPGameViewDelegate> *)delegate {
    self = (OPGameView*)[[[NSBundle mainBundle] loadNibNamed:@"OPGameView" owner:self options:nil] objectAtIndex:0];
    
    if (self) {
        self.delegate = delegate;
    }
    
    return self;
}


#pragma mark - Drawing

- (void)drawValue:(NSString *)value atX:(int)x Y:(int)y {
    OPGamePiece *piece = [[OPGamePiece alloc] initWithValue:value];
    
    float centerX = x * 100 + 50;
    float centerY = y * 100 + 50;
    
    piece.center = CGPointMake(centerX, centerY);
    [self addSubview:piece];
}


#pragma mark - User Interaction

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (touches.count) {
        UITouch *aTouch = [touches anyObject];
        CGPoint point = [aTouch locationInView:self];
        
        int cellX = (int)point.x/100;
        int cellY = (int)point.y/100;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(cellTapped:)]) {
            [self.delegate cellTapped:CGPointMake(cellX, cellY)];
        }
    }
}

@end
