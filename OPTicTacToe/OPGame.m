//
//  OPGame.m
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/28/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "OPGame.h"

#import "OPGameView.h"
#import "OPGameConfig.h"

@interface OPGame () <OPGameViewDelegate>

@property (nonatomic, strong) NSMutableArray *board;
@property (nonatomic, strong) OPPlayerManager *playerManager;
@property (nonatomic, strong) OPGameConfig *config;
@property (nonatomic, weak) NSObject<OPGameDelegate> *delegate;

@end

@implementation OPGame

- (instancetype)initWithDelegate:(NSObject<OPGameDelegate> *)delegate config:(OPGameConfig *)config {
    self = [super init];
    if (self) {
        
        // init nxn board
        self.board = [@[] mutableCopy];

        for (int i = 0; i < config.gameCellLength; i++) {
            NSMutableArray *row = [NSMutableArray array];
            for (int j = 0; j < config.gameCellLength; j++) {
                [row addObject:@(OPGameValueOpen)];
            }
            [self.board addObject:row];
        }
        
        self.playerManager = [[OPPlayerManager alloc] init];
        self.config = config;
        self.delegate = delegate;
    }
    
    return self;
}


#pragma mark - Board Check

- (BOOL)checkWinWithNewX:(int)x y:(int)y {
    return [self checkRowWithX:x Y:y] || [self checkColWithX:x Y:y] || [self checkDiagWithX:x Y:y];
}


- (BOOL)checkRowWithX:(int)x Y:(int)y {
    
    for (int col = 0; col < self.config.gameCellLength; col++) {
        
        // if not same type of mark
        if (self.board[y][col] != self.board[y][x]) {
            return NO;
        }
    }
    
    return YES;
}


- (BOOL)checkColWithX:(int)x Y:(int)y {
    
    for (int row = 0; row < self.config.gameCellLength; row++) {
        
        // if not same type of mark
        if (self.board[row][x] != self.board[y][x]) {
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
    
    BOOL diag1 = YES;
    BOOL diag2 = YES;
    
    for (int rowCol = 0; rowCol < self.config.gameCellLength; rowCol++) {
        
        // if not same type of mark
        if (self.board[rowCol][rowCol] != self.board[y][x]) {
            diag1 = NO;
        }
        
        // if not same type of mark
        if (self.board[rowCol][(self.config.gameCellLength - 1) - rowCol] != self.board[y][x]) {
            diag2 = NO;
        }
    }
    
    return diag1 || diag2;
}


- (BOOL)checkTieWithNewX:(int)x Y:(int)y {
    for (int row = 0; row < self.config.gameCellLength; row++) {
        for (int col = 0; col < self.config.gameCellLength; col++) {
            if ([self.board[row][col] isEqual:@(OPGameValueOpen)]) {
                return NO;
            }
        }
    }
    
    return YES;
}


- (BOOL)checkCellValidX:(int)x Y:(int)y {
    return [self.board[y][x] isEqual:@(OPGameValueOpen)];
}


#pragma mark - GamePlay

- (void)updateGameWithX:(int)x Y:(int)y value:(OPGameValue)value {
    self.board[y][x] = @(value);
    
    BOOL won = [self checkWinWithNewX:x y:y];
    if (won) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(gameWon:)]) {
            [self.delegate gameWon:self.playerManager.currentPlayer];
        }
        return;
    }
    
    BOOL tie = [self checkTieWithNewX:x Y:y];
    if (tie) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(gameTie)]) {
            [self.delegate gameTie];
        }
        return;
    }
    
    [self.playerManager switchPlayer];
}


#pragma mark - OPGameViewDelegate

- (void)cellTapped:(CGPoint)point {

    if (![self checkCellValidX:point.x Y:point.y]) {
        return;
    }

    OPGameValue value;
    if (self.playerManager.currentPlayer == OPGamePlayerOne) {
        value = OPGameValueX;
    } else {
        value = OPGameValueO;
    }
    
    [self.view drawValue:value atX:point.x Y:point.y];
    [self updateGameWithX:point.x Y:point.y value:value];
}


#pragma mark - Getters and Setters

-(UIView *)view {
    if (!_view) {
        _view = [[OPGameView alloc] initWithDelegate:self gameCellLength:self.config.gameCellLength];
    }
    
    return _view;
}

@end
