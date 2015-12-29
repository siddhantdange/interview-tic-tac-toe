//
//  OPGamePiece.m
//  OPTicTacToe
//
//  Created by Siddhant Dange on 12/28/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "OPGamePiece.h"

@interface OPGamePiece ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation OPGamePiece

- (instancetype)initWithValue:(NSString *)value {
    self = (OPGamePiece*)[[[NSBundle mainBundle] loadNibNamed:@"OPGamePiece" owner:self options:nil] objectAtIndex:0];
    if ([value isEqualToString:@"x"]) {
        self.imageView.image = [UIImage imageNamed:@"x-mark"];
    } else {
        self.imageView.image = [UIImage imageNamed:@"o-mark"];
    }
    
    return self;
}

@end
