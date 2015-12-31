//
//  OPGameViewController.m
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/28/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "OPGameViewController.h"

#import "OPGame.h"
#import "OPGameConfig.h"
#import "OPGameView.h"
#import "OPPlayerConstants.h"

@interface OPGameViewController () <OPGameDelegate>

@property (nonatomic, strong) OPGame *game;
@property (nonatomic, strong) OPGameConfig *config;

@end

@implementation OPGameViewController

#pragma mark - LifeCycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil gameConfig:(OPGameConfig *)config {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.config = config;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.game.view];
}


- (void)popToMainScreen {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - OPGameDelegate

- (void)gameWon:(OPGamePlayer)player {
    NSString *playerWon = @"";
    if (player == OPGamePlayerOne) {
        playerWon = @"Player One";
    } else {
        playerWon = @"Player Two";
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Game Over!"
                                                                   message:[NSString stringWithFormat:@"%@ won!", playerWon]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Good Game!"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       [self popToMainScreen];
    }];
    
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)gameTie {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Game Tie!"
                                                                   message:@"Both Players Have Tied!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Good Game!"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       [self popToMainScreen];
                                                   }];
    
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Getters and Setters

- (OPGame *)game {
    if (!_game) {
        _game = [[OPGame alloc] initWithDelegate:self config:self.config];
        CGRect gameFrame = _game.view.frame;
        float midX = ([UIScreen mainScreen].bounds.size.width - gameFrame.size.width)/2.0f;
        float midY = ([UIScreen mainScreen].bounds.size.height - gameFrame.size.height)/2.0f;
        gameFrame.origin = CGPointMake(midX, midY);
        _game.view.frame = gameFrame;
    }
    
    return _game;
}

@end
