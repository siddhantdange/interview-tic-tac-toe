//
//  OPGame+AI.h
//  OPTicTacToe
//
//  Created by Siddhant Dange on 1/2/16.
//  Copyright © 2016 Siddhant Dange. All rights reserved.
//

#import "OPGame.h"

typedef NS_ENUM(NSInteger, OPGameAILevel) {
    OPGameAILevelEasy,
    OPGameAILevelHard
};

@interface OPGame (AI)

- (CGPoint)getNextBestMoveForPlayer:(OPGamePlayer)player difficulty:(OPGameAILevel)difficulty;

@end
