//
//  OPGame.m
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/28/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "OPGame.h"

#import "OPGameView.h"
#import "OPPlayerManager.h"


@interface OPGame () <OPGameViewDelegate>

@property (nonatomic, strong) NSMutableArray *board;
@property (nonatomic, strong) OPPlayerManager *playerManager;

@end

@implementation OPGame

- (instancetype)init {
    self = [super init];
    if (self) {
        
        // init 3x3 board
        self.board = [@[] mutableCopy];

        for (int i = 0; i < 3; i++) {
            [self.board addObject:[@[@"1", @"1", @"1"] mutableCopy]];
        }
        
        self.playerManager = [[OPPlayerManager alloc] init];
    }
    
    return self;
}


#pragma mark - Board Check

- (void)checkBoardWithNewX:(int)x y:(int)y {
    BOOL won = [self checkRowWithX:x Y:y] || [self checkColWithX:x Y:y] || [self checkDiagWithX:x Y:y];
    if (won) {
        // win callback
    }
}


- (BOOL)checkRowWithX:(int)x Y:(int)y {
    NSString *mark = self.board[y][x];
    
    for (int col = 0; col < 3; col++) {
        
        // if not same type of mark
        if (self.board[y][col] != mark) {
            return NO;
        }
    }
    
    return YES;
}


- (BOOL)checkColWithX:(int)x Y:(int)y {
    NSString *mark = self.board[y][x];
    
    for (int row = 0; row < 3; row++) {
        
        // if not same type of mark
        if (self.board[row][x] != mark) {
            return NO;
        }
    }
    
    return YES;
}


- (BOOL)checkDiagWithX:(int)x Y:(int)y {
    
    // if new mark isn't on diags
    if ((x + y) % 2 == 1) {
        return NO;
    }
    
    NSString *mark = self.board[y][x];
    
    for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 3; col++) {
            
            // if on diag
            if ((row + col) % 2 == 0) {
                
                // if not same type of mark
                if (self.board[row][x] != mark) {
                    return NO;
                }
            }
        }
    }
    
    return YES;
}


#pragma mark - OPGameViewDelegate

- (void)cellTapped:(CGPoint)point {
    NSString *value = @"";
    if (self.playerManager.currentPlayer == OPGamePlayerOne) {
        value = @"x";
    } else {
        value = @"o";
    }
    
    [self.view drawValue:value atX:point.x Y:point.y];
    [self.playerManager switchPlayer];
}


#pragma mark - Getters and Setters

-(UIView *)view {
    if (!_view) {
        _view = [[OPGameView alloc] initWithDelegate:self];
    }
    
    return _view;
}

@end
