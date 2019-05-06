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

@interface AddBankCardController ()<FinishBankCardInfoDelegate>
@property (weak, nonatomic)FinishBankCardInfo *mainView;
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
}

- (void)finish{
    if (self.mainView.name.text.length == 0){
        [[IFUtils share]showErrorInfo:@"请输入姓名！"];
        return;
    }
    if (self.mainView.bankCardNumber.text.length == 0){
        [[IFUtils share]showErrorInfo:@"请输入银行卡号!"];
        return;
    }
    if (self.mainView.bankAddress.text.length == 0){
        [[IFUtils share]showErrorInfo:@"请输入开户支行地址！"];
        return;
    }
    if (self.mainView.bankType.text.length == 0){
        [[IFUtils share]showErrorInfo:@"请输入银行卡类型！"];
        return;
    }
    NSDictionary *dict = @{@"store_id":StoreIdString,
                           @"account_name":self.mainView.name.text,
                           @"account_number":self.mainView.bankCardNumber.text,
                           @"bank_name":self.mainView.bankAddress.text,
                           @"bank_type":self.mainView.bankType.text
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
@end
