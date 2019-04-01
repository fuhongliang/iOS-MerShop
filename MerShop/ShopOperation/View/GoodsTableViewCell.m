//
//  GoodsTableViewCell.m
//  MerShop
//
//  Created by mac on 2019/3/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "GoodsTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation GoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataWithModel:(GoodsModel *)model{
    self.goodsTitle.text = model.goods_name;
    self.currentPrice.text = [NSString stringWithFormat:@"¥%@",model.goods_price];
    self.oldPrice.text = [NSString stringWithFormat:@"¥%@",model.goods_marketprice];
}

@end
