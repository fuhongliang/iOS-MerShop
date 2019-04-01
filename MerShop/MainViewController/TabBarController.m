//
//  TabBarController.m
//  MerShop
//
//  Created by mac on 2019/3/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TabBarController.h"
#import "MeViewController.h"
#import "ShopViewController.h"
#import "OrderManagementViewController.h"
#import "WaitDealwithViewController.h"


@interface TabBarController ()

@end

static TabBarController *shareObj = nil;

@implementation TabBarController{
    NSMutableArray *tabarControllersArr;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTabar];
}

+(TabBarController *)share{
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        shareObj = [[super allocWithZone: NULL ] init];
    });
    
    return shareObj;
}

+ (id) allocWithZone:(struct _NSZone *)zone
{
    return [self share];
}

- (void)createTabar{
    tabarControllersArr = [[NSMutableArray alloc]init];
    NSArray *vcNameArr = [self getTabarListName];
    for (NSString *str in vcNameArr){
        Class class = NSClassFromString(str);
        UIViewController *vc = [[class alloc]init];
        [tabarControllersArr addObject:vc];
    }
    
    [self setViewControllers:tabarControllersArr animated:YES];
    NSArray *itemNameArr = [self getItemName];
    for (int i = 0; i < tabarControllersArr.count; i ++){
        UITabBarItem *item = [self.tabBar.items objectAtIndex:i];
        [item setTitle:[itemNameArr objectAtIndex:i]];
        NSDictionary *textTitleOptions = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:11]};
        [item setTitleTextAttributes:textTitleOptions forState:UIControlStateNormal];
        UIImage *imgNormal = [UIImage imageNamed:[self getTabarItemNormalIconString:i]];
        UIImage *selectImage = [UIImage imageNamed:[self getTabarItemSelectedIconString:i]];
        item.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.image = [imgNormal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBar.tintColor = IFThemeBlueColor;
        
    }
    
}

//获取每个item的名字
- (NSArray *)getItemName{
    return @[@"待处理",@"订单管理",@"门店运营",@"我的"];
    
}

//获取每个tabarcontroller的名字
- (NSArray *)getTabarListName{
    return @[@"WaitDealwithViewController",@"OrderManagementViewController",@"ShopViewController",@"MeViewController"];
    
}

//获取每个tabar图片的字符串
- (NSString *)getTabarItemNormalIconString:(int)num{
    return [NSString stringWithFormat:@"tb%d1",num];
    
}

- (NSString *)getTabarItemSelectedIconString:(int)num{
    return [NSString stringWithFormat:@"tb%d2",num];
}

- (void)changeRootViewControllerEvent:(NSInteger)index{
    [self setSelectedIndex:index];
}

@end
