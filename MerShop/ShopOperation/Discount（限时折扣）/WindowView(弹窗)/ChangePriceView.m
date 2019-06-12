//
//  ChangePriceView.m
//  MerShop
//
//  Created by mac on 2019/4/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ChangePriceView.h"

@implementation ChangePriceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)submitAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(submitData)]){
        [self.delegate performSelector:@selector(submitData) withObject:nil];
    }
}
@end
