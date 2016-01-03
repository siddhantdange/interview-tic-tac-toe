//
//  ViewController.m
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/27/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "OPMenuViewController.h"

#import "OPGameViewController.h"
#import "OPGameConfig.h"


@interface OPMenuViewController () 

@property (weak, nonatomic) IBOutlet UILabel *cellNumLabel1;
@property (weak, nonatomic) IBOutlet UILabel *cellNumLabel2;
@property (weak, nonatomic) IBOutlet UISlider *cellNumSlider;

@end

@implementation OPMenuViewController


#pragma mark - Lifecycle

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    self.navigationItem.hidesBackButton = YES;
}


#pragma mark - Events

- (IBAction)cellNumSliderValueChanged:(id)sender {
    int cellNum = (int)lroundf(self.cellNumSlider.value);
    [self.cellNumLabel1 setText:[NSString stringWithFormat:@"%d", cellNum]];
    [self.cellNumLabel2 setText:[NSString stringWithFormat:@"%d", cellNum]];
    [self.cellNumSlider setValue:cellNum animated:YES];
}


- (IBAction)playPressedAIGameEasy:(id)sender {
    [self startGameWithGameMode:OPGameModeAI AIDifficulty:OPGameAILevelEasy];
}


- (IBAction)playPressedAIGameHard:(id)sender {
    [self startGameWithGameMode:OPGameModeAI AIDifficulty:OPGameAILevelHard];
}


- (IBAction)playPressedGameHuman:(id)sender {
    [self startGameWithGameMode:OPGameModeHuman AIDifficulty:OPGameAILevelNone];
}


- (void)startGameWithGameMode:(OPGameMode)gameMode AIDifficulty:(OPGameAILevel)level {
    OPGameConfig *config = [[OPGameConfig alloc] initWithGameCellLength:(int)self.cellNumSlider.value
                                                               gameMode:gameMode
                                                              gameLevel:level];
    
    OPGameViewController *gameViewController = [[OPGameViewController alloc] initWithNibName:@"OPGameViewController" bundle:[NSBundle mainBundle] gameConfig:config];
    [self.navigationController pushViewController:gameViewController animated:YES];
}

@end
