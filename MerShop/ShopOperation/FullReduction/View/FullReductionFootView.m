//
//  FullReductionFootView.m
//  MerShop
//
//  Created by mac on 2019/4/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "FullReductionFootView.h"


@implementation FullReductionFootView


- (IBAction)addAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(addFullReduction)]){
        [self.delegate performSelector:@selector(addFullReduction) withObject:nil];
    }
}

@end
