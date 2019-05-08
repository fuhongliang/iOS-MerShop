//
//  GetMoneyController.m
//  MerShop
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "GetMoneyController.h"
#import "GetMoneyView.h"
#import "SuccessViewController.h"
#import "AddBankCardController.h"

@interface GetMoneyController ()<GetMoneyViewDelegate>
@property (weak, nonatomic)GetMoneyView *mainview;
@end

@implementation GetMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 点击空白处收键盘
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    [self setNaviTitle:@"提现"];
    [self.view setBackgroundColor:BackgroundColor];
    [self setUI];
}

#pragma mark --收起键盘
// 点击空白处收键盘
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

- (void)setUI{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"GetMoneyView" owner:self options:nil];
    _mainview = [nib objectAtIndex:0];
    [_mainview setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    _mainview.delegate = self;
    if (![self.accountDict[@"account"][@"bank_type"] isEqualToString:@""]){
        NSString *cardNumber = self.accountDict[@"account"][@"account_number"];

        NSString *cashStr = [NSString stringWithFormat:@"可提现金额 ¥ %@",self.accountDict[@"y_jiesuan"]];

        _mainview.accountType.text = self.accountDict[@"account"][@"bank_type"];
        _mainview.lastFourNumber.text = [NSString stringWithFormat:@"尾号%@储蓄卡",[cardNumber substringFromIndex:cardNumber.length-4]];
        _mainview.canGetLabel.text = cashStr;
        [_mainview.addCardBtn setHidden:YES];
    }else{
        [_mainview.accountType setHidden:YES];
        [_mainview.lastFourNumber setHidden:YES];
    }

    [self.view addSubview:_mainview];
    
}


#pragma mark - GetMoneyViewDelegate
- (void)addBankCard{
    AddBankCardController *vc = [[AddBankCardController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
/**
    全部提现按钮代理方
 
 */
- (void)allGet{
    self.mainview.moneyText.text = [NSString stringWithFormat:@"%@",self.accountDict[@"y_jiesuan"]];
}

/**
    确认提现代理方法

 */
- (void)ensureGet{
    if (self.mainview.moneyText.text.length == 0){
        [[IFUtils share]showErrorInfo:@"请输入提现金额"];
        return;
    }
    if ([self.mainview.moneyText.text isEqualToString:@"0"]){
        [[IFUtils share]showErrorInfo:@"提现金额不能为0"];
        return;
    }
    NSDictionary *dict = @{@"store_id":StoreIdString,
                           @"money":self.mainview.moneyText.text
                           };
    [Http_url POST:@"pd_cash_add" dict:dict showHUD:NO WithSuccessBlock:^(id data) {
        if ([[data objectForKey:@"code"] integerValue] == 200){
            SuccessViewController *successVC = [[SuccessViewController alloc]init];
            successVC.titleDict = @{@"title":@"提现申请提交成功",
                                   @"subTitle":@"提现后24小时到账，若未及时到账请联系客服人员"
                                   };
            [self.navigationController pushViewController:successVC animated:YES];
        }
    } WithFailBlock:^(id data) {
        
    }];
}
@end
