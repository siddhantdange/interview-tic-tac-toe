//
//  OPGameView.h
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/28/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OPGameView : UIView

- (instancetype)init;
- (void)drawValue:(NSString *)value atX:(int)x Y:(int)y;

@end
