//
//  EditeCashCouponView.m
//  MerShop
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "EditeCouponView.h"

@implementation EditeCouponView


- (IBAction)submitAction:(id)sender {
}

- (IBAction)addAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(addNumber)]){
        [self.delegate performSelector:@selector(addNumber) withObject:nil];
    }
}

- (IBAction)reduceAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(reduceNumber)]){
        [self.delegate performSelector:@selector(reduceNumber) withObject:nil];
    }
}
@end
