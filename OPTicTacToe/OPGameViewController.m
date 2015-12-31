//
//  OPGameViewController.m
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/28/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "OPGameViewController.h"

#import "OPGame.h"
#import "OPGameView.h"
#import "OPPlayerManager.h"

@interface OPGameViewController ()

@property (nonatomic, strong) OPPlayerManager *playerManager;
@property (nonatomic, strong) OPGame *game;

@end

@implementation OPGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.playerManager = [[OPPlayerManager alloc] init];
    [self.view addSubview:self.game.view];
}


#pragma mark - Getters and Setters

- (OPGame *)game {
    if (!_game) {
        _game = [[OPGame alloc] init];
        CGRect gameFrame = _game.view.frame;
        float midX = ([UIScreen mainScreen].bounds.size.width - gameFrame.size.width)/2.0f;
        float midY = ([UIScreen mainScreen].bounds.size.height - gameFrame.size.height)/2.0f;
        gameFrame.origin = CGPointMake(midX, midY);
        _game.view.frame = gameFrame;
    }
    
    return _game;
}

@end
