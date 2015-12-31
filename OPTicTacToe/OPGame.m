//
//  OPGame.m
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/28/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "OPGame.h"

#import "OPGameView.h"


@interface OPGame () <OPGameViewDelegate>

@property (nonatomic, strong) NSMutableArray *board;
@property (nonatomic, strong) OPPlayerManager *playerManager;
@property (nonatomic, weak) NSObject<OPGameDelegate> *delegate;

@end

@implementation OPGame

- (instancetype)initWithDelegate:(NSObject<OPGameDelegate> *)delegate {
    self = [super init];
    if (self) {
        
        // init 3x3 board
        self.board = [@[] mutableCopy];

        for (int i = 0; i < 3; i++) {
            [self.board addObject:[@[@"1", @"1", @"1"] mutableCopy]];
        }
        
        self.playerManager = [[OPPlayerManager alloc] init];
        self.delegate = delegate;
    }
    
    return self;
}


#pragma mark - Board Check

- (BOOL)checkWinWithNewX:(int)x y:(int)y {
    return [self checkRowWithX:x Y:y] || [self checkColWithX:x Y:y] || [self checkDiagWithX:x Y:y];
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
    
    BOOL diag1 = YES;
    BOOL diag2 = YES;
    
    for (int rowCol = 0; rowCol < 3; rowCol++) {
        
        // if not same type of mark
        if (self.board[rowCol][rowCol] != mark) {
            diag1 = NO;
        }
        
        // if not same type of mark
        if (self.board[rowCol][2 - rowCol] != mark) {
            diag2 = NO;
        }
    }
    
    return diag1 || diag2;
}


- (BOOL)checkTieWithNewX:(int)x Y:(int)y {
    for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 3; col++) {
            if ([self.board[row][col] isEqualToString:@"1"]) {
                return NO;
            }
        }
    }
    
    return YES;
}


#pragma mark - GamePlay

- (void)updateGameWithX:(int)x Y:(int)y value:(NSString *)value {
    self.board[y][x] = value;
    
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
    NSString *value = @"";
    if (self.playerManager.currentPlayer == OPGamePlayerOne) {
        value = @"x";
    } else {
        value = @"o";
    }
    
    [self.view drawValue:value atX:point.x Y:point.y];
    [self updateGameWithX:point.x Y:point.y value:value];
}


#pragma mark - Getters and Setters

-(UIView *)view {
    if (!_view) {
        _view = [[OPGameView alloc] initWithDelegate:self];
    }
    
    return _view;
}

@end
