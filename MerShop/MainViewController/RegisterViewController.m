//
//  RegisterViewController.m
//  MerShop
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RegisterViewController.h"
#import "Registview.h"

@interface RegisterViewController ()<RegistviewDelegate>

@property (nonatomic ,strong)Registview *registView;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 点击空白处收键盘
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Registview" owner:self options:nil];
    _registView = [nib objectAtIndex:0];
    _registView.delegate = self;
    [_registView setFrame:XFrame(0, 0, Screen_W, Screen_H)];
    [self.view addSubview:_registView];
}

#pragma mark --收起键盘
// 点击空白处收键盘
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

#pragma mark - RegistViewDelegate
/**
    获取验证码代理方法
 */
- (void)getCode{
    [self requestVerificationCode];
    [self createTimer];
}
/**
    注册协议代理方法
 */
- (void)protocol{
    
    
}
/**
    注册按钮代理方法
 */
- (void)registUser{
    if (_registView.userName.text.length == 0){
        [[IFUtils share]showErrorInfo:@"请输入手机号"];
        return;
    }
    if (_registView.passWord.text.length == 0){
        [[IFUtils share]showErrorInfo:@"请输入密码"];
        return;
    }
    if (_registView.verificationCode.text.length == 0){
        [[IFUtils share]showErrorInfo:@"请输入验证码"];
        return;
    }
    NSDictionary *dict = @{@"mobile":_registView.userName.text,
                           @"password":_registView.passWord.text,
                           @"verify_code":_registView.verificationCode.text
                           };
    [Http_url POST:@"member_register" dict:dict showHUD:YES WithSuccessBlock:^(id data) {
        if ([[data objectForKey:@"code"] integerValue] == 200){
            [[IFUtils share]showErrorInfo:@"注册成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } WithFailBlock:^(id data) {
        
    }];
    
}
/**
    返回按钮代理方
 */
- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
    获取验证码
 */
- (void)requestVerificationCode{
    NSInteger phoneNumber = [self.registView.userName.text integerValue];
    [Http_url POST:@"get_sms" dict:@{@"phone_number":@(phoneNumber)} showHUD:YES WithSuccessBlock:^(id data) {
        if ([[data objectForKey:@"code"] integerValue] ==200){
            NSLog(@"获取成功");
        }
    } WithFailBlock:^(id data) {
        
    }];
}

#pragma mark - 定时器 (GCD)
- (void)createTimer {
    
    //设置倒计时时间
    //__block 如果修饰指针时，指针相当于弱引用，指针对指向的对象不产生引用计数的影响
    __block int timeout = 60;
    
    //获取全局队列
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //创建一个定时器，并将定时器的任务交给全局队列执行(并行，不会造成主线程阻塞)
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, global);
    
    // 设置触发的间隔时间
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //1.0 * NSEC_PER_SEC  代表设置定时器触发的时间间隔为1s
    //0 * NSEC_PER_SEC    代表时间允许的误差是 0s
    
    //block内部 如果对当前对象的强引用属性修改 应该使用__weak typeof(self)weakSelf 修饰  避免循环调用
    __weak typeof(self)weakSelf = self;
    //设置定时器的触发事件
    dispatch_source_set_event_handler(timer, ^{
        
        //倒计时  刷新button上的title ，当倒计时时间为0时，结束倒计时
        
        //1. 每调用一次 时间-1s
        timeout --;
        
        //2.对timeout进行判断时间是停止倒计时，还是修改button的title
        if (timeout <= 0) {
            
            //停止倒计时，button打开交互，背景颜色还原，title还原
            
            //关闭定时器
            dispatch_source_cancel(timer);
            
            //MRC下需要释放，这里不需要
            //            dispatch_realse(timer);
            
            //button上的相关设置
            //注意: button是属于UI，在iOS中多线程处理时，UI控件的操作必须是交给主线程(主队列)
            //在主线程中对button进行修改操作
            dispatch_async(dispatch_get_main_queue(), ^{
                
                weakSelf.registView.codeBtn.userInteractionEnabled = YES;
                
                [weakSelf.registView.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
        }else {
            
            //处于正在倒计时，在主线程中刷新button上的title，时间-1秒
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString * title = [NSString stringWithFormat:@"%d秒",timeout];
                
                [weakSelf.registView.codeBtn setUserInteractionEnabled:NO];
                
                [weakSelf.registView.codeBtn setTitle:title forState:UIControlStateNormal];
            });
        }
    });
    
    dispatch_resume(timer);
}
@end
