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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playPressed:(id)sender {
    OPGameViewController *gameViewController = [[OPGameViewController alloc] initWithNibName:@"OPGameViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:gameViewController animated:YES];
}

@end
