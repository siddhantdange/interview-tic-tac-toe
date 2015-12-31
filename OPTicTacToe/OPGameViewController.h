//
//  OPGameViewController.h
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/28/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OPGameConfig;

@interface OPGameViewController : UIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil gameConfig:(OPGameConfig *)config;
    
@end
