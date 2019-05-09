//
//  NewOrderTableViewCell1.m
//  MerShop
//
//  Created by mac on 2019/3/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "NewOrderTableViewCell1.h"
#import <Masonry.h>

@implementation NewOrderTableViewCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)refuse:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(refuseOrder:)]){
        [self.delegate performSelector:@selector(refuseOrder:) withObject:self];
    }
}

- (IBAction)receive:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(receiveOrder:)]){
        [self.delegate performSelector:@selector(receiveOrder:) withObject:self];
    }
}

- (IBAction)explandAction:(id)sender {
    if ([self.expland isEqualToString:@"0"]){
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        [arr addObject:self];
        [arr addObject:@"1"];
        if (self.delegate && [self.delegate respondsToSelector:@selector(explandOrder:)]){
            [self.delegate performSelector:@selector(explandOrder:) withObject:arr];
        }
    }else{
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        [arr addObject:self];
        [arr addObject:@"0"];
        if (self.delegate && [self.delegate respondsToSelector:@selector(explandOrder:)]){
            [self.delegate performSelector:@selector(explandOrder:) withObject:arr];
        }
    }
}

- (void)addProduct:(OrderModel *)model withExplandState:(NSString *)state{
    self.expland = state;
    self.number.text = [NSString stringWithFormat:@"#%ld",(long)model.order_id];
    self.name.text = [NSString stringWithFormat:@"%@  ",model.extend_order_common[@"reciver_name"]];
    self.customerPhoneNumber.text = [NSString stringWithFormat:@"%@",model.extend_order_common[@"phone"]];
    self.address.text = [NSString stringWithFormat:@"地址：%@",model.extend_order_common[@"address"]];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"下单时间：%@",model.add_time]];
    [str addAttribute:NSForegroundColorAttributeName value:toPCcolor(@"#666666") range:NSMakeRange(5, [NSString stringWithFormat:@"下单时间：%@",model.add_time].length-5)];
    self.makeOrderTime.attributedText = str;
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"订单编号：%ld",model.order_sn]];
    [str1 addAttribute:NSForegroundColorAttributeName value:toPCcolor(@"#666666") range:NSMakeRange(5, [NSString stringWithFormat:@"订单编号：%ld",model.order_sn].length-5)];
    self.orderNumber.attributedText = str1;

    self.allPrice.text = [NSString stringWithFormat:@"¥%@",model.total_price];
    self.servicePrice.text = [NSString stringWithFormat:@"¥%@",model.commis_price];
    self.income.text = [NSString stringWithFormat:@"¥%@",model.goods_pay_price];
    
    NSArray *a = model.extend_order_goods;
    NSInteger goodsCount;
    if (a.count>2){
        [self.explandTextBtn setHidden:NO];
        [self.explandImgBtn setHidden:NO];
        if ([state isEqualToString:@"0"]){
            goodsCount = 2;
            [self.explandTextBtn setTitle:@"展开" forState:(UIControlStateNormal)];
            [self.explandImgBtn setImage:[UIImage imageNamed:@"icon_zhankai"] forState:(UIControlStateNormal)];
        }else{
            goodsCount = a.count;
            [self.explandTextBtn setTitle:@"收起" forState:(UIControlStateNormal)];
            [self.explandImgBtn setImage:[UIImage imageNamed:@"icon_shouqi"] forState:(UIControlStateNormal)];
        }
    }else{
        [self.explandImgBtn setHidden:YES];
        [self.explandTextBtn setHidden:YES];
        goodsCount = a.count;
    }
    UIView *lastView = nil;
    for (NSInteger i=0;i<goodsCount;i++){
        NSDictionary *dict = a[i];
        UIView *bgview = [[UIView alloc]init];
        [bgview setBackgroundColor:[UIColor whiteColor]];
        [self.contentBgView addSubview:bgview];
        if (i == 0) {
            if ((goodsCount -1) == 0) {
                [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.contentBgView.mas_left).offset(0);
                    make.top.equalTo(self.contentBgView.mas_top).offset(0);
                    make.right.equalTo(self.contentBgView.mas_right).offset(0);
                    make.bottom.equalTo(self.contentBgView.mas_bottom).offset(0);
                }];
            }else{
                [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.contentBgView.mas_left).offset(0);
                    make.top.equalTo(self.contentBgView.mas_top).offset(0);
                    make.right.equalTo(self.contentBgView.mas_right).offset(0);
                }];
            }
            
        }else if (i == (goodsCount - 1)){
            [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentBgView.mas_left).offset(0);
                make.top.equalTo(lastView.mas_bottom).offset(10);
                make.right.equalTo(self.contentBgView.mas_right).offset(0);
                make.bottom.equalTo(self.contentBgView.mas_bottom).offset(0);
            }];
        }else{
            [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentBgView.mas_left).offset(0);
                make.top.equalTo(lastView.mas_bottom).offset(10);
                make.right.equalTo(self.contentBgView.mas_right).offset(0);
            }];
        }
        lastView = bgview;
        
        UILabel *name = [[UILabel alloc]init];
        UILabel *price = [[UILabel alloc]init];
        UILabel *number = [[UILabel alloc]init];
        
        [name setTextColor:toPCcolor(@"#333333")];
        [name setFont:XFont(14)];
        [name setText:dict[@"goods_name"]];
        
        [price setTextColor:toPCcolor(@"#333333")];
        [price setTextAlignment:(NSTextAlignmentRight)];
        [price setFont:XFont(16)];
        [price setText:[NSString stringWithFormat:@"¥%@",dict[@"goods_price"]]];
        
        [number setTextColor:toPCcolor(@"#999999")];
        [number setText:[NSString stringWithFormat:@"x%@",dict[@"goods_num"]]];
        [number setFont:XFont(12)];
        
        [bgview addSubview:name];
        [bgview addSubview:price];
        [bgview addSubview:number];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgview.mas_left).offset(0);
            make.top.equalTo(bgview.mas_top).offset(0);
            make.right.equalTo(bgview.mas_right).offset(0);
        }];
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgview.mas_left).offset(0);
            make.top.equalTo(bgview.mas_top).offset(0);
            make.right.equalTo(bgview.mas_right).offset(0);
        }];
        [number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgview.mas_left).offset(0);
            make.top.equalTo(name.mas_bottom).offset(11);
            make.right.equalTo(bgview.mas_right).offset(0);
            make.bottom.equalTo(bgview.mas_bottom).offset(0);
        }];
    }
}

@end
