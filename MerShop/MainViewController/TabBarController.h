//
//  TabBarController.h
//  MerShop
//
//  Created by mac on 2019/3/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TabBarController : UITabBarController
+(TabBarController *)share;

@property (nonatomic , strong)NSMutableArray *tabarItemArr;

- (void)changeRootViewControllerEvent:(NSInteger)index;
@end

