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
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "LoginInViewController.h"
#import "NavigationViewController.h"



@interface MeViewController ()<BackgroundViewDelegate>
@property (nonatomic ,strong)UIView *clearView;
@property (nonatomic ,strong)PhoneNumberView *upView;
@property (nonatomic ,strong)UILabel *statusLab;
@property (nonatomic ,strong)BackgroundView *bgView;
@end

@implementation MeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    NSDictionary *userDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSInteger store_state = [[userDict objectForKey:@"store_state"] integerValue];
    [self.bgView setMyInformation:[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"]];
    if (store_state == 1){
        [_statusLab setText:@"正在营业"];
    }else{
        [_statusLab setText:@"已停止营业"];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNaviTitle:@"个人中心"];
    [self setHideBackBtn:YES];
    [self createNavigationbar];
    self.bgView = [[BackgroundView alloc]initWithFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y-Tabbar_H)];
    self.bgView.delegate = self;
    NSString *imageStr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"] objectForKey:@"store_avatar"];
    [self.bgView.headImage sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"moren_dianpu"]];
    [self.bgView setMyInformation:[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"]];
    [self.bgView setBackgroundColor:IFThemeBlueColor];
    [self.view addSubview:self.bgView];
    
    id data = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSLog(@"%@",data);
    
}

- (void)createNavigationbar{
    _statusLab = [[UILabel alloc]initWithFrame:XFrame(Screen_W-IFAutoFitPx(148)-IFAutoFitPx(30), StatusBar_H+IFAutoFitPx(15), IFAutoFitPx(148), Navagtion_H-IFAutoFitPx(30))];
    [_statusLab setFont:XFont(12)];
    [_statusLab setBackgroundColor:IFThemeBlueColor];
    [_statusLab setTextColor:[UIColor whiteColor]];
    [_statusLab setTextAlignment:(NSTextAlignmentCenter)];
    [self.navigationView addSubview:_statusLab];
    XViewLayerCB(_statusLab, IFAutoFitPx(6), IFAutoFitPx(1), [UIColor whiteColor]);
    
}

- (void)JumpToShopset:(UIButton *)button{
    if (button.tag == 1001){
        ShopSetViewController *VC = [[ShopSetViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (button.tag == 1002){
        BusinessStatusViewController *VC = [[BusinessStatusViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (button.tag == 1003){
        
    }else if (button.tag == 1004){
        
    }else if (button.tag == 1005){
        AccountSecurityViewController *VC = [[AccountSecurityViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (button.tag == 1006){
        [self showAlertView];
    }else if (button.tag == 1007){
        RingSettingViewController *VC = [[RingSettingViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (button.tag == 1008){
        FeedbackViewController *VC = [[FeedbackViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

- (void)showAlertView{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"客服电话" message:@"18825110997" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"联系客服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"18825110997"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    
    //修改title字体
    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:@"客服电话"];
    [alertControllerStr addAttribute:NSForegroundColorAttributeName value:toPCcolor(@"#000000") range:NSMakeRange(0, 4)];
    [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, 4)];
    [alertController setValue:alertControllerStr forKey:@"attributedTitle"];
    
    //修改message
    NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:@"18825110997"];
    [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:toPCcolor(@"#999999") range:NSMakeRange(0, 11)];
    [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 11)];
    [alertController setValue:alertControllerMessageStr forKey:@"attributedMessage"];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)SignOut{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认退出吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfo"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"classArray"];
        LoginInViewController *loginVC = [[LoginInViewController alloc]init];
        NavigationViewController *navi = [[NavigationViewController alloc]initWithRootViewController:loginVC];
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        delegate.window.rootViewController = navi;
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [self presentViewController:alertController animated:YES completion:nil];

}


@end
