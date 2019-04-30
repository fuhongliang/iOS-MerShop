//
//  AddBankCardView.m
//  MerShop
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AddBankCardView.h"

@implementation AddBankCardView



- (IBAction)addBankCardAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(addCard)]){
        [self.delegate performSelector:@selector(addCard) withObject:nil];
    }
}
@end
