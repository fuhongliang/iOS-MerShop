//
//  DiscountPackageGoodsCell.m
//  MerShop
//
//  Created by mac on 2019/4/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DiscountPackageGoodsCell.h"

@implementation DiscountPackageGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataWithDict:(NSDictionary *)dict{

    NSString *urlPath = [NSString stringWithFormat:@"%@/%@",img_path,dict[@"img_name"]];
    [self.image sd_setImageWithURL:[NSURL URLWithString:urlPath] placeholderImage:[UIImage imageNamed:@"bnt_photo_moren"]];
    self.discountPrice.text = [NSString stringWithFormat:@"优惠价格：%@",dict[@"xianshi_price"]];
    self.title.text = dict[@"goods_name"];
    self.oldPrice.text = [NSString stringWithFormat:@"原价：¥%@",[dict objectForKey:@"goods_price"]];
}

- (IBAction)deleteAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteGoods:)]){
        [self.delegate performSelector:@selector(deleteGoods:) withObject:self];
    }
}
@end
