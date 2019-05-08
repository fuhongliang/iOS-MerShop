//
//  ViewController.m
//  MerShop
//
//  Created by mac on 2019/3/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LoginInViewController.h"
#import "RegisterViewController.h"
#import "TabBarController.h"
#import "AppDelegate.h"
#import "NavigationViewController.h"
#import "LoginView.h"



@interface LoginInViewController ()<LoginViewDelegate>

@property (nonatomic ,strong)LoginView *loginview;

@end

@implementation LoginInViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // 点击空白处收键盘
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LoginView" owner:self options:nil];
    _loginview = [nib objectAtIndex:0];
    _loginview.delegate = self;
    [_loginview setFrame:XFrame(0, 0, Screen_W, Screen_H)];
    [self.view addSubview:_loginview];
    
}

#pragma mark --收起键盘
// 点击空白处收键盘
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

/**
    登录代理方法
 */
- (void)login{
    if (_loginview.userNameText.text.length == 0){
        [[IFUtils share]showErrorInfo:@"请输入账号或手机号"];
        return;
    }else if (_loginview.passWordText.text.length == 0){
        [[IFUtils share]showErrorInfo:@"请输入您的密码"];
        return;
    }
    NSDictionary *dic = @{@"member_name":_loginview.userNameText.text,
                          @"member_passwd":_loginview.passWordText.text
                          };
    [Http_url POST:@"member_login" dict:dic showHUD:YES WithSuccessBlock:^(id data) {
        NSMutableDictionary *userInfoDict = [[NSMutableDictionary alloc]initWithDictionary:[data objectForKey:@"data"]];
        NSArray *arr = [userInfoDict allKeys];
        for (NSString *key in arr){
            if ([[userInfoDict objectForKey:key] isKindOfClass:[NSNull class]]){
                [userInfoDict setObject:@"" forKey:key];
            }
        }
        NSLog(@"%@",userInfoDict);
        if (userInfoDict){
            [IFUserDefaults setObject:userInfoDict forKey:@"userInfo"];
            [IFUserDefaults synchronize];
        }
        [self GotoMainTabBarVC];
    } WithFailBlock:^(id data) {
        
    }];
    
}
/**
    管理协议代理方法
 */
- (void)protocol{
    
}
/**
    注册代理方法
 */
- (void)registerUser{
    RegisterViewController *vc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)GotoMainTabBarVC{
    TabBarController *tabbar = [[TabBarController alloc]init];
    [tabbar setSelectedIndex:0];
    NavigationViewController *navi = [[NavigationViewController alloc]initWithRootViewController:tabbar];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = navi;
}


@end
