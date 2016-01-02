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

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    self.navigationItem.hidesBackButton = YES;
}


- (IBAction)cellNumSliderValueChanged:(id)sender {
    int cellNum = (int)lroundf(self.cellNumSlider.value);
    [self.cellNumLabel1 setText:[NSString stringWithFormat:@"%d", cellNum]];
    [self.cellNumLabel2 setText:[NSString stringWithFormat:@"%d", cellNum]];
    [self.cellNumSlider setValue:cellNum animated:YES];
}


- (IBAction)playPressed:(id)sender {
    OPGameConfig *config = [[OPGameConfig alloc] initWithGameCellLength:(int)self.cellNumSlider.value];
    
    OPGameViewController *gameViewController = [[OPGameViewController alloc] initWithNibName:@"OPGameViewController" bundle:[NSBundle mainBundle] gameConfig:config];
    [self.navigationController pushViewController:gameViewController animated:YES];
}

@end
