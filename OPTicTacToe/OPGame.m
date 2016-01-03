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

@property (nonatomic, strong) OPPlayerManager *playerManager;
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

- (BOOL)checkWinWithNewX:(int)x y:(int)y board:(NSArray *)board {
    return [self checkRowWithX:x Y:y board:board] || [self checkColWithX:x Y:y board:board] || [self checkDiagWithX:x Y:y board:board];
}


- (BOOL)checkRowWithX:(int)x Y:(int)y board:(NSArray *)board {
    
    for (int col = 0; col < self.config.gameCellLength; col++) {
        
        // if not same type of mark
        if (board[y][col] != board[y][x]) {
            return NO;
        }
    }
    
    return YES;
}


- (BOOL)checkColWithX:(int)x Y:(int)y board:(NSArray *)board {
    
    for (int row = 0; row < self.config.gameCellLength; row++) {
        
        // if not same type of mark
        if (board[row][x] != board[y][x]) {
            return NO;
        }
    }
    
    return YES;
}


- (BOOL)checkDiagWithX:(int)x Y:(int)y board:(NSArray *)board {
    
    // if new mark isn't on diags
    if ((x + y) % 2 == 1) {
        return NO;
    }
    
    BOOL diag1 = YES;
    BOOL diag2 = YES;
    
    for (int rowCol = 0; rowCol < self.config.gameCellLength; rowCol++) {
        
        // if not same type of mark
        if (board[rowCol][rowCol] != board[y][x] || [board[rowCol][rowCol] isEqual:@(OPGameValueOpen)]) {
            diag1 = NO;
        }
        
        // if not same type of mark
        if (board[rowCol][(self.config.gameCellLength - 1) - rowCol] != board[y][x] ||
                [board[rowCol][(self.config.gameCellLength - 1) - rowCol] isEqual:@(OPGameValueOpen)]) {
            diag2 = NO;
        }
    }
    
    return diag1 || diag2;
}


- (BOOL)checkTieWithNewX:(int)x Y:(int)y board:(NSArray *)board {
    if ([self checkWinWithNewX:x y:y board:board]) {
        return NO;
    }
    
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
    
    BOOL won = [self checkWinWithNewX:x y:y board:self.board];
    if (won) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(gameWon:)]) {
            [self.delegate gameWon:self.playerManager.currentPlayer];
        }
        return;
    }
    
    BOOL tie = [self checkTieWithNewX:x Y:y board:self.board];
    if (tie) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(gameTie)]) {
            [self.delegate gameTie];
        }
        return;
    }
    
    [self.playerManager switchPlayer];
    CGPoint best = [self getNextBestMoveForPlayer:self.playerManager.currentPlayer];
    NSLog(@"next best: row: %d, col: %d", (int)best.x, (int)best.y);
    if (self.delegate && [self.delegate respondsToSelector:@selector(turnChangedToPlayer:)]) {
        [self.delegate turnChangedToPlayer:self.playerManager.currentPlayer];
    }
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


#pragma mark - AI

- (CGPoint)getNextBestMoveForPlayer:(OPGamePlayer)player {
    NSArray *best = [self findMaxForPlayer:player board:self.board level:1];
    
    return CGPointMake(((NSNumber *)best[1]).intValue, ((NSNumber *)best[2]).intValue);
}


- (NSMutableArray *)copyBoard:(NSMutableArray *)board {
    NSMutableArray *newBoard = [@[] mutableCopy];
    for (int i = 0; i < board.count; i++) {
        [newBoard addObject:[[board[i] copy] mutableCopy]];
    }
    
    return newBoard;
}


