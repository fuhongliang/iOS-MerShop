//
//  FooterView.m
//  MerShop
//
//  Created by mac on 2019/4/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "FooterView.h"

@implementation FooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)addAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(addActivityGoods)]){
        [self.delegate performSelector:@selector(addActivityGoods) withObject:nil];
    }
}


- (IBAction)openSwitch:(id)sender {
    if (self.stateSwitch.isOn){
        if (self.delegate && [self.delegate respondsToSelector:@selector(open:)]){
            [self.delegate performSelector:@selector(open:) withObject:@"1"];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(open:)]){
            [self.delegate performSelector:@selector(open:) withObject:@"0"];
        }

    }
}

@end
