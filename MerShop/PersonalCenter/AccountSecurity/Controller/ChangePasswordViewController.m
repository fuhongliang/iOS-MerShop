//
//  ChangePasswordViewController.m
//  MerShop
//
//  Created by mac on 2019/3/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()<UITextViewDelegate>
@property (nonatomic ,strong)UILabel *phoneLab;
@property (nonatomic ,strong)UIButton *codeBtn;
@property (nonatomic ,strong)UIView *line1;
@property (nonatomic ,strong)UIView *line2;
@property (nonatomic ,strong)UIView *line3;
@property (nonatomic ,strong)UIView *line4;
@property (nonatomic ,strong)UITextView *codeText;
@property (nonatomic ,strong)UITextView *passWordText1;
@property (nonatomic ,strong)UITextView *passWordText2;
@property (nonatomic ,strong)UILabel *placeHolder1;
@property (nonatomic ,strong)UILabel *placeHolder2;
@property (nonatomic ,strong)UILabel *placeHolder3;
@property (nonatomic ,strong)UILabel *tipsLab;
@property (nonatomic ,strong)UIButton *confirmBtn;
@property (nonatomic ,assign)NSInteger phoneNumber;
@property (nonatomic ,copy)NSString *passWord;
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"修改密码"];
    NSDictionary *dict = [self getUserInfo];
    self.phoneNumber = [[dict objectForKey:@"member_mobile"] integerValue];
    self.passWord = [dict objectForKey:@""];
    [self.view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [self setUI];
    [self setupPlaceHolder];
}

- (NSDictionary *)getUserInfo{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    return [user objectForKey:@"userInfo"];
}

- (void)setUI{
    UIView *whiteBackGroundView = [[UIView alloc]init];
    [whiteBackGroundView setFrame:XFrame(0, ViewStart_Y, Screen_W, IFAutoFitPx(463))];
    [whiteBackGroundView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:whiteBackGroundView];
    
    _phoneLab = [[UILabel alloc]initWithFrame:XFrame(IFAutoFitPx(30),IFAutoFitPx(30), IFAutoFitPx(300), IFAutoFitPx(55))];
    [_phoneLab setText:[NSString stringWithFormat:@"%ld",self.phoneNumber]];
    [whiteBackGroundView addSubview:_phoneLab];
    
    _line1 = [[UIView alloc]initWithFrame:XFrame(IFAutoFitPx(30),CGRectGetMaxY(_phoneLab.frame)+IFAutoFitPx(30), Screen_W-IFAutoFitPx(30), IFAutoFitPx(1))];
    [_line1 setBackgroundColor:LineColor];
    [whiteBackGroundView addSubview:_line1];
    
    _codeText = [[UITextView alloc]initWithFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(_line1.frame)+IFAutoFitPx(30), Screen_W-IFAutoFitPx(30), IFAutoFitPx(55))];
    _codeText.keyboardType = UIKeyboardTypeNumberPad;
    _codeText.font = XFont(17);
    _codeText.delegate = self;
    [whiteBackGroundView addSubview:_codeText];
    
    _codeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_codeBtn setFrame:XFrame(Screen_W-IFAutoFitPx(204),CGRectGetMaxY(_line1.frame)+IFAutoFitPx(30), IFAutoFitPx(174), IFAutoFitPx(55))];
    [_codeBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [_codeBtn setTitleColor:IFThemeBlueColor forState:(UIControlStateNormal)];
    [_codeBtn.titleLabel setFont:XFont(14)];
    [_codeBtn addTarget:self action:@selector(getVerificationCode) forControlEvents:(UIControlEventTouchUpInside)];
    XViewLayerCB(_codeBtn, IFAutoFitPx(4), IFAutoFitPx(2), IFThemeBlueColor);
    [whiteBackGroundView addSubview:_codeBtn];
    
    _line2 = [[UIView alloc]initWithFrame:XFrame(IFAutoFitPx(30),CGRectGetMaxY(_codeText.frame)+IFAutoFitPx(30), Screen_W-IFAutoFitPx(30), IFAutoFitPx(1))];
    [_line2 setBackgroundColor:LineColor];
    [whiteBackGroundView addSubview:_line2];
    
    _passWordText1 = [[UITextView alloc]initWithFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(_line2.frame)+IFAutoFitPx(30), Screen_W-IFAutoFitPx(30), IFAutoFitPx(55))];
    _passWordText1.font = XFont(17);
    _passWordText1.delegate = self;
    [whiteBackGroundView addSubview:_passWordText1];
    
    _line3 = [[UIView alloc]initWithFrame:XFrame(IFAutoFitPx(30),CGRectGetMaxY(_passWordText1.frame)+IFAutoFitPx(30), Screen_W-IFAutoFitPx(30), IFAutoFitPx(1))];
    [_line3 setBackgroundColor:LineColor];
    [whiteBackGroundView addSubview:_line3];
    
    _passWordText2 = [[UITextView alloc]initWithFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(_line3.frame)+IFAutoFitPx(30), Screen_W-IFAutoFitPx(30), IFAutoFitPx(55))];
    _passWordText2.font = XFont(17);
    _passWordText2.delegate = self;
    [whiteBackGroundView addSubview:_passWordText2];
    