- (NSArray *)findMaxForPlayer:(OPGamePlayer)player board:(NSMutableArray *)board level:(int)level {
    if (level >= 2) {
        return nil;
    }
    
    NSMutableArray *values = [@[] mutableCopy];
    OPGameValue winningValue = (player == OPGamePlayerOne) ? OPGameValueX : OPGameValueO;
    
    for (int row = 0; row < self.config.gameCellLength; row++) {
        for (int col = 0; col < self.config.gameCellLength; col++) {
            if ([board[row][col] isEqual:@(OPGameValueOpen)]) {
                NSMutableArray *newBoard = [self copyBoard:board];
                newBoard[row][col] = @(winningValue);
                BOOL win = [self checkWinWithNewX:col y:row board:newBoard];
                if (win) {
                    [values addObject:@[@(1.0/level), @(row), @(col)]];
                    continue;
                }
                
                BOOL tie = [self checkTieWithNewX:col Y:row board:newBoard];
                if (tie) {
                    [values addObject:@[@(0), @(row), @(col)]];
                }
                
                // if not win and not tie then evaluate min for new board
                NSArray *minVal = [self findMinForPlayer:player board:newBoard level:(level)];
                if (minVal) {
                    [values addObject:@[minVal[0], @(row), @(col)]];
                } else { // if board unfinished b/c of depth limit, return draw game
                    [values addObject:@[@(0), @(row), @(col)]];
                }
            }
        }
    }
    
    float maxVal = -3;
    int maxRow = 0;
    int maxCol = 0;
    for (int i = 0; i < values.count; i++) {
        NSNumber *val = values[i][0];
        if (val.intValue > maxVal) {
            maxVal = val.floatValue;
            maxRow = ((NSNumber *)values[i][1]).intValue;
            maxCol = ((NSNumber *)values[i][2]).intValue;
        }
    }
    
    // if no suitable moves return empty
    if (maxVal == -3) {
        return nil;
    }
    
    return @[@(maxVal), @(maxRow), @(maxCol)];
}


- (NSArray *)findMinForPlayer:(OPGamePlayer)player board:(NSMutableArray *)board level:(int)level {
    if (level >= 2) {
        return nil;
    }
    NSMutableArray *values = [@[] mutableCopy];
    OPGameValue opponentValue = (player == OPGamePlayerOne) ? OPGameValueO : OPGameValueX;
    
    for (int row = 0; row < self.config.gameCellLength; row++) {
        for (int col = 0; col < self.config.gameCellLength; col++) {
            if ([board[row][col] isEqual:@(OPGameValueOpen)]) {
                NSMutableArray *newBoard = [self copyBoard:board];
                newBoard[row][col] = @(opponentValue);
                BOOL win = [self checkWinWithNewX:col y:row board:newBoard];
                if (win) {
                    [values addObject:@[@(-1.0/level), @(row), @(col)]];
                    continue;
                }
                
                BOOL tie = [self checkTieWithNewX:col Y:row board:newBoard];
                if (tie) {
                    [values addObject:@[@(0), @(row), @(col)]];
                }
                
                // if not win and not tie then evaluate min for new board
                NSArray *maxVal = [self findMaxForPlayer:player board:newBoard level:(level + 1)];
                if (maxVal) {
                    [values addObject:@[maxVal[0], @(row), @(col)]];
                } else { // if board unfinished b/c of depth limit, return draw game
                    [values addObject:@[@(0), @(row), @(col)]];
                }
            }
        }
    }
    
    float minVal = 3;
    int minRow = 0;
    int minCol = 0;
    for (int i = 0; i < values.count; i++) {
        NSNumber *val = values[i][0];
        if (val.intValue < minVal) {
            minVal = val.floatValue;
            minRow = ((NSNumber *)values[i][1]).intValue;
            minCol = ((NSNumber *)values[i][2]).intValue;
        }
    }
    
    // if no suitable moves return empty
    if (minVal == 3) {
        return nil;
    }
    
    return @[@(minVal), @(minRow), @(minCol)];
}


- (NSString *)stringForBoard:(NSMutableArray *)board {
    NSMutableString *total = [@"" mutableCopy];
    
    for (int row = 0; row < board.count; row++) {
        for (int col = 0; col < [board[row] count]; col++) {
            NSString *val = @"x";
            if ([board[row][col] isEqual:@(OPGameValueO)]) {
                val = @"o";
            } else if ([board[row][col] isEqual:@(OPGameValueOpen)]) {
                val = @"*";
            }
            
            [total appendFormat:@"%@ ", val];
        }
        
        [total appendString:@"\n"];
    }
    
    return total;
}


@end
