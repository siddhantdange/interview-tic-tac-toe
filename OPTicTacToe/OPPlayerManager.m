//
//  OPPlayerManager.m
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/28/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "OPPlayerManager.h"

@interface OPPlayerManager ()


@end

@implementation OPPlayerManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.currentPlayer = OPGamePlayerOne;
    }
    
    return self;
}


- (void)switchPlayer {
    if (self.currentPlayer == OPGamePlayerOne) {
        self.currentPlayer = OPGamePlayerTwo;
    } else {
        self.currentPlayer = OPGamePlayerOne;
    }
}

@end
