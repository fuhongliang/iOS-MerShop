//
//  DiscountPackageTableViewCell.m
//  MerShop
//
//  Created by mac on 2019/4/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DiscountPackageTableViewCell.h"

@implementation DiscountPackageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)manageAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(manageAction:)]){
        [self.delegate performSelector:@selector(manageAction:) withObject:self];
    }
}

- (IBAction)deleteAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteAction:)]){
        [self.delegate performSelector:@selector(deleteAction:) withObject:self];
    }
}

- (void)setDataWithModel:(DiscountModel *)model{
    [self.line drawDottedLine];
    self.title.text = model.bl_name;
    self.discountPrice.text = [NSString stringWithFormat:@"总优惠价格：%@",model.price];
    if (model.bl_state == 1){
        [self.stateImg setHidden:YES];
        [self.discountPrice setTextColor:toPCcolor(@"#1c98f6")];
        self.packageImg.image = [UIImage imageNamed:@"yhq_bnt_xszk_tc"];
    }else{
        [self.stateImg setHidden:NO];
        [self.discountPrice setTextColor:toPCcolor(@"#999999")];
        self.packageImg.image = [UIImage imageNamed:@"yhq_bnt_xszk_tc01"];
    }
}
@end
