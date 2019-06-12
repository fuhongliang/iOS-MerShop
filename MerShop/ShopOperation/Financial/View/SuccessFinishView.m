//
//  SuccessFinishView.m
//  MerShop
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SuccessFinishView.h"

@implementation SuccessFinishView

- (void)setTitleDict:(NSDictionary *)titleDict{
    [self.title setText:titleDict[@"title"]];
    [self.subTitle setText:titleDict[@"subTitle"]];
}

- (IBAction)backAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(back)]){
        [self.delegate performSelector:@selector(back) withObject:nil];
    }
}
@end
