//
//  UIViewController+LCBlue.h
//  MerShop
//
//  Created by mac on 2019/4/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (LCBlue)

/**
    蓝牙打印机，打印输出
 */
- (void)printOrderWithDict:(NSDictionary *)dict;

/**
    新订单拨打用户电话
 */
- (void)playCellPhoneWithData:(id)data;
@end

