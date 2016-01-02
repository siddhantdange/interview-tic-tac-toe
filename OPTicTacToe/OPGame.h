//
//  OPGame.h
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/28/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

#import "OPPlayerConstants.h"
#import "OPPlayerManager.h"


@class OPGameConfig;
@class OPGameView;

@protocol OPGameDelegate <NSObject>

@required
- (void)gameWon:(OPGamePlayer)player;
- (void)gameTie;
- (void)turnChangedToPlayer:(OPGamePlayer)player;

@end

@interface OPGame : NSObject

- (instancetype)initWithDelegate:(NSObject<OPGameDelegate> *)delegate config:(OPGameConfig *)config;

@property (nonatomic, strong) OPGameView *view;

@end
