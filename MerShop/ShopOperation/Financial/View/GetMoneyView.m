//
//  GetMoneyView.m
//  MerShop
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "GetMoneyView.h"

@implementation GetMoneyView


- (IBAction)allGetAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(allGet)]){
        [self.delegate performSelector:@selector(allGet) withObject:nil];
    }
}

- (IBAction)ensure:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(ensureGet)]){
        [self.delegate performSelector:@selector(ensureGet) withObject:nil];
    }
}

- (IBAction)addAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(addBankCard)]){
        [self.delegate performSelector:@selector(addBankCard) withObject:nil];
    }
}
@end
