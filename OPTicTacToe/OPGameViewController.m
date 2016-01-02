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
#import "OPGame+UI.h"
#import "OPPlayerConstants.h"

@interface OPGameViewController () <OPGameDelegate>

@property (weak, nonatomic) IBOutlet UILabel *playerStateLabel;
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


- (void)viewDidAppear:(BOOL)animated {
    [[UINavigationBar appearance] setBarTintColor:[OPGame greenColor]];
    [UINavigationBar appearance].translucent = NO;
    
    self.navigationItem.leftBarButtonItem = [self endGameButtonItem];
    
    self.game.view.alpha = 0.0f;

    [UIView animateWithDuration:0.2f animations:^{
        self.navigationController.navigationBarHidden = NO;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5f animations:^{
            [self.view addSubview:self.game.view];
            self.game.view.alpha = 1.0f;
        }];;
    }];
}


- (void)viewWillDisappear:(BOOL)animated {
    [UIView animateWithDuration:0.2f animations:^{
        self.navigationController.navigationBarHidden = YES;
        self.navigationItem.hidesBackButton = YES;
    }];
}


- (void)popToMainScreen {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - OPGameDelegate

- (void)gameWon:(OPGamePlayer)player {
    NSString *playerWon = @"";
    if (player == OPGamePlayerOne) {
        playerWon = @"Player 1";
    } else {
        playerWon = @"Player 2";
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


- (void)turnChangedToPlayer:(OPGamePlayer)player {
    switch (player) {
        case OPGamePlayerOne:
            self.playerStateLabel.text = @"PLAYER 1 GO";
            break;
        case OPGamePlayerTwo:
            self.playerStateLabel.text = @"PLAYER 2 GO";
            break;
        default:
            break;
    }
}


#pragma mark - Getters and Setters

- (OPGame *)game {
    if (!_game) {
        _game = [[OPGame alloc] initWithDelegate:self config:self.config];
        CGRect gameFrame = _game.view.frame;
        float midX = ([UIScreen mainScreen].bounds.size.width - gameFrame.size.width)/2.0f;
        float midY = ([UIScreen mainScreen].bounds.size.height - gameFrame.size.height)/2.0f;
        float navigationBarHeight = 40.0f;
        midY -= navigationBarHeight;
        gameFrame.origin = CGPointMake(midX, midY);
        _game.view.frame = gameFrame;
    }
    
    return _game;
}


- (UIBarButtonItem *)endGameButtonItem {
    UIButton *endGameButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [endGameButton setBackgroundImage:[UIImage imageNamed:@"endgame.png"] forState:UIControlStateNormal];
    [endGameButton addTarget:self action:@selector(popToMainScreen) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:endGameButton];
}

@end
