//
//  OrderModel.h
//  MerShop
//
//  Created by mac on 2019/3/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>


@interface OrderModel : JSONModel
@property (nonatomic ,assign)NSInteger order_id;

@property (nonatomic ,copy)NSDictionary *extend_order_common;

@property (nonatomic ,assign)NSInteger buyer_id;

@property (nonatomic ,copy)NSArray *extend_order_goods;

@property (nonatomic ,copy)NSString *goods_pay_price;

@property (nonatomic ,copy)NSString *total_price;

@property (nonatomic ,assign)NSInteger order_sn;

@property (nonatomic ,copy)NSString *commis_price;

@property (nonatomic ,copy)NSString *add_time;

@end

