//
//  GoodsModel.h
//  MerShop
//
//  Created by mac on 2019/3/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>
//goods_sale_time = [
//                   {
//                       00:00 = "00:00";
//                       23:59 = "23:59"
//                   }
//                   ];
//img_name = "6658242efdfb8d53ce82d204549d60cf.jpg";
//goods_marketprice = "98.00";
//goods_state = 0;
//goods_storage = 999999999;
//img_path = "http://47.111.27.189:2000/storage/shop/store/goods/2";
//goods_price = "66.00";
//goods_name = "菠萝";
//goods_desc = "";
//goods_id = 100078

@interface GoodsModel : JSONModel

@property (nonatomic ,copy)NSArray *goods_sale_time;
@property (nonatomic ,assign)NSInteger goods_id;
//@property (nonatomic ,copy)NSString *img_path;
@property (nonatomic ,copy)NSString *img_name;
@property (nonatomic ,assign)NSInteger goods_state;
@property (nonatomic ,copy)NSString *goods_name;
@property (nonatomic ,copy)NSString *goods_price;
@property (nonatomic ,copy)NSString *goods_marketprice;
@property (nonatomic ,assign)NSInteger is_much;
//@property (nonatomic ,assign)NSInteger goods_salenum;
@property (nonatomic ,copy)NSString *xianshi_price;
@property (nonatomic ,assign)NSInteger goods_storage;
@property (nonatomic ,copy)NSString *goods_desc;


@end

