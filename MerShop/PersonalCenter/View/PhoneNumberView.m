//
//  PhoneNumberView.m
//  MerShop
//
//  Created by mac on 2019/3/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "PhoneNumberView.h"


@implementation PhoneNumberView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    _titleLab = [[UILabel alloc]init];
    [_titleLab setFrame:XFrame(IFAutoFitPx(210), IFAutoFitPx(58), IFAutoFitPx(140), IFAutoFitPx(34))];
    [_titleLab setFont:XFont(18)];
    [_titleLab setText:@"客服电话"];
    [_titleLab setTextAlignment:(NSTextAlignmentCenter)];
    [self addSubview:_titleLab];
    
    _numberLab = [[UILabel alloc]init];
    [_numberLab setFrame:XFrame(IFAutoFitPx(173), CGRectGetMaxY(_titleLab.frame)+IFAutoFitPx(36), IFAutoFitPx(216), IFAutoFitPx(24))];
    [_numberLab setFont:XFont(15)];
    [_numberLab setText:@"110-1234567"];
    [_numberLab setTextColor:GrayColor];
    [_numberLab setTextAlignment:(NSTextAlignmentCenter)];
    [self addSubview:_numberLab];
    
    _cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_cancelBtn setFrame:XFrame(0, IFAutoFitPx(292)-IFAutoFitPx(100), IFAutoFitPx(560)/2, IFAutoFitPx(100))];
    [_cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [_cancelBtn setTitleColor:BlackColor forState:(UIControlStateNormal)];
    XViewLayerCB(_cancelBtn, 0, IFAutoFitPx(1), LineColor);
    [_cancelBtn addTarget:self action:@selector(cancel) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_cancelBtn];
    
    _confirmBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_confirmBtn setFrame:XFrame(CGRectGetMaxX(_cancelBtn.frame), IFAutoFitPx(292)-IFAutoFitPx(100), IFAutoFitPx(560)/2, IFAutoFitPx(100))];
    [_confirmBtn setTitle:@"联系客服" forState:(UIControlStateNormal)];
    [_confirmBtn setTitleColor:IFThemeBlueColor forState:(UIControlStateNormal)];
    XViewLayerCB(_confirmBtn, 0, IFAutoFitPx(1), LineColor);
    [_confirmBtn addTarget:self action:@selector(call) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_confirmBtn];
    
}

- (void)cancel{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelCall:)]){
        [self.delegate performSelector:@selector(cancelCall:) withObject:nil];
    }
}

- (void)call{
    if (self.delegate && [self.delegate respondsToSelector:@selector(playCall:)]){
        [self.delegate performSelector:@selector(playCall:) withObject:nil];
    }
}

@end
