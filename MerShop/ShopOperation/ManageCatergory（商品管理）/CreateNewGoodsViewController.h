//
//  CreateNewGoodsViewController.h
//  MerShop
//
//  Created by mac on 2019/3/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BasicViewController.h"


@interface CreateNewGoodsViewController : BasicViewController
@property (nonatomic ,assign)NSInteger switchStatus;
@property (nonatomic ,copy)NSString *className;
@property (nonatomic ,assign)NSInteger classId;
@property (nonatomic ,copy)NSString *image_path;
@property (nonatomic ,copy)NSString *goodsName;
@property (nonatomic ,copy)NSString *currentPrice;
@property (nonatomic ,copy)NSString *oldPrice;
@property (nonatomic ,assign)NSInteger storage;
@property (nonatomic ,copy)NSString *desc;
@property (nonatomic ,assign)NSInteger goodsId;
@property (nonatomic ,copy)NSString *tempStr;//是否是从商品管理编辑进来
@property (nonatomic ,copy)NSDictionary *tempDict;
@end

