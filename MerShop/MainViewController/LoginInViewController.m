//
//  ViewController.m
//  MerShop
//
//  Created by mac on 2019/3/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LoginInViewController.h"
#import "TabBarController.h"
#import "AppDelegate.h"
#import "NavigationViewController.h"


@interface LoginInViewController ()<UITextViewDelegate>
@property (nonatomic ,strong)UITextField *accountText;
@property (nonatomic ,strong)UITextField *passWordText;
@end

@implementation LoginInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *logoImage = [[UIImageView alloc]initWithFrame:XFrame(IFAutoFitPx(30), IFAutoFitPx(230), IFAutoFitPx(96), IFAutoFitPx(96))];
    [logoImage setImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:logoImage];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:XFrame(CGRectGetMaxX(logoImage.frame)+IFAutoFitPx(32), IFAutoFitPx(250), Screen_W, IFAutoFitPx(46))];
    [titleLab setText:@"商户端"];
    [titleLab setTextAlignment:(NSTextAlignmentLeft)];
    [titleLab setTextColor:toPCcolor(@"#333333")];
    [titleLab setFont:XFont(24)];
    [self.view addSubview:titleLab];
    
    UILabel *welcomeLab = [[UILabel alloc]initWithFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(logoImage.frame)+IFAutoFitPx(120), Screen_W, IFAutoFitPx(54))];
    [welcomeLab setText:@"欢迎您!"];
    [welcomeLab setTextAlignment:(NSTextAlignmentLeft)];
    [welcomeLab setFont:XFont(28)];
    [welcomeLab setTextColor:toPCcolor(@"#000000")];
    [self.view addSubview:welcomeLab];
    
    UILabel *accountLab = [[UILabel alloc]initWithFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(welcomeLab.frame)+IFAutoFitPx(90), IFAutoFitPx(100), IFAutoFitPx(32))];
    [accountLab setText:@"账号"];
    [accountLab setFont:XFont(17)];
    [accountLab setTextColor:toPCcolor(@"#000000")];
    [self.view addSubview:accountLab];
    
    _accountText = [[UITextField alloc]initWithFrame:XFrame(CGRectGetMaxX(accountLab.frame)+IFAutoFitPx(20), CGRectGetMinY(accountLab.frame), Screen_W-IFAutoFitPx(186), IFAutoFitPx(32))];
    [_accountText setPlaceholder:@"请输入账号/手机号"];
    NSAttributedString *attributed1 = [[NSAttributedString alloc]initWithString:@"请输入账号/手机号" attributes:@{NSForegroundColorAttributeName:toPCcolor(@"#999999"), NSFontAttributeName:XFont(17)}];
    _accountText.attributedPlaceholder = attributed1;
    [self.view addSubview:_accountText];
    
    UIView *line1 = [[UIView alloc]initWithFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(accountLab.frame)+IFAutoFitPx(40), Screen_W-IFAutoFitPx(60), IFAutoFitPx(2))];
    [line1 setBackgroundColor:toPCcolor(@"#CCCCCC")];
    [self.view addSubview:line1];
    
    UILabel *passWord = [[UILabel alloc]initWithFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(line1.frame)+IFAutoFitPx(60), IFAutoFitPx(100), IFAutoFitPx(32))];
    [passWord setText:@"密码"];
    [passWord setFont:XFont(17)];
    [passWord setTextColor:toPCcolor(@"#000000")];
    [self.view addSubview:passWord];
    
    _passWordText = [[UITextField alloc]initWithFrame:XFrame(CGRectGetMaxX(passWord.frame)+IFAutoFitPx(20), CGRectGetMinY(line1.frame)+IFAutoFitPx(60), Screen_W-IFAutoFitPx(186), IFAutoFitPx(32))];
    [_passWordText setPlaceholder:@"请输入密码"];
    NSAttributedString *attribute2 = [[NSAttributedString alloc]initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:toPCcolor(@"#999999"), NSFontAttributeName:XFont(17)}];
    _passWordText.attributedPlaceholder = attribute2;
    [self.view addSubview:_passWordText];
    
    UIView *line2 = [[UIView alloc]initWithFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(passWord.frame)+IFAutoFitPx(40), Screen_W-IFAutoFitPx(60), IFAutoFitPx(2))];
    [line2 setBackgroundColor:toPCcolor(@"#CCCCCC")];
    [self.view addSubview:line2];
    
    UITextView *textView = [[UITextView alloc]initWithFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(line2.frame)+IFAutoFitPx(10), Screen_W-IFAutoFitPx(60), IFAutoFitPx(70))];
    textView.text = @"点击登录及表示同意商户端平台管理协议";
    textView.font = XFont(14);
    [self.view addSubview:textView];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:textView.text attributes:nil];
    [attributedString addAttribute:NSLinkAttributeName                             value:@"guanlixieyi" range:[[attributedString string]rangeOfString:@"商户端平台管理协议"]];
    [attributedString addAttribute:NSFontAttributeName value:XFont(14) range:NSMakeRange(0, 9)];
    [attributedString addAttribute:NSFontAttributeName value:XFont(14) range:NSMakeRange(9,9)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:toPCcolor(@"#666666") range:NSMakeRange(0,textView.text.length)];
    textView.attributedText = attributedString;
    textView.linkTextAttributes = @{NSForegroundColorAttributeName:IFThemeBlueColor};
    textView.delegate = self;
    textView.editable = NO;
    textView.scrollEnabled = NO;
    
    UIButton *login = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [login setTitle:@"登录" forState:(UIControlStateNormal)];
    [login setFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(textView.frame)+IFAutoFitPx(102), Screen_W-IFAutoFitPx(60), IFAutoFitPx(88))];
    [login setBackgroundColor:IFThemeBlueColor];
    [login.titleLabel setFont:XFont(17)];
    login.layer.cornerRadius = IFAutoFitPx(6);
    login.layer.masksToBounds = YES;
    [login.titleLabel setTextAlignment:(NSTextAlignmentCenter)];
    [login addTarget:self action:@selector(requestData) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:login];
    
}

- (void)requestData{
    if (self.accountText.text.length == 0){
        [[IFUtils share]showErrorInfo:@"请输入账号或手机号"];
        return;
    }else if (self.passWordText.text.length == 0){
        [[IFUtils share]showErrorInfo:@"请输入您的密码"];
        return;
    }
    NSDictionary *dic = @{@"member_name":self.accountText.text,
                          @"member_passwd":self.passWordText.text
                          };
    [Http_url POST:@"http://master.api.ifhu.cn/index.php/member_login" dict:dic showHUD:YES WithSuccessBlock:^(id data) {
        [self GotoMainTabBarVC];
    } WithFailBlock:^(id data) {
        
    }];

    
}

- (void)GotoMainTabBarVC{
    TabBarController *tabbar = [[TabBarController alloc]init];
    NavigationViewController *navi = [[NavigationViewController alloc]initWithRootViewController:tabbar];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [navi.navigationBar setHidden:YES];
    delegate.window.rootViewController = navi;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    if ([[URL scheme] isEqualToString:@"guanlixieyi"]){
        NSLog(@"管理协议");
        return NO;
    }
    return YES;
}




@end
