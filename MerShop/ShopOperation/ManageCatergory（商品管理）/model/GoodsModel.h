//
//  GoodsModel.h
//  MerShop
//
//  Created by mac on 2019/3/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>
//"goods_id": 100002,
//"goods_name": "fdsfdsf",
//"goods_price": "1.00",
//"goods_marketprice": "1.00",
//"goods_salenum": 0,
//"goods_storage": 1011

@interface GoodsModel : JSONModel

@property (nonatomic ,assign)NSInteger goods_id;
@property (nonatomic ,copy)NSString *goods_name;
@property (nonatomic ,copy)NSString *goods_price;
@property (nonatomic ,copy)NSString *goods_marketprice;
@property (nonatomic ,assign)NSInteger goods_salenum;
@property (nonatomic ,assign)NSInteger goods_storage;


@end

