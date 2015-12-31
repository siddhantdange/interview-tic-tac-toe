//
//  OPGameConfig.m
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/30/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "OPGameConfig.h"

@interface OPGameConfig ()

@property (nonatomic, assign) int gameCellLength;

@end

@implementation OPGameConfig

- (instancetype)initWithGameCellLength:(int)gameCellLength {
    self = [super init];
    if (self) {
        self.gameCellLength = gameCellLength;
    }
    
    return self;
}

@end
