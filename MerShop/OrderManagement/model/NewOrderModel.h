//
//  NewOrderModel.h
//  MerShop
//
//  Created by mac on 2019/3/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>

//order_id = 8;
//extend_order_common = {
//    phone = "18888888888";
//    address = "广东    广州市    天河区 越秀区广州大道中599号泰兴商业大厦10楼, 越秀区";
//    reciver_name = "Fu Male Kevin"
//};
//buyer_id = 4;
//extend_order_goods = [
//                      {
//                          commis_rate = 0;
//                          goods_price = "20.00";
//                          goods_num = 1;
//                          goods_name = "电影票电影票电影票电影票电影票";
//                          goods_pay_price = "20.00"
//                      }
//                      ];
//goods_pay_price = 20;
//total_price = 20;
//order_sn = 2000000000000801;
//commis_price = 0;
//add_time = "2019-03-14 14:46:53"

@interface NewOrderModel : JSONModel
@property (nonatomic ,assign)NSInteger order_id;
@property (nonatomic ,copy)NSDictionary *extend_order_common;
@property (nonatomic ,assign)NSInteger buyer_id;
@property (nonatomic ,copy)NSArray *extend_order_goods;
@property (nonatomic ,copy)NSDictionary *delivery;
@property (nonatomic ,assign)CGFloat goods_pay_price;
@property (nonatomic ,assign)CGFloat total_price;
@property (nonatomic ,assign)NSInteger order_sn;
@property (nonatomic ,copy)NSString *order_state;
@property (nonatomic ,assign)CGFloat commis_price;
@property (nonatomic ,copy)NSString *add_time;
@end

