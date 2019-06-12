//
//  AccountInfomationController.m
//  MerShop
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AccountInfomationController.h"
#import "AccountInfoView.h"

@interface AccountInfomationController ()
@property (nonatomic ,weak)AccountInfoView *accountView;
@end

@implementation AccountInfomationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"账户信息"];
    [self.view setBackgroundColor:BackgroundColor];
    [self setUI];
    [self requestData];
}

- (void)setUI{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AccountInfoView" owner:self options:nil];
    _accountView = [nib objectAtIndex:0];
    [_accountView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [self.view addSubview:_accountView];
}

- (void)requestData{
    [Http_url POST:@"bank_account_info" dict:@{@"store_id":@(StoreId)} showHUD:NO WithSuccessBlock:^(id data) {
        if ([[data objectForKey:@"code"] integerValue] == 200){
            NSDictionary *dict = data[@"data"];
            self.accountView.accountNumber.text = dict[@"account_number"];
            self.accountView.accountName.text = dict[@"account_name"];
            self.accountView.accountType.text = dict[@"bank_type"];
            self.accountView.bankBranch.text = dict[@"bank_name"];
        }
    } WithFailBlock:^(id data) {
        
    }];
}

@end
