//
//  OPGameConfig.m
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/30/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "OPGameConfig.h"


@interface OPGameConfig ()

@property (nonatomic, assign) int gameCellLength;
@property (nonatomic, assign) OPGameMode gameMode;
@property (nonatomic, assign) OPGameAILevel AILevel;

@end

@implementation OPGameConfig

- (instancetype)initWithGameCellLength:(int)gameCellLength gameMode:(OPGameMode)gameMode gameLevel:(OPGameAILevel)AILevel {
    self = [super init];
    if (self) {
        self.gameCellLength = gameCellLength;
        self.gameMode = gameMode;
        self.AILevel = AILevel;
    }
    
    return self;
}

@end
