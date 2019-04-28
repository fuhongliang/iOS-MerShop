//
//  LimitDiscountModel.h
//  MerShop
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 xianshi_name = "图";
 xianshi_id = 25;
 state = 1;
 start_time = 1555646040;
 end_time = 1555646040;
 lower_limit = 1
 */
@interface LimitDiscountModel : JSONModel
@property (nonatomic ,copy)NSString *xianshi_name;
@property (nonatomic ,assign)NSInteger xianshi_id;
@property (nonatomic ,assign)NSInteger state;
@property (nonatomic ,assign)NSInteger start_time;
@property (nonatomic ,assign)NSInteger end_time;
@property (nonatomic ,assign)NSInteger lower_limit;

@end

