//
//  EditeCashCouponView.m
//  MerShop
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "EditeCouponView.h"

@implementation EditeCouponView


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

- (IBAction)selectNumAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(showPickerView:)]){
        [self.delegate performSelector:@selector(showPickerView:) withObject:@"金额"];
    }
}

- (IBAction)selectTimeAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(showPickerView:)]){
        [self.delegate performSelector:@selector(showPickerView:) withObject:@"时间"];
    }
}
@end
