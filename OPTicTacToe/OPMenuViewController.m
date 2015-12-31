//
//  ViewController.m
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/27/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "OPMenuViewController.h"

#import "OPGameViewController.h"

@interface OPMenuViewController ()

@end

@implementation OPMenuViewController


- (IBAction)playPressed:(id)sender {
    OPGameViewController *gameViewController = [[OPGameViewController alloc] initWithNibName:@"OPGameViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:gameViewController animated:YES];
}

@end
