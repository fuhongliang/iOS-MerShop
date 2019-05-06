//
//  AllReadyDeliveryTableViewCell.m
//  MerShop
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AllReadyDeliveryTableViewCell.h"
#import <Masonry.h>


@implementation AllReadyDeliveryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addProduct:(NewOrderModel *)model{
    self.number.text = [NSString stringWithFormat:@"#%ld",(long)model.order_id];
    self.customerName.text = [NSString stringWithFormat:@"%@  ",model.extend_order_common[@"reciver_name"]];
    self.customerPhoneNumber.text = [NSString stringWithFormat:@"%@",model.extend_order_common[@"phone"]];
    self.address.text = [NSString stringWithFormat:@"地址：%@",model.extend_order_common[@"address"]];
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
    self.incomeFee.text = [NSString stringWithFormat:@"¥%@",model.goods_pay_price];

    NSString *riderName = [NSString stringWithFormat:@"%@",[model.delivery objectForKey:@"name"]];
    NSString *phoneNumber = [NSString stringWithFormat:@"%@",[model.delivery objectForKey:@"phone"]];
    NSArray *a = model.extend_order_goods;
    UIView *lastView = nil;
    for (NSInteger i=0;i<a.count;i++){
        NSDictionary *dict = a[i];
        UIView *bgview = [[UIView alloc]init];
        [bgview setBackgroundColor:[UIColor whiteColor]];
        [self.contentBgView addSubview:bgview];
        if (i == 0) {
            if ((a.count -1) == 0) {
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
            
        }else if (i == (a.count - 1)){
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
        [name setText:[NSString stringWithFormat:@"%@",dict[@"goods_name"]]];
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(printfOrder:)]){
        [self.delegate performSelector:@selector(printfOrder:) withObject:self];
    }
}

@end
