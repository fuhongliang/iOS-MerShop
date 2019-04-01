//
//  IFTools.h
//  MerShop
//
//  Created by mac on 2019/3/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
//**
//store_state = 1;
//store_name = "test顶顶顶顶";
//business_licence_number_electronic = "";
//member_mobile = "";
//area_info = "";
//store_address = "";
//store_description = "";
//token = "4c128d55dfcfd7976a12d6a86e306d15";
//store_id = 1;
//store_avatar = "";
//store_workingtime = "";
//member_id = 1
//

@interface IFTools : NSObject

@property (nonatomic, copy)NSString *store_name;
@property (nonatomic, copy)NSString *business_licence_number_electronic;
@property (nonatomic, copy)NSString *member_mobile;
@property (nonatomic, copy)NSString *area_info;
@property (nonatomic, copy)NSString *store_address;
@property (nonatomic, copy)NSString *store_description;
@property (nonatomic, copy)NSString *token;
@property (nonatomic, assign)NSInteger store_id;
@property (nonatomic, copy)NSString *store_avatar;
@property (nonatomic, copy)NSString *store_workingtime;
@property (nonatomic, assign)NSInteger member_id;
@property (nonatomic, assign)NSInteger store_state;
@end

