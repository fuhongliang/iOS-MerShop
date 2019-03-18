//
//  MeViewController.m
//  MerShop
//
//  Created by mac on 2019/3/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "MeViewController.h"
#import "ShopSetViewController.h"
#import "BusinessStatusViewController.h"
#import "AccountSecurityViewController.h"
#import "RingSettingViewController.h"
#import "FeedbackViewController.h"
#import "BackgroundView.h"
#import "PhoneNumberView.h"

@interface MeViewController ()<BackgroundViewDelegate,PhoneNumberViewDelegate>
@property (nonatomic ,strong)UIView *clearView;
@property (nonatomic ,strong)PhoneNumberView *upView;
@property (nonatomic ,strong)UILabel *statusLab;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNaviTitle:@"个人中心"];
    [self setHideBackBtn:YES];
    [self createNavigationbar];
    BackgroundView *view = [[BackgroundView alloc]initWithFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y-Tabbar_H)];
    view.delegate = self;
    [view setBackgroundColor:IFThemeBlueColor];
    [self.view addSubview:view];
    
    _clearView = [[UIView alloc]initWithFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [_clearView setBackgroundColor:BlackColor];
    [_clearView setAlpha:0.5];
    [_clearView setHidden:YES];
    [self.view addSubview:_clearView];
    
    _upView = [[PhoneNumberView alloc]init];
    [_upView setFrame:XFrame(IFAutoFitPx(96), IFAutoFitPx(456)+ViewStart_Y, IFAutoFitPx(560), IFAutoFitPx(292))];
    _upView.layer.cornerRadius = IFAutoFitPx(8);
    _upView.layer.masksToBounds = YES;
    _upView.delegate = self;
    [_upView setBackgroundColor:[UIColor whiteColor]];
    [_upView setHidden:YES];
    [self.view addSubview:_upView];
    
    
}

- (void)createNavigationbar{
    _statusLab = [[UILabel alloc]initWithFrame:XFrame(Screen_W-IFAutoFitPx(150)-IFAutoFitPx(30), StatusBar_H+IFAutoFitPx(15), IFAutoFitPx(150), Navagtion_H-IFAutoFitPx(30))];
    [_statusLab setText:@"已停止营业"];
    [_statusLab setFont:XFont(13)];
    [_statusLab setBackgroundColor:IFThemeBlueColor];
    [_statusLab setTextColor:[UIColor whiteColor]];
    [_statusLab setTextAlignment:(NSTextAlignmentCenter)];
    [self.navigationView addSubview:_statusLab];
    XViewLayerCB(_statusLab, IFAutoFitPx(2), IFAutoFitPx(1), [UIColor whiteColor]);
    
}

- (void)JumpToShopset:(UIButton *)button{
    if (button.tag == 1001){
        ShopSetViewController *VC = [[ShopSetViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (button.tag == 1002){
        BusinessStatusViewController *VC = [[BusinessStatusViewController alloc]init];
        [self.navigationController pushViewController:VC animated:NO];
    }else if (button.tag == 1003){
        
    }else if (button.tag == 1004){
        
    }else if (button.tag == 1005){
        AccountSecurityViewController *VC = [[AccountSecurityViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (button.tag == 1006){
        [self.clearView setHidden:NO];
        [self.upView setHidden:NO];
    }else if (button.tag == 1007){
        RingSettingViewController *VC = [[RingSettingViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (button.tag == 1008){
        FeedbackViewController *VC = [[FeedbackViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

- (void)cancelCall:(UIButton *)sender{
    [_clearView setHidden:YES];
    [_upView setHidden:YES];
}

- (void)playCall:(UIButton *)sender{
    [_clearView setHidden:YES];
    [_upView setHidden:YES];
}

@end
