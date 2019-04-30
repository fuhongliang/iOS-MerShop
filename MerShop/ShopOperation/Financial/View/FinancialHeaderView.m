//
//  FinancialHeaderView.m
//  MerShop
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "FinancialHeaderView.h"

@implementation FinancialHeaderView



- (IBAction)addBankCardAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(goBankCardView)]){
        [self.delegate performSelector:@selector(goBankCardView) withObject:nil];
    }
}

- (IBAction)getMoneyAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(goGetMoneyView)]){
        [self.delegate performSelector:@selector(goGetMoneyView) withObject:nil];
    }
}
@end
