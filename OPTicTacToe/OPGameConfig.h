//
//  OPGameConfig.h
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/30/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, OPGameMode) {
    OPGameModeAI,
    OPGameModeHuman
};

typedef NS_ENUM(NSInteger, OPGameAILevel) {
    OPGameAILevelEasy,
    OPGameAILevelHard,
    OPGameAILevelNone
};

typedef NS_ENUM(NSInteger, OPGameValue) {
    OPGameValueOpen,
    OPGameValueX,
    OPGameValueO
};

@interface OPGameConfig : NSObject

- (instancetype)initWithGameCellLength:(int)gameCellLength gameMode:(OPGameMode)gameMode gameLevel:(OPGameAILevel)AILevel;
- (int)gameCellLength;
- (OPGameMode)gameMode;
- (OPGameAILevel)AILevel;

@end
