//
//  AppDelegate.m
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/27/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "OPAppDelegate.h"

#import "OPMenuViewController.h"

@interface OPAppDelegate ()

@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation OPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    OPMenuViewController *menuViewController =
        [[OPMenuViewController alloc] initWithNibName:@"OPMenuViewController"
                                               bundle:[NSBundle mainBundle]];
    
    self.navigationController =
        [[UINavigationController alloc] initWithRootViewController:menuViewController];
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


#pragma mark - Getters and Setters

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    return _window;
}


@end
