//
//  EditeActivityTableViewCell.m
//  MerShop
//
//  Created by mac on 2019/4/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "EditeActivityTableViewCell.h"

@implementation EditeActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (void)setDataWithDict:(NSDictionary *)dict{
    NSString *urlPath = [NSString stringWithFormat:@"%@/%@",img_path,[dict objectForKey:@"img_name"]];
    [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:urlPath] placeholderImage:[UIImage imageNamed:@"bnt_photo_moren"]];
    self.title.text = dict[@"goods_name"];
    
    NSInteger a = [dict[@"xianshi_price"] integerValue];
    NSInteger b = [dict[@"goods_price"] integerValue];
    CGFloat y = ((CGFloat)a/b)*10;
    NSString *discount_rate = [NSString stringWithFormat:@"%.1f",y];
    self.discountRate.text = [NSString stringWithFormat:@"折扣率：%@折",discount_rate];
    
    self.nowPrice.text =[NSString stringWithFormat:@"¥%@",dict[@"xianshi_price"]];
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",[dict objectForKey:@"goods_price"]] attributes:attribtDic];
    self.oldPrice.attributedText = attribtStr;
    
}

- (IBAction)deleteAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteGoods:)]){
        [self.delegate performSelector:@selector(deleteGoods:) withObject:self];
    }
}
@end
