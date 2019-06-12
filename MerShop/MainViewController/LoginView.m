//
//  LoginView.m
//  MerShop
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)protocolAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(protocol)]){
        [self.delegate performSelector:@selector(protocol) withObject:nil];
    }
}

- (IBAction)loginAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(login)]){
        [self.delegate performSelector:@selector(login) withObject:nil];
    }
}

- (IBAction)registerAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(registerUser)]){
        [self.delegate performSelector:@selector(registerUser) withObject:nil];
    }
}
@end
