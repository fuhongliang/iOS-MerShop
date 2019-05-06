//
//  FinanceViewController.m
//  MerShop
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "FinanceViewController.h"
#import "FinancialHeaderView.h"
#import "AllbillsViewController.h"
#import "BankCardViewController.h"
#import "GetMoneyController.h"
#import "AllBillsCell.h"
#import "FinancialCell.h"

@interface FinanceViewController ()<UITableViewDelegate,UITableViewDataSource,FinancialHeaderViewDelegate>
@property (nonatomic ,strong)UITableView *mainTableView;
@property (nonatomic ,weak)FinancialHeaderView *headerView;
@property (nonatomic ,copy)NSDictionary *account;
@property (nonatomic ,strong)NSMutableArray *dataArr;

@end

@implementation FinanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"财务结算"];
    [self.view setBackgroundColor:BackgroundColor];
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)requestData{
    [Http_url POST:@"store_jiesuan" dict:@{@"store_id":@(StoreId)} showHUD:NO WithSuccessBlock:^(id data) {
        NSLog(@"%@",data);
        if ([[data objectForKey:@"code"] integerValue] == 200){
            self.account = [data objectForKey:@"data"];
            self.dataArr = [data[@"data"][@"list"] mutableCopy];
            
            self.headerView.receiveMoney.text = [NSString stringWithFormat:@"%@",self.account[@"y_jiesuan"]];
            self.headerView.waitReceiveMoney.text = [NSString stringWithFormat:@"%@",self.account[@"d_jiesuan"]];
            
            NSString *bank_type = self.account[@"account"][@"bank_type"];
            NSString *cardStr = self.account[@"account"][@"account_number"];
            if (bank_type.length != 0 && cardStr.length != 0){//判断是否已添加银行卡
                NSString *str = [cardStr substringFromIndex:cardStr.length-4];
                self.headerView.bankCardBtn.text = [NSString stringWithFormat:@"%@(尾号%@)",bank_type,str];
            }else{
                self.headerView.bankCardBtn.text = @"请添加银行卡";
            }
            [self.mainTableView reloadData];
        }
    } WithFailBlock:^(id data) {
        
    }];
}

- (void)setUI{
    [self.view addSubview:self.mainTableView];
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FinancialHeaderView" owner:self options:nil];
    _headerView = [nib objectAtIndex:0];
    _headerView.delegate = self;
    [_headerView setFrame:XFrame(0, 0, Screen_W, 246)];
    [self.mainTableView setTableHeaderView:_headerView];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"规则说明" forState:(UIControlStateNormal)];
    [btn setTitleColor:WhiteColor forState:(UIControlStateNormal)];
    [btn setBackgroundColor:IFThemeBlueColor];
    [btn setImage:[UIImage imageNamed:@"icon_tixian_gz"] forState:(UIControlStateNormal)];
    [btn.titleLabel setFont:XFont(16)];
    [self.navigationView addSubview:btn];
    
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navigationView.right).offset(-15);
        make.top.equalTo(self.navigationView.top).offset(StatusBar_H);
        make.bottom.equalTo(self.navigationView.bottom).offset(0);
    }];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -btn.imageView.bounds.size.width-10, 0, btn.imageView.bounds.size.width)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.bounds.size.width, 0, -btn.titleLabel.bounds.size.width)];

    
}

#pragma mark - UITableviewDelegate
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //+1是因为全部账单那一行也是算在cell里
    return self.dataArr.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FinancialCell *cell1 = (FinancialCell *)[tableView dequeueReusableCellWithIdentifier:@"FinancialCell"];
    //全部账单的那一行cell
    AllBillsCell *cell2 = (AllBillsCell *)[tableView dequeueReusableCellWithIdentifier:@"AllBillsCell"];
    if (indexPath.row == 0){
        if (!cell2){
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AllBillsCell" owner:self options:nil];
            cell2 = [nib objectAtIndex:0];
        }
        return cell2;
    }else{
        if (!cell1){
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FinancialCell" owner:self options:nil];
            cell1 = [nib objectAtIndex:0];
        }
        //-1减去全部账单所占的一行
        [cell1 fillCellWithDict:self.dataArr[indexPath.row-1]];
        return cell1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        AllbillsViewController *vc = [[AllbillsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - FinancialHeaderViewDelegate
- (void)goBankCardView{
    BankCardViewController *vc = [[BankCardViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goGetMoneyView{
    GetMoneyController *vc = [[GetMoneyController alloc]init];
    vc.accountDict = self.account;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 懒加载
- (UITableView *)mainTableView{
    if (!_mainTableView){
        _mainTableView = [[UITableView alloc]init];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mainTableView setBackgroundColor:toPCcolor(@"#f5f5f5")];
        [_mainTableView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
        [_mainTableView setDelegate:self];
        [_mainTableView setDataSource:self];
        [_mainTableView setRowHeight:UITableViewAutomaticDimension];
    }
    return _mainTableView;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr){
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}
@end