//    _line4 = [[UIView alloc]initWithFrame:XFrame(IFAutoFitPx(30),CGRectGetMaxY(_passWordText2.frame)+IFAutoFitPx(30), Screen_W-IFAutoFitPx(30), IFAutoFitPx(1))];
//    [_line4 setBackgroundColor:LineColor];
//    [whiteBackGroundView addSubview:_line4];
    
    _tipsLab = [[UILabel alloc]initWithFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(whiteBackGroundView.frame)+IFAutoFitPx(20), Screen_W-IFAutoFitPx(30), IFAutoFitPx(40))];
    [_tipsLab setText:@"新密码不能与原密码一致，密码长度至少6位"];
    [_tipsLab setTextColor:GrayColor];
    [_tipsLab setFont:XFont(13)];
    [self.view addSubview:_tipsLab];
    
    _confirmBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_confirmBtn setFrame:XFrame(IFAutoFitPx(32), CGRectGetMaxY(_tipsLab.frame)+IFAutoFitPx(80), Screen_W-IFAutoFitPx(60), IFAutoFitPx(88))];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_confirmBtn setBackgroundColor:IFThemeBlueColor];
    [_confirmBtn setTitle:@"确认修改" forState:(UIControlStateNormal)];
    [_confirmBtn.titleLabel setFont:XFont(17)];
    [_confirmBtn addTarget:self action:@selector(ensureChange) forControlEvents:(UIControlEventTouchUpInside)];
    _confirmBtn.layer.cornerRadius = IFAutoFitPx(6);
    _confirmBtn.layer.masksToBounds = YES;
    [self.view addSubview:_confirmBtn];
    
    
}

- (void)setupPlaceHolder
{
    UILabel *placeHolder1 = [[UILabel alloc] initWithFrame:XFrame(0, 0, Screen_W-IFAutoFitPx(60), IFAutoFitPx(60))];
    placeHolder1.text = @"请输入验证码";
    placeHolder1.textColor = toPCcolor(@"#999999");
    self.placeHolder1 = placeHolder1;
    placeHolder1.font = XFont(17);
    placeHolder1.numberOfLines = 0;
    placeHolder1.contentMode = UIViewContentModeTop;
    [self.codeText addSubview:placeHolder1];
    
    UILabel *placeHolder2 = [[UILabel alloc] initWithFrame:XFrame(0, 0, Screen_W-IFAutoFitPx(60), IFAutoFitPx(60))];
    placeHolder2.text = @"请输入密码";
    placeHolder2.textColor = toPCcolor(@"#999999");
    self.placeHolder2 = placeHolder2;
    placeHolder2.font = XFont(17);
    placeHolder2.numberOfLines = 0;
    placeHolder2.contentMode = UIViewContentModeTop;
    [self.passWordText1 addSubview:placeHolder2];
    
    UILabel *placeHolder3 = [[UILabel alloc] initWithFrame:XFrame(0, 0, Screen_W-IFAutoFitPx(60), IFAutoFitPx(60))];
    placeHolder3.text = @"请再次输入密码";
    placeHolder3.textColor = toPCcolor(@"#999999");
    self.placeHolder3 = placeHolder3;
    placeHolder3.font = XFont(17);
    placeHolder3.numberOfLines = 0;
    placeHolder3.contentMode = UIViewContentModeTop;
    [self.passWordText2 addSubview:placeHolder3];
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView == _codeText){
        if (!textView.text.length){
            self.placeHolder1.alpha = 1;
        }else{
            self.placeHolder1.alpha = 0;
        }
        
    }else if (textView == _passWordText1){
        if (!textView.text.length){
            self.placeHolder2.alpha = 1;
        }else{
            self.placeHolder2.alpha = 0;
        }
    }else{
        if (!textView.text.length){
            self.placeHolder3.alpha = 1;
        }else{
            self.placeHolder3.alpha = 0;
        }
    }
}

- (void)ensureChange{
    if (self.codeText.text.length != 4){
        [[IFUtils share]showErrorInfo:@"验证码不正确"];
        return;
    }else if (self.passWordText1.text.length <6 || self.passWordText1.text.length == 0){
        [[IFUtils share]showErrorInfo:@"密码格式不正确"];
        return;
    }else if (![self.passWordText1.text isEqualToString:self.passWordText2.text] || self.passWordText2.text.length == 0){
        [[IFUtils share]showErrorInfo:@"两次输入的密码不一致"];
        return;
    }
    NSDictionary *user = [self getUserInfo];
    NSString *memberid = [user objectForKey:@"member_id"];
    NSString *phone = [user objectForKey:@"member_mobile"];
    NSDictionary *dic = @{@"member_id":memberid,
                          @"phone_number":phone,
                          @"verify_code":self.codeText.text,
                          @"new_passwd":self.passWordText1.text,
                          @"con_new_passwd":self.passWordText2.text
                          };
    [Http_url POST:@"edit_passwd" dict:dic showHUD:YES WithSuccessBlock:^(id data) {
        NSInteger code = [[data objectForKey:@"code"] integerValue];
        
        if (code == 200){
            [[IFUtils share]showErrorInfo:@"修改成功"];
        }
        
    } WithFailBlock:^(id data) {
        
    }];
}

- (void)getVerificationCode{
    [self requestVerificationCode];
    [self createTimer];
}

- (void)requestVerificationCode{
    [Http_url POST:@"get_sms" dict:@{@"phone_number":@(self.phoneNumber)} showHUD:YES WithSuccessBlock:^(id data) {
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
                
                weakSelf.codeBtn.userInteractionEnabled = YES;
                
                [weakSelf.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
        }else {
            
            //处于正在倒计时，在主线程中刷新button上的title，时间-1秒
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString * title = [NSString stringWithFormat:@"%d秒",timeout];
                
                [weakSelf.codeBtn setUserInteractionEnabled:NO];
                
                [weakSelf.codeBtn setTitle:title forState:UIControlStateNormal];
            });
        }
    });
    
    dispatch_resume(timer);
}

@end
