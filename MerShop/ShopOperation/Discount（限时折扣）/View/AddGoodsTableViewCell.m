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
}

- (void)setDataWithModel{
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥44.44"] attributes:attribtDic];
    self.oldPrice.attributedText = attribtStr;
}
@end
