//
//  ActivityHeaderView.m
//  MerShop
//
//  Created by mac on 2019/4/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ActivityHeaderView.h"

@implementation ActivityHeaderView


- (IBAction)reduce:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(reduceNumber)]){
        [self.delegate performSelector:@selector(reduceNumber) withObject:nil];
    }
}

- (IBAction)add:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(addNumber)]){
        [self.delegate performSelector:@selector(addNumber) withObject:nil];
    }
}
@end
