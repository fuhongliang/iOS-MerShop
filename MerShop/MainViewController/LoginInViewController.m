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



@interface LoginInViewController ()<LoginViewDelegate,UITextFieldDelegate>

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
    
    _loginview.userNameText.delegate = self;
    _loginview.passWordText.delegate = self;
    [self.view addSubview:_loginview];
    
}

#pragma mark - 键盘代理方法
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (kISNullString(_loginview.userNameText.text) || kISNullString(_loginview.passWordText.text)){
        [_loginview.loginBtn setBackgroundColor:toPCcolor(@"#e5e5e5")];
        [_loginview.loginBtn setUserInteractionEnabled:NO];
    }else{
        [_loginview.loginBtn setBackgroundColor:toPCcolor(@"#1c98f6")];
        [_loginview.loginBtn setUserInteractionEnabled:YES];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.loginview.userNameText){
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.loginview.userNameText.text.length >= 11) {
            self.loginview.userNameText.text = [textField.text substringToIndex:11];
            return NO;
        }
    }
    return YES;
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
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *deviceTokenStr;
    if (kISNullString(delegate.token)){
        deviceTokenStr = @"a01764f368dccf2a370379f4f908bb1a652a302ced516840077c15e958370bf7";
    }else{
        deviceTokenStr = delegate.token;
    }
    NSDictionary *dic = @{@"member_name":_loginview.userNameText.text,
                          @"member_passwd":_loginview.passWordText.text,
                          @"app_type":@(2),
                          @"device_tokens":deviceTokenStr
                          };
    [Http_url POST:@"member_login" dict:dic showHUD:YES WithSuccessBlock:^(id data) {
        
        NSString *urlStr = [[data objectForKey:@"data"] objectForKey:@"joinin_url"];
        if (kISNullString(urlStr)){
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
        }else{
            ManageViewController *vc = [[ManageViewController alloc]init];
            vc.url = urlStr;
            vc.navTitle = @"";
            [self.navigationController pushViewController:vc animated:YES];

        }

    } WithFailBlock:^(id data) {
        
    }];
    
}
/**
    管理协议代理方法
 */
- (void)protocol{
    BluetoothHelpViewController *vc = [[BluetoothHelpViewController alloc]init];
    vc.htmlName = @"protocol";
    vc.navTitle = @"用户协议";
    [self.navigationController pushViewController:vc animated:YES];
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
