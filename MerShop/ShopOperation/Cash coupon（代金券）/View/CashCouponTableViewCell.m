//
//  CashCouponTableViewCell.m
//  MerShop
//
//  Created by mac on 2019/4/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CashCouponTableViewCell.h"

@implementation CashCouponTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)edite:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(editeAction:)]){
        [self.delegate performSelector:@selector(editeAction:) withObject:self];
    }
}

- (IBAction)deleteAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteAction:)]){
        [self.delegate performSelector:@selector(deleteAction:) withObject:self];
    }
}

- (void)setDataWithModel:(CouponModel *)model{
    [self.line1 drawDottedLine];
    [self.line2 drawDottedLine];
    if (model.voucher_state == 1){
        [self.couponImg setImage:[UIImage imageNamed:@"yhq_bnt_xszk_djq"]];
        [self.couponStateImg setHidden:YES];
        [self.rest setTextColor:toPCcolor(@"#1c98f6")];
        [self.receive setTextColor:toPCcolor(@"#1c98f6")];
        [self.used setTextColor:toPCcolor(@"#1c98f6")];
        [self.orderPrice setTextColor:toPCcolor(@"#1c98f6")];
    }else{
        [self.couponImg setImage:[UIImage imageNamed:@"yhq_bnt_xszk_djq01"]];
        [self.couponStateImg setHidden:NO];
        [self.rest setTextColor:toPCcolor(@"#333333")];
        [self.receive setTextColor:toPCcolor(@"#333333")];
        [self.used setTextColor:toPCcolor(@"#333333")];
        [self.orderPrice setTextColor:toPCcolor(@"#333333")];
    }
    self.couponTitle.text = [NSString stringWithFormat:@"%@",model.voucher_title];
    self.limitLab.text = [NSString stringWithFormat:@"每人限领%ld张",(long)model.voucher_eachlimit];
    self.timeLab.text = [NSString stringWithFormat:@"截止日期：%@",model.voucher_end_date];
    self.rest.text = [NSString stringWithFormat:@"%ld",(long)model.voucher_surplus];
    self.receive.text = [NSString stringWithFormat:@"%ld",(long)model.voucher_used];
    self.used.text = [NSString stringWithFormat:@"%ld",(long)model.voucher_giveout];
    self.orderPrice.text = [NSString stringWithFormat:@"¥%@",model.voucher_limit];
}
@end
