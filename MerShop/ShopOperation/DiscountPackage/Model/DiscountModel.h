//
//  DiscountModel.h
//  MerShop
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

//{
//    bl_id = 17;
//    bl_state = 1;
//    bl_name = "图";
//    price = "0.00"
//    },

@interface DiscountModel : JSONModel
@property (nonatomic ,assign)NSInteger bl_id;
@property (nonatomic ,assign)NSInteger bl_state;
@property (nonatomic ,copy)NSString *bl_name;
@property (nonatomic ,copy)NSString *price;
@end

