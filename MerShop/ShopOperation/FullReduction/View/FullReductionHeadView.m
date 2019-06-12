//
//  FullReductionHeadView.m
//  MerShop
//
//  Created by mac on 2019/4/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "FullReductionHeadView.h"

@implementation FullReductionHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)startClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(showDatePickerView:)]){
        [self.delegate performSelector:@selector(showDatePickerView:) withObject:@"开始"];
    }
}

- (IBAction)endClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(showDatePickerView:)]){
        [self.delegate performSelector:@selector(showDatePickerView:) withObject:@"结束"];
    }
}
@end
