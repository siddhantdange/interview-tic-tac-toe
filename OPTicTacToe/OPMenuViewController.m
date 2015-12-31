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

@property (weak, nonatomic) IBOutlet UILabel *cellNumLabel;
@property (weak, nonatomic) IBOutlet UISlider *cellNumSlider;

@end

@implementation OPMenuViewController

- (IBAction)cellNumSliderValueChanged:(id)sender {
    [self.cellNumLabel setText:[NSString stringWithFormat:@"%d", (int)lroundf(self.cellNumSlider.value)]];
    [self.cellNumSlider setValue:lroundf(self.cellNumSlider.value) animated:YES];
}

- (IBAction)playPressed:(id)sender {
    OPGameConfig *config = [[OPGameConfig alloc] initWithGameCellLength:(int)self.cellNumSlider.value];
    
    OPGameViewController *gameViewController = [[OPGameViewController alloc] initWithNibName:@"OPGameViewController" bundle:[NSBundle mainBundle] gameConfig:config];
    [self.navigationController pushViewController:gameViewController animated:YES];
}

@end
