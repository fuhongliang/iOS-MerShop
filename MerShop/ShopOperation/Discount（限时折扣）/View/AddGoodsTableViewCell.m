//
//  AddGoodsTableViewCell.m
//  MerShop
//
//  Created by mac on 2019/4/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AddGoodsTableViewCell.h"

@implementation AddGoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)chooseAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(seletItem:)]){
        [self.delegate performSelector:@selector(seletItem:) withObject:self];
    }
}

- (void)setDataWithDict:(NSDictionary *)dict{
    NSString *urlPath = [NSString stringWithFormat:@"%@/%@",img_path,[dict objectForKey:@"img_name"]];
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:urlPath] placeholderImage:[UIImage imageNamed:@"bnt_photo_moren"]];
    [self.name setText:[NSString stringWithFormat:@"%@",[dict objectForKey:@"goods_name"]]];
    NSInteger a = [dict[@"xianshi_price"] integerValue];
    NSInteger b = [dict[@"goods_price"] integerValue];
    CGFloat y = ((CGFloat)a/b)*10;
    NSString *discount_rate = [NSString stringWithFormat:@"%.1f",y];
    self.DiscountRate.text = [NSString stringWithFormat:@"折扣率：%@折",discount_rate];

    NSString *xianshi_price = [dict objectForKey:@"xianshi_price"];
    if (xianshi_price.length != 0){
        [self.nowPrice setText:[NSString stringWithFormat:@"¥%@",[dict objectForKey:@"xianshi_price"]]];
        //中划线
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",[dict objectForKey:@"goods_price"]] attributes:attribtDic];
        self.oldPrice.attributedText = attribtStr;
        [self.chooseBtn setImage:[UIImage imageNamed:@"yhq_icon_yixuanze"] forState:(UIControlStateNormal)];
        [self.discountImg setHidden:NO];
        [self.DiscountRate setHidden:NO];
        [self.oldPrice setHidden:NO];
    }else{
        [self.nowPrice setText:[NSString stringWithFormat:@"¥%@",[dict objectForKey:@"goods_price"]]];
        [self.chooseBtn setImage:[UIImage imageNamed:@"yhq_icon_weixuanze"] forState:(UIControlStateNormal)];
        [self.discountImg setHidden:YES];
        [self.DiscountRate setHidden:YES];
        [self.oldPrice setHidden:YES];
    }
}
@end
