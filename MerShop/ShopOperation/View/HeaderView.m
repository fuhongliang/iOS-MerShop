//
//  HeaderView.m
//  MerShop
//
//  Created by mac on 2019/3/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        
    }
    return self;
}


- (IBAction)goodsManageBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(category:)]){
        [self.delegate performSelector:@selector(category:) withObject:nil];
    }
}

- (IBAction)userEvaluationBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(evaluation:)]){
        [self.delegate performSelector:@selector(evaluation:) withObject:nil];
    }
}

- (IBAction)managementDataBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(managementData:)]){
        [self.delegate performSelector:@selector(managementData:) withObject:nil];
    }
}
@end
