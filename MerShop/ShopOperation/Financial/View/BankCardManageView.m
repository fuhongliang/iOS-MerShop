//
//  BankCardManageView.m
//  MerShop
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BankCardManageView.h"

@implementation BankCardManageView



- (IBAction)clickAccountInfo:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(checkAccountInfo)]){
        [self.delegate performSelector:@selector(checkAccountInfo) withObject:nil];
    }
}

- (IBAction)deleteCard:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteAction)]){
        [self.delegate performSelector:@selector(deleteAction) withObject:nil];
    }
}
@end
