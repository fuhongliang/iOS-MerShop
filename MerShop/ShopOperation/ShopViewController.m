//
//  ShopViewController.m
//  MerShop
//
//  Created by mac on 2019/3/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ShopViewController.h"
#import "HeaderView.h"
#import "TableViewCell.h"
#import "GoodsManagementViewController.h"
#import "UserEvaluationViewController.h"
#import "ManageViewController.h"
#import "DiscountListViewController.h"
#import "FullReductionViewController.h"
#import "DiscountPackageViewController.h"
#import "CashCouponViewController.h"
#import "FinanceViewController.h"

@interface ShopViewController ()<UITableViewDelegate,UITableViewDataSource,HeaderViewDelegate>
@property (nonatomic ,strong)HeaderView *headView;
@property (nonatomic ,strong)UITableView *tableview;
@property (nonatomic ,copy)NSArray *iconArr;
@property (nonatomic ,copy)NSArray *titleArr;
@property (nonatomic ,copy)NSDictionary *storeData;
@property (nonatomic ,copy)NSString *DataUrl;
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"门店运营"];
    [self setHideBackBtn:YES];
    
    [self setUI];
    self.iconArr = @[@"find_ic_xszk",@"find_ic_mlj",@"find_ic_yhtc",@"find_ic_djq"];
    self.titleArr = @[@"限时折扣",@"满立减",@"优惠套餐",@"代金券管理"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)requestData{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger storeId = [[[userDefaults objectForKey:@"userInfo"] objectForKey:@"store_id"] integerValue];
    [Http_url POST:@"store_yunying" dict:@{@"store_id":@(storeId)} showHUD:NO WithSuccessBlock:^(id data) {
        if ([[data objectForKey:@"code"] integerValue] == 200){
            self.storeData = [[data objectForKey:@"data"] copy];
            [self.headView addStoreInfo:self.storeData];
        }
    } WithFailBlock:^(id data) {
        
    }];
}

- (void)setUI{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil];
    _headView = [nib objectAtIndex:0];
    [_headView setBackgroundColor:IFThemeBlueColor];
    _headView.delegate = self;
    [_headView setFrame:XFrame(0, ViewStart_Y, Screen_W, 278)];
    _tableview = [[UITableView alloc]init];
    [_tableview setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [_tableview setDelegate:self];
    [_tableview setDataSource:self];
    [_tableview setBackgroundColor:toPCcolor(@"#f5f5f5")];
    _tableview.scrollEnabled = NO;
    _tableview.tableHeaderView = _headView;
    _tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 1)];;
    [self.view addSubview:_tableview];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (!cell){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell.icon setImage:[UIImage imageNamed:self.iconArr[indexPath.row]]];
    [cell.title setText:self.titleArr[indexPath.row]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        DiscountListViewController *vc = [[DiscountListViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        FullReductionViewController *vc = [[FullReductionViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        DiscountPackageViewController *vc = [[DiscountPackageViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        CashCouponViewController *vc = [[CashCouponViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)category:(UIButton *)sender{
    GoodsManagementViewController *vc = [[GoodsManagementViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)evaluation:(UIButton *)sender{
    UserEvaluationViewController *vc = [[UserEvaluationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)managementData:(UIButton *)sender{
    ManageViewController *vc = [[ManageViewController alloc]init];
    vc.url = [NSString stringWithFormat:@"%@",[self.storeData objectForKey:@"jingying_url"]];
    vc.navTitle = @"经营数据";
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)finance:(UIButton *)sender{
    FinanceViewController *vc = [[FinanceViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}

@end
