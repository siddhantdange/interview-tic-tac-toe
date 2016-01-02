//
//  OPGameView.m
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/28/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "OPGameView.h"

#import "OPGame+UI.h"

@interface OPGameView ()

@property (nonatomic, weak) NSObject<OPGameViewDelegate> *delegate;
@property (nonatomic, assign) float sideLength;
@property (nonatomic, assign) int gameCellLength;

@end

@implementation OPGameView

- (instancetype)initWithDelegate:(NSObject<OPGameViewDelegate> *)delegate gameCellLength:(int)cells {
    self = (OPGameView*)[[[NSBundle mainBundle] loadNibNamed:@"OPGameView" owner:self options:nil] objectAtIndex:0];
    
    if (self) {
        self.delegate = delegate;
        self.sideLength = self.bounds.size.height;
        self.gameCellLength = cells;
    }
    
    return self;
}


#pragma mark - Drawing

- (void)drawValue:(OPGameValue)value atX:(int)x Y:(int)y {
    OPGamePieceView *piece = [[OPGamePieceView alloc] initWithValue:value
                                                         sideLength:(self.sideLength/self.gameCellLength) * 0.75];
    
    float centerX = x * (self.sideLength/self.gameCellLength) + (self.sideLength/self.gameCellLength)/2.0f;
    float centerY = y * (self.sideLength/self.gameCellLength) + (self.sideLength/self.gameCellLength)/2.0f;
    
    piece.center = CGPointMake(centerX, centerY);
    [self addSubview:piece];
}


/*
 * Draw grid based on game cell length
 */
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0f);
    CGContextSetStrokeColorWithColor(context, [OPGame beigeColor].CGColor);
    
    float step = self.sideLength/self.gameCellLength;
    
    for (int lineNum = 1; lineNum < self.gameCellLength; lineNum++) {
        
        // horiz
        CGContextMoveToPoint(context, 0.0f, lineNum * step);
        CGContextAddLineToPoint(context, self.sideLength, lineNum * step);
        
        // vert
        CGContextMoveToPoint(context, lineNum * step, 0.0f);
        CGContextAddLineToPoint(context, lineNum * step, self.sideLength);
    }
    
    //finished drawing
    CGContextStrokePath(context);
}


#pragma mark - User Interaction

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (touches.count) {
        UITouch *aTouch = [touches anyObject];
        CGPoint point = [aTouch locationInView:self];
        
        int cellX = (int)point.x/(self.sideLength/self.gameCellLength);
        int cellY = (int)point.y/(self.sideLength/self.gameCellLength);
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(cellTapped:)]) {
            [self.delegate cellTapped:CGPointMake(cellX, cellY)];
        }
    }
}


#pragma mark - UI



@end
