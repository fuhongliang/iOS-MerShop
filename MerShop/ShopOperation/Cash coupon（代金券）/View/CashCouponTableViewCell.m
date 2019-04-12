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

- (void)setDataWithModel{
    [self.line1 drawDottedLine];
    [self.line2 drawDottedLine];
}
@end
