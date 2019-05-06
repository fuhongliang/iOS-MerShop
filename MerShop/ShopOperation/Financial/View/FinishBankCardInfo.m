//
//  FinishBankCardInfo.m
//  MerShop
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "FinishBankCardInfo.h"

@implementation FinishBankCardInfo


- (IBAction)finishAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(finish)]){
        [self.delegate performSelector:@selector(finish) withObject:nil];
    }
}
@end
