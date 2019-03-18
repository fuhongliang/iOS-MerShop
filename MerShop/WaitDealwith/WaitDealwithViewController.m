//
//  WaitDealwithViewController.m
//  MerShop
//
//  Created by mac on 2019/3/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "WaitDealwithViewController.h"
#import "ShopSetViewController.h"
#import "RingSettingViewController.h"
#import "BusinessStatusViewController.h"
#import "FeedbackViewController.h"
#import "AccountSecurityViewController.h"
#import "ChangePasswordViewController.h"
#import "GoodsManagementViewController.h"
#import "CreateGoodsViewController.h"
#import "ManageCatergoryViewController.h"
#import "CreateNewGoodsViewController.h"

@interface WaitDealwithViewController ()

@end

@implementation WaitDealwithViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"新订单"];
    [self setHideBackBtn:YES];
    
//    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [btn setFrame:XFrame(100, 200, 100, 100)];
//    [btn setTitle:@"走你" forState:(UIControlStateNormal)];
//    [btn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
//    [btn addTarget:self action:@selector(go) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:btn];
}

//- (void)go{
//    CreateNewGoodsViewController *vc = [[CreateNewGoodsViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//}


@end
