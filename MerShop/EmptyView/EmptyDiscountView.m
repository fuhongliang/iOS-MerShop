//
//  EmptyDiscountView.m
//  MerShop
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "EmptyDiscountView.h"

@implementation EmptyDiscountView

- (void)setArray:(NSArray *)array{
    [self.image setImage:[UIImage imageNamed:array[0]]];
    [self.title setText:array[1]];
}

@end
