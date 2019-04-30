//
//  Registview.m
//  MerShop
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "Registview.h"

@implementation Registview

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)getCodeAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(getCode)]){
        [self.delegate performSelector:@selector(getCode) withObject:nil];
    }
}

- (IBAction)protocolAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(protocol)]){
        [self.delegate performSelector:@selector(protocol) withObject:nil];
    }
}

- (IBAction)registerAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(registUser)]){
        [self.delegate performSelector:@selector(registUser) withObject:nil];
    }
}

- (IBAction)backAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(goBack)]){
        [self.delegate performSelector:@selector(goBack) withObject:nil];
    }
}
@end
