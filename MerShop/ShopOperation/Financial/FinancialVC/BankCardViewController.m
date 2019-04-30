//
//  BankCardViewController.m
//  MerShop
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BankCardViewController.h"
#import "AccountInfomationController.h"
#import "AddBankCardController.h"
#import "BankCardManageView.h"
#import "AddBankCardView.h"


@interface BankCardViewController ()<BankCardManageViewDelegate,AddBankCardViewDelegate>
@property (nonatomic ,strong)UITableView *mainTableview;
@property (nonatomic ,weak)BankCardManageView *bankview;
@property (nonatomic ,weak)AddBankCardView *addView;
@property (nonatomic ,strong)NSMutableArray *dataSource;
@end

@implementation BankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"银行卡管理"];
    [self.view setBackgroundColor:BackgroundColor];
    [self setUI];
    
}

- (void)setUI{
    [self.view addSubview:self.mainTableview];
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"BankCardManageView" owner:self options:nil];
    _bankview = [nib objectAtIndex:0];
    [_bankview setDelegate:self];
    [_bankview setFrame:XFrame(0, 0, Screen_W, Screen_H-ViewStart_Y)];
    
    NSArray *nib1 = [[NSBundle mainBundle]loadNibNamed:@"AddBankCardView" owner:self options:nil];
    _addView = [nib1 objectAtIndex:0];
    _addView.delegate = self;
    [_addView setFrame:XFrame(0, 0, Screen_W, Screen_H-ViewStart_Y)];
    [self.mainTableview setTableHeaderView:_addView];
}

- (void)checkAccountInfo{
    AccountInfomationController *vc = [[AccountInfomationController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addCard{
    AddBankCardController *vc = [[AddBankCardController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (UITableView *)mainTableview{
    if (!_mainTableview){
        _mainTableview = [[UITableView alloc]init];
        [_mainTableview setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    }
    return _mainTableview;
}
- (NSMutableArray *)dataSource{
    if (!_dataSource){
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
@end
