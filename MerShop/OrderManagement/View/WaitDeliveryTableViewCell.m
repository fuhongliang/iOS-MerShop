//
//  WaitDeliveryTableViewCell.m
//  MerShop
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import "WaitDeliveryTableViewCell.h"
#import <Masonry.h>


@implementation WaitDeliveryTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)addProduct:(NewOrderModel *)model withExplandState:(NSString *)state{
    self.expland = state;
    
    self.number.text = [NSString stringWithFormat:@"#%ld",model.order_id];
    self.customerName.text = [NSString stringWithFormat:@"%@  ",model.extend_order_common[@"reciver_name"]];
    
    self.PhoneNumber = [NSString stringWithFormat:@"%@",model.extend_order_common[@"phone"]];
    self.customerPhoneNumber.text = [NSString stringWithFormat:@"%@****%@",[self.PhoneNumber substringToIndex:3],[self.PhoneNumber substringFromIndex:self.PhoneNumber.length-4]];
    
    NSString *address = [NSString stringWithFormat:@"地址：%@",model.extend_order_common[@"address"]];
    self.address.text = [address stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    self.orderState.text = [NSString stringWithFormat:@"%@",model.order_state];
    
    if ([self.orderState.text isEqualToString:@"已取消"]){
        self.orderState.textColor = toPCcolor(@"#999999");
    }else if ([self.orderState.text isEqualToString:@"已完成"]){
        self.orderState.textColor = toPCcolor(@"#1C98F6");
    }else if ([self.orderState.text isEqualToString:@"配送中"]){
        self.orderState.textColor = toPCcolor(@"#0AC782");
    }else if ([self.orderState.text isEqualToString:@"待配送"]){
        self.orderState.textColor = toPCcolor(@"#EC1818");
    }else{
        self.orderState.textColor = toPCcolor(@"#0AC782");
    }

    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"下单时间：%@",model.add_time]];
    [str addAttribute:NSForegroundColorAttributeName value:toPCcolor(@"#666666") range:NSMakeRange(5, [NSString stringWithFormat:@"下单时间：%@",model.add_time].length-5)];
    self.orderTime.attributedText = str;
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"订单编号：%ld",(long)model.order_sn]];
    [str1 addAttribute:NSForegroundColorAttributeName value:toPCcolor(@"#666666") range:NSMakeRange(5, [NSString stringWithFormat:@"订单编号：%ld",(long)model.order_sn].length-5)];
    self.orderNumber.attributedText = str1;

    self.allPrice.text = [NSString stringWithFormat:@"¥%@",model.total_price];
    self.serviceFee.text = [NSString stringWithFormat:@"¥%@",model.commis_price];
    self.incomePrice.text = [NSString stringWithFormat:@"¥%@",model.goods_pay_price];
    
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
    for (NSInteger i=0; i <goodsCount; i++){
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
        [price setText:[NSString stringWithFormat:@"¥%@",dict[@"goods_price"]]];
        [price setFont:XFont(16)];
        [number setTextColor:toPCcolor(@"#999999")];
        NSString *num = dict[@"goods_num"];
        [number setText:[NSString stringWithFormat:@"x%@",num]];
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

- (IBAction)printf:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(printOrder:)]){
        [self.delegate performSelector:@selector(printOrder:) withObject:self];
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

- (IBAction)playCall:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(playCallAction:)]){
        [self.delegate performSelector:@selector(playCallAction:) withObject:self.PhoneNumber];
    }
}

@end
