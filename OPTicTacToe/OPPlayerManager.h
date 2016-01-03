//
//  OPPlayerManager.h
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/28/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OPPlayerConstants.h"


@interface OPPlayerManager : NSObject

@property (nonatomic, assign) OPGamePlayer currentPlayer;

- (void)switchPlayer;

@end
