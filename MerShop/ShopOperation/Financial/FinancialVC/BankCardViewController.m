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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)setUI{
    [self.view addSubview:self.mainTableview];
}

- (void)requestData{
    [Http_url POST:@"bank_account_list" dict:@{@"store_id":@(StoreId)} showHUD:NO WithSuccessBlock:^(id data) {
        
        if ([[data objectForKey:@"code"] integerValue] == 200){
            NSDictionary *dict = [data[@"data"] copy];
            if ([dict[@"bank_type"] isEqualToString:@""]){
                NSArray *nib1 = [[NSBundle mainBundle]loadNibNamed:@"AddBankCardView" owner:self options:nil];
                self.addView = [nib1 objectAtIndex:0];
                self.addView.delegate = self;
                [self.addView setFrame:XFrame(0, 0, Screen_W, Screen_H-ViewStart_Y)];
                
                [self.mainTableview setTableHeaderView:self.addView];
            }else{
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"BankCardManageView" owner:self options:nil];
                self.bankview = [nib objectAtIndex:0];
                [self.bankview setDelegate:self];
                [self.bankview setFrame:XFrame(0, 0, Screen_W, Screen_H-ViewStart_Y)];
                self.bankview.bankType.text = dict[@"bank_type"];
                self.bankview.name.text = dict[@"account_name"];
                NSString *cardnum = dict[@"account_number"];
                self.bankview.lastFour.text = [cardnum substringFromIndex:cardnum.length-4];
                [self.mainTableview setTableHeaderView:self.bankview];
                
                
            }
        }
        
    } WithFailBlock:^(id data) {
        
    }];
}


/**
    跳转银行卡详情
 */
- (void)checkAccountInfo{
    AccountInfomationController *vc = [[AccountInfomationController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
    当没有绑定银行卡时添加银行卡
 */
- (void)addCard{
    AddBankCardController *vc = [[AddBankCardController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
    解绑银行卡
 */
- (void)deleteAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定解除该银行卡？" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [Http_url POST:@"del_bank_account" dict:@{@"store_id":@(StoreId)} showHUD:NO WithSuccessBlock:^(id data) {
            if ([[data objectForKey:@"code"] integerValue] == 200){
                [[IFUtils share]showErrorInfo:@"解除成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } WithFailBlock:^(id data) {
            
        }];
    }]];
    [self presentViewController:alert animated:YES completion:nil];

}
#pragma mark - 懒加载
- (UITableView *)mainTableview{
    if (!_mainTableview){
        _mainTableview = [[UITableView alloc]init];
        _mainTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
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
