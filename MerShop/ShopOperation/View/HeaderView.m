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

- (void)addStoreInfo:(NSDictionary *)data{
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.whiteView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(17, 17)];
//
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//
//    maskLayer.frame = self.whiteView.bounds;
//
//    maskLayer.path = maskPath.CGPath;
//
//    self.whiteView.layer.mask = maskLayer;

    self.todayIncome.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"today_orderamount"]];
    self.todayOrder.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"today_ordernum"]];
    self.collectNumber.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"store_collect"]];
    self.totalGoods.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"goods_num"]];
    self.oneMonthOrder.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"30_ordernum"]];
    self.oneMonthIncome.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"30_orderamount"]];
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
