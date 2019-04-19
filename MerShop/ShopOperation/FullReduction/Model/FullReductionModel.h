//
//  FullReductionModel.h
//  MerShop
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

//{
//    rule = [
//            {
//                price = 100058;
//                discount = 333
//            }
//            ];
//    mansong_name = "99";
//    state = 2;
//    start_time = 1555597800;
//    end_time = 1555684200
//    mansong_id = 5
//    }
@interface FullReductionModel : JSONModel

@property (nonatomic ,copy)NSArray *rule;
@property (nonatomic ,copy)NSString *mansong_name;
@property (nonatomic ,assign)NSInteger state;
@property (nonatomic ,assign)NSInteger start_time;
@property (nonatomic ,assign)NSInteger end_time;
@property (nonatomic ,assign)NSInteger mansong_id;
@end

