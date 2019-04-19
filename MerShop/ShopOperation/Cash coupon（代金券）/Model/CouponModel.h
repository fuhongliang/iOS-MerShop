//
//  CouponModel.h
//  MerShop
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
//"voucher_id": 1,
//"voucher_title": "代金券",
//"voucher_eachlimit": 1,  //每人限领
//"voucher_start_date": "2019-04-07 03:18:32",
//"voucher_end_date": "2019-04-17 16:00:00",
//"voucher_surplus": 100,//剩余
//"voucher_used": 0,//使用
//"voucher_giveout": 0,//领取
//"voucher_limit": "2000.00",//限额
//"voucher_state": 1 代金券模版状态(1-有效,2-失效)



@interface CouponModel : JSONModel
@property (nonatomic ,assign)NSInteger voucher_id;
@property (nonatomic ,copy)NSString *voucher_title;
@property (nonatomic ,assign)NSInteger voucher_eachlimit;
@property (nonatomic ,copy)NSString *voucher_start_date;
@property (nonatomic ,copy)NSString *voucher_end_date;
@property (nonatomic ,assign)NSInteger voucher_surplus;
@property (nonatomic ,assign)NSInteger voucher_used;
@property (nonatomic ,assign)NSInteger voucher_giveout;
@property (nonatomic ,copy)NSString *voucher_limit;
@property (nonatomic ,assign)NSInteger voucher_state;
@end

