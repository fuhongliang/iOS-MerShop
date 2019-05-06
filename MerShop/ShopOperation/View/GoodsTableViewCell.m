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

- (IBAction)upBtnAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(upShelfAction:)]){
        [self.delegate performSelector:@selector(upShelfAction:) withObject:self];
    }
}

- (IBAction)deleteAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteGoods:)]){
        [self.delegate performSelector:@selector(deleteGoods:) withObject:self];
    }
}

- (IBAction)editeAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(edite:)]){
        [self.delegate performSelector:@selector(edite:) withObject:self];
    }
}

- (void)setDataWithModel:(GoodsModel *)model{
    self.state = [NSString stringWithFormat:@"%ld",model.goods_state];
    if (model.goods_state == 1){
        [self.orangeView setHidden:YES];
        [self.upShelf setTitle:@"下架" forState:(UIControlStateNormal)];
    }else{
        [self.orangeView setHidden:NO];
        self.goodsState.text = @"已下架";
        [self.upShelf setTitle:@"上架" forState:(UIControlStateNormal)];
    }
    [self.goodsIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.img_name]] placeholderImage:[UIImage imageNamed:@"bnt_photo_moren"]];
    self.goodsStorage.text = [NSString stringWithFormat:@"当前库存：%ld",(long)model.goods_storage];
    self.goodsTitle.text = model.goods_name;
    self.currentPrice.text = [NSString stringWithFormat:@"¥%@",model.goods_price];
    
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",model.goods_marketprice] attributes:attribtDic];
    self.oldPrice.attributedText = attribtStr;
}

@end
