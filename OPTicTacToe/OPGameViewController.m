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

@property (nonatomic, strong) OPGameView *gameView;
@property (nonatomic, strong) OPPlayerManager *playerManager;
@property (nonatomic, strong) OPGame *game;

@end

@implementation OPGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.game = [[OPGame alloc] init];
    self.playerManager = [[OPPlayerManager alloc] init];
    [self.view addSubview:self.gameView];
}


#pragma mark - Getters and Setters

- (OPGameView *)gameView {
    if (!_gameView) {
        _gameView = [[OPGameView alloc] init];
        CGRect gameFrame = _gameView.frame;
        float midX = ([UIScreen mainScreen].bounds.size.width - gameFrame.size.width)/2.0f;
        gameFrame.origin = CGPointMake(midX, 100.0f);
        _gameView.frame = gameFrame;
    }
    
    return _gameView;
}

@end
