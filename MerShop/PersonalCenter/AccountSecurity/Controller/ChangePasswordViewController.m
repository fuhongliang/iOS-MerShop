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
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"修改密码"];
    [self setUI];
    [self setupPlaceHolder];
}

- (void)setUI{
    _phoneLab = [[UILabel alloc]initWithFrame:XFrame(IFAutoFitPx(32),ViewStart_Y+IFAutoFitPx(40), IFAutoFitPx(300), IFAutoFitPx(60))];
    [_phoneLab setText:@"18888888"];
    [self.view addSubview:_phoneLab];
    
    _codeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_codeBtn setFrame:XFrame(Screen_W-IFAutoFitPx(204),ViewStart_Y+IFAutoFitPx(40), IFAutoFitPx(174), IFAutoFitPx(60))];
    [_codeBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [_codeBtn setTitleColor:IFThemeBlueColor forState:(UIControlStateNormal)];
    [_codeBtn.titleLabel setFont:XFont(14)];
    XViewLayerCB(_codeBtn, IFAutoFitPx(4), IFAutoFitPx(2), IFThemeBlueColor);
    [self.view addSubview:_codeBtn];
    
    _line1 = [[UIView alloc]initWithFrame:XFrame(IFAutoFitPx(32),CGRectGetMaxY(_phoneLab.frame)+IFAutoFitPx(40), Screen_W-IFAutoFitPx(30), IFAutoFitPx(2))];
    [_line1 setBackgroundColor:LineColor];
    [self.view addSubview:_line1];
    
    _codeText = [[UITextView alloc]initWithFrame:XFrame(IFAutoFitPx(32), CGRectGetMaxY(_line1.frame)+IFAutoFitPx(40), Screen_W-IFAutoFitPx(30), IFAutoFitPx(60))];
//    [_codeText setText:@"请输入6位数验证码"];
    _codeText.delegate = self;
    [self.view addSubview:_codeText];
    
    _line2 = [[UIView alloc]initWithFrame:XFrame(IFAutoFitPx(32),CGRectGetMaxY(_codeText.frame)+IFAutoFitPx(40), Screen_W-IFAutoFitPx(30), IFAutoFitPx(2))];
    [_line2 setBackgroundColor:LineColor];
    [self.view addSubview:_line2];
    
    _passWordText1 = [[UITextView alloc]initWithFrame:XFrame(IFAutoFitPx(32), CGRectGetMaxY(_line2.frame)+IFAutoFitPx(40), Screen_W-IFAutoFitPx(30), IFAutoFitPx(60))];
//    [_passWordText1 setText:@"请输入新密码"];
    _passWordText1.delegate = self;
    [self.view addSubview:_passWordText1];
    
    _line3 = [[UIView alloc]initWithFrame:XFrame(IFAutoFitPx(32),CGRectGetMaxY(_passWordText1.frame)+IFAutoFitPx(40), Screen_W-IFAutoFitPx(30), IFAutoFitPx(2))];
    [_line3 setBackgroundColor:LineColor];
    [self.view addSubview:_line3];
    
    _passWordText2 = [[UITextView alloc]initWithFrame:XFrame(IFAutoFitPx(32), CGRectGetMaxY(_line3.frame)+IFAutoFitPx(40), Screen_W-IFAutoFitPx(30), IFAutoFitPx(60))];
//    [_passWordText2 setText:@"请再次输入密码"];
    _passWordText2.delegate = self;
    [self.view addSubview:_passWordText2];
    
    _line4 = [[UIView alloc]initWithFrame:XFrame(IFAutoFitPx(32),CGRectGetMaxY(_passWordText2.frame)+IFAutoFitPx(40), Screen_W-IFAutoFitPx(30), IFAutoFitPx(2))];
    [_line4 setBackgroundColor:LineColor];
    [self.view addSubview:_line4];
    
    _tipsLab = [[UILabel alloc]initWithFrame:XFrame(IFAutoFitPx(32), CGRectGetMaxY(_line4.frame)+IFAutoFitPx(20), Screen_W-IFAutoFitPx(30), IFAutoFitPx(40))];
    [_tipsLab setText:@"新密码不能与原密码一样，密码：英文+数字+符号（大于6位）"];
    [_tipsLab setTextColor:GrayColor];
    [_tipsLab setFont:XFont(12)];
    [self.view addSubview:_tipsLab];
    
    _confirmBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_confirmBtn setFrame:XFrame(IFAutoFitPx(32), CGRectGetMaxY(_tipsLab.frame)+IFAutoFitPx(80), Screen_W-IFAutoFitPx(60), IFAutoFitPx(88))];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_confirmBtn setBackgroundColor:IFThemeBlueColor];
    [_confirmBtn setTitle:@"确认修改" forState:(UIControlStateNormal)];
    [_confirmBtn.titleLabel setFont:XFont(17)];
    _confirmBtn.layer.cornerRadius = IFAutoFitPx(6);
    _confirmBtn.layer.masksToBounds = YES;
    [self.view addSubview:_confirmBtn];
    
    
}

- (void)setupPlaceHolder
{
    UILabel *placeHolder1 = [[UILabel alloc] initWithFrame:XFrame(IFAutoFitPx(15), 0, Screen_W-IFAutoFitPx(60), IFAutoFitPx(60))];
    placeHolder1.text = @"请输入6位数验证码";
    placeHolder1.textColor = toPCcolor(@"#999999");
    self.placeHolder1 = placeHolder1;
    placeHolder1.font = XFont(17);
    placeHolder1.numberOfLines = 0;
    placeHolder1.contentMode = UIViewContentModeTop;
    [self.codeText addSubview:placeHolder1];
    
    UILabel *placeHolder2 = [[UILabel alloc] initWithFrame:XFrame(IFAutoFitPx(15), 0, Screen_W-IFAutoFitPx(60), IFAutoFitPx(60))];
    placeHolder2.text = @"请输入密码";
    placeHolder2.textColor = toPCcolor(@"#999999");
    self.placeHolder2 = placeHolder2;
    placeHolder2.font = XFont(17);
    placeHolder2.numberOfLines = 0;
    placeHolder2.contentMode = UIViewContentModeTop;
    [self.passWordText1 addSubview:placeHolder2];
    
    UILabel *placeHolder3 = [[UILabel alloc] initWithFrame:XFrame(IFAutoFitPx(15), 0, Screen_W-IFAutoFitPx(60), IFAutoFitPx(60))];
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

@end
