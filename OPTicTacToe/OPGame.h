//
//  OPGame.h
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/28/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

#import "OPGameView.h"
#import "OPPlayerConstants.h"
#import "OPPlayerManager.h"

@protocol OPGameDelegate <NSObject>

@required
- (void)gameWon:(OPGamePlayer)player;
- (void)gameTie;

@end

@interface OPGame : NSObject

- (instancetype)initWithDelegate:(NSObject<OPGameDelegate>*)delegate;

@property (nonatomic, strong) OPGameView *view;

@end
