//
//  refuseView.m
//  MerShop
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import "refuseView.h"

@implementation refuseView


- (IBAction)refuseBtn1:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(refuseMethod:)]){
        [self.delegate performSelector:@selector(refuseMethod:) withObject:self.btn1];
    }
}

- (IBAction)refusuBtn2:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(refuseMethod:)]){
        [self.delegate performSelector:@selector(refuseMethod:) withObject:self.btn2];
    }
}

- (IBAction)refuseBtn3:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(refuseMethod:)]){
        [self.delegate performSelector:@selector(refuseMethod:) withObject:self.btn3];
    }
}

- (IBAction)cancelBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(refuseMethod:)]){
        [self.delegate performSelector:@selector(refuseMethod:) withObject:self.btn4];
    }
}
@end
