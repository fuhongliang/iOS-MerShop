//
//  AddBankCardController.m
//  MerShop
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AddBankCardController.h"
#import "FinishBankCardInfo.h"
#import "SuccessViewController.h"

@interface AddBankCardController ()<FinishBankCardInfoDelegate,TimePickerViewDelegate>
@property (weak, nonatomic)FinishBankCardInfo *mainView;
@property (nonatomic ,strong)UIView *bgView;
@property (nonatomic ,weak)TimePickerView *pickerView;
@property (nonatomic ,copy)NSString *cardString;

@end

@implementation AddBankCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"添加银行卡"];
    [self.view setBackgroundColor:BackgroundColor];
    // 点击空白处收键盘
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    [self setUI];
}

#pragma mark --收起键盘
// 点击空白处收键盘
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

- (void)setUI{
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FinishBankCardInfo" owner:self options:nil];
    _mainView = [nib objectAtIndex:0];
    [_mainView setDelegate:self];
    [_mainView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [self.view addSubview:_mainView];
    
    _bgView = [[UIView alloc]init];
    [_bgView setBackgroundColor:[UIColor blackColor]];
    [_bgView setFrame:XFrame(0, 0, Screen_W, Screen_H)];
    [_bgView setAlpha:0.4];
    [_bgView setHidden:YES];
    [self.view addSubview:_bgView];
    
    NSArray *cardArr = @[@"工商银行",@"中国银行",@"建设银行",@"农业银行",@"交通银行",@"邮政银行",@"招商银行",@"平安银行"];
    NSArray *a = [[NSBundle mainBundle]loadNibNamed:@"TimePickerView" owner:self options:nil];
    self.pickerView = [a objectAtIndex:0];
    [self.pickerView setFrame:XFrame(0, Screen_H, Screen_W, 283)];
    self.pickerView.delegate = self;
    self.pickerView.titleStr = @"银行卡类型";
    self.pickerView.data = cardArr;
    [self.view addSubview:self.pickerView];
}

- (void)finish{
    if (self.mainView.name.text.length == 0){
        [[IFUtils share]showErrorInfo:@"请输入姓名！"];
        return;
    }
    if (self.mainView.bankCardNumber.text.length == 0){
        [[IFUtils share]showErrorInfo:@"请输入银行卡号！"];
        return;
    }
    if (self.mainView.bankCardNumber.text.length !=19 && self.mainView.bankCardNumber.text.length !=16){
        [[IFUtils share]showErrorInfo:@"银行卡号错误！"];
        return;
    }
    if (self.mainView.bankAddress.text.length == 0){
        [[IFUtils share]showErrorInfo:@"请输入开户支行地址！"];
        return;
    }
    if (kISNullString(self.cardString)){
        [[IFUtils share]showErrorInfo:@"请选择银行卡类型！"];
        return;
    }
    NSDictionary *dict = @{@"store_id":StoreIdString,
                           @"account_name":self.mainView.name.text,
                           @"account_number":self.mainView.bankCardNumber.text,
                           @"bank_name":self.mainView.bankAddress.text,
                           @"bank_type":self.cardString
                           };
    [Http_url POST:@"add_bank_account" dict:dict showHUD:NO WithSuccessBlock:^(id data) {
        if ([[data objectForKey:@"code"] integerValue] == 200){
            SuccessViewController *vc = [[SuccessViewController alloc]init];
            vc.titleDict = @{@"title":@"恭喜您绑定成功",
                             @"subTitle":@"系统将3秒后自动跳转至首页"
                             };
            [self.navigationController pushViewController:vc animated:YES];
        }
    } WithFailBlock:^(id data) {
        
    }];

}

- (void)chooseCard{
    [self.bgView setHidden:NO];
    [self.pickerView setHidden:NO];
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerView.frame = CGRectMake(0, Screen_H - 283, Screen_W, 283);
    }];
}

#pragma mark - NumberPickerViewDelegate
- (void)cancel{
    [self.bgView setHidden:YES];
    [self.pickerView setHidden:YES];
    [UIView animateWithDuration:0.3 animations:^{
        [self.pickerView setFrame:XFrame(0, Screen_H, Screen_W, 283)];
    }];
}

- (void)ensure:(id)data{
    [self.bgView setHidden:YES];
    [self.pickerView setHidden:YES];
    [self.mainView.cardType setTitleColor:toPCcolor(@"#000000") forState:(UIControlStateNormal)];
    self.cardString = data;
    [self.mainView.cardType setTitle:data forState:(UIControlStateNormal)];
    [UIView animateWithDuration:0.3 animations:^{
        [self.pickerView setFrame:XFrame(0, Screen_H, Screen_W, 283)];
    }];
}
@end
