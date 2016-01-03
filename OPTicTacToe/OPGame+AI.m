//
//  OPGame+AI.m
//  OPTicTacToe
//
//  Created by Siddhant Dange on 1/2/16.
//  Copyright © 2016 Siddhant Dange. All rights reserved.
//

#import "OPGame+AI.h"

#import "OPGameConfig.h"

@interface OPGame ()

- (BOOL)checkWinWithNewX:(int)x y:(int)y board:(NSArray *)board;
- (BOOL)checkTieWithNewX:(int)x Y:(int)y board:(NSArray *)board;

@end

@implementation OPGame (AI)

- (CGPoint)getNextBestMoveForPlayer:(OPGamePlayer)player difficulty:(OPGameAILevel)difficulty {
    int maxLevel = (difficulty == OPGameAILevelEasy) ? 2 : 3;
    
    NSArray *best = [self findMaxForPlayer:player board:self.board level:1 maxLevel:maxLevel currentMin:INFINITY];
    
    return CGPointMake(((NSNumber *)best[1]).intValue, ((NSNumber *)best[2]).intValue);
}


- (NSMutableArray *)copyBoard:(NSMutableArray *)board {
    NSMutableArray *newBoard = [@[] mutableCopy];
    for (int i = 0; i < board.count; i++) {
        [newBoard addObject:[[board[i] copy] mutableCopy]];
    }
    
    return newBoard;
}


- (NSArray *)findMaxForPlayer:(OPGamePlayer)player board:(NSMutableArray *)board level:(int)level maxLevel:(int)maxLevel currentMin:(float)currentMin {
    if (level >= 3) {
        return nil;
    }
    
    OPGameValue winningValue = (player == OPGamePlayerOne) ? OPGameValueX : OPGameValueO;
    
    float maxVal = -INFINITY;
    int maxRow = 0;
    int maxCol = 0;
    
    BOOL alphaBetaPrune = NO;
    for (int row = 0; row < self.config.gameCellLength; row++) {
        for (int col = 0; col < self.config.gameCellLength; col++) {
            if ([board[row][col] isEqual:@(OPGameValueOpen)]) {
                NSMutableArray *newBoard = [self copyBoard:board];
                newBoard[row][col] = @(winningValue);
                BOOL win = [self checkWinWithNewX:col y:row board:newBoard];
                if (win) {
                    if ((1.0/level) > maxVal) {
                        maxVal = (1.0/level);
                        maxRow = row;
                        maxCol = col;
                    }
                    continue;
                }
                
                BOOL tie = [self checkTieWithNewX:col Y:row board:newBoard];
                if (tie) {
                    if (0 > maxVal) {
                        maxVal = 0;
                        maxRow = row;
                        maxCol = col;
                    }
                    continue;
                }
                
                // alpha beta prune
                if (maxVal > currentMin) {
                    alphaBetaPrune = YES;
                    break;
                }
                
                // if not win and not tie then evaluate min for new board
                NSArray *minVal = [self findMinForPlayer:player board:newBoard level:(level) maxLevel:maxLevel currentMax:maxVal];
                float val = 0.0f;
                if (minVal) {
                    val = ((NSNumber *)minVal[0]).floatValue;
                }
                
                if (val > maxVal) {
                    maxVal = val;
                    maxRow = row;
                    maxCol = col;
                }
            }
        }
        
        if (alphaBetaPrune) {
            break;
        }
    }
    
    // if no suitable moves return empty
    if (maxVal == -INFINITY) {
        return nil;
    }
    
    return @[@(maxVal), @(maxRow), @(maxCol)];
}


- (NSArray *)findMinForPlayer:(OPGamePlayer)player board:(NSMutableArray *)board level:(int)level maxLevel:(int)maxLevel currentMax:(float)currentMax {
    if (level >= 3) {
        return nil;
    }
    OPGameValue opponentValue = (player == OPGamePlayerOne) ? OPGameValueO : OPGameValueX;
    
    float minVal = INFINITY;
    int minRow = 0;
    int minCol = 0;
    
    BOOL alphaBetaPrune = NO;
    for (int row = 0; row < self.config.gameCellLength; row++) {
        for (int col = 0; col < self.config.gameCellLength; col++) {
            if ([board[row][col] isEqual:@(OPGameValueOpen)]) {
                NSMutableArray *newBoard = [self copyBoard:board];
                newBoard[row][col] = @(opponentValue);
                BOOL win = [self checkWinWithNewX:col y:row board:newBoard];
                if (win) {
                    if ((-1.0/level) < minVal) {
                        minVal = (-1.0/level);
                        minRow = row;
                        minCol = col;
                    }
                    continue;
                }
                
                BOOL tie = [self checkTieWithNewX:col Y:row board:newBoard];
                if (tie) {
                    if (0 < minVal) {
                        minVal = 0;
                        minRow = row;
                        minCol = col;
                    }
                    continue;
                }
                
                // alpha beta pruning
                if (minVal < currentMax) {
                    alphaBetaPrune = YES;
                    break;
                }
                
                // if not win and not tie then evaluate min for new board
                NSArray *maxVal = [self findMaxForPlayer:player board:newBoard level:(level + 1) maxLevel:maxLevel currentMin:minVal];
                float val = 0.0f;
                if (maxVal) {
                    val = ((NSNumber *)maxVal[0]).floatValue;
                }
                
                if (val < minVal) {
                    minVal = val;
                    minRow = row;
                    minCol = col;
                }
            }
        }
        
        if (alphaBetaPrune) {
            break;
        }
    }
    
    // if no suitable moves return empty
    if (minVal == INFINITY) {
        return nil;
    }
    
    return @[@(minVal), @(minRow), @(minCol)];
}


#pragma mark - Debug

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
