//
//  OPGame.m
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/28/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "OPGame.h"

@interface OPGame ()

@property (nonatomic, strong) NSMutableArray *board;

@end

@implementation OPGame

- (instancetype)init {
    self = [super init];
    if (self) {
        self.board = [@[] mutableCopy];

        for (int i = 0; i < 3; i++) {
            [self.board addObject:[@[@"1", @"1", @"1"] mutableCopy]];
        }
    }
    
    return self;
}


#pragma mark - Board Check

- (void)checkBoardWithNewX:(int)x y:(int)y {
    BOOL won = [self checkRowWithX:x y:y] || [self checkColWithX:x y:y] || [self checkDiagWithX:x y:y];
    if (won) {
        // win callback
    }
}


- (BOOL)checkRowWithX:(int)x y:(int)y {
    NSString *mark = self.board[y][x];
    
    for (int col = 0; col < 3; col++) {
        
        // if not same type of mark
        if (self.board[y][col] != mark) {
            return NO;
        }
    }
    
    return YES;
}


- (BOOL)checkColWithX:(int)x y:(int)y {
    NSString *mark = self.board[y][x];
    
    for (int row = 0; row < 3; row++) {
        
        // if not same type of mark
        if (self.board[row][x] != mark) {
            return NO;
        }
    }
    
    return YES;
}


- (BOOL)checkDiagWithX:(int)x y:(int)y {
    
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

@end
