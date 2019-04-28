//
//  CashCouponViewController.m
//  MerShop
//
//  Created by mac on 2019/4/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CashCouponViewController.h"
#import "CashCouponTableViewCell.h"
#import "EditeCashCouponViewController.h"
#import "CouponModel.h"


@interface CashCouponViewController ()<UITableViewDelegate ,UITableViewDataSource,CashCouponTableViewCellDelegate>
@property (nonatomic ,strong)UITableView *mainTableView;
@property (nonatomic ,strong)NSMutableArray *dataSource;
@property (nonatomic ,copy)NSArray *dataArr;
@end

@implementation CashCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"代金券管理"];
    [self.view setBackgroundColor:WhiteColor];
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self requestListData];
}

- (void)requestListData{
    [Http_url POST:@"voucher_list" dict:@{@"store_id":StoreIdString} showHUD:NO WithSuccessBlock:^(id data) {
        self.dataArr = [data objectForKey:@"data"];
        if (![self.dataArr isEqual:[NSNull null]]){
            [self.dataSource removeAllObjects];
            for (NSDictionary *dict in self.dataArr){
                CouponModel *model = [[CouponModel alloc]initWithDictionary:dict error:nil];
                [self.dataSource addObject:model];
            }
            [self.mainTableView reloadData];
        }
        
    } WithFailBlock:^(id data) {
        
    }];
}

- (void)setUI{
    [self.view addSubview:self.mainTableView];
    
    UIView *view = [[UIView alloc]init];
    [view setFrame:XFrame(0, CGRectGetMaxY(_mainTableView.frame), Screen_W, IFAutoFitPx(96))];
    [view setBackgroundColor:WhiteColor];
    [self.view addSubview:view];
    
    UIView *line = [[UIView alloc]init];
    [line setFrame:XFrame(0, 0, Screen_W, IFAutoFitPx(1))];
    [line setBackgroundColor:LineColor];
    [view addSubview:line];
    
    ZJTopImageBottomTitleButton *btn = [[ZJTopImageBottomTitleButton alloc]init];
    [btn setFrame:XFrame((Screen_W-IFAutoFitPx(200))/2, IFAutoFitPx(10), IFAutoFitPx(200), IFAutoFitPx(80))];
    [btn setTitle:@"添加活动" forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:@"yhq_addhuodong"] forState:(UIControlStateNormal)];
    [btn setTitleColor:IFThemeBlueColor forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(addActivity) forControlEvents:(UIControlEventTouchUpInside)];
    [btn setBackgroundColor:WhiteColor];
    [btn.titleLabel setFont:XFont(11)];
    [view addSubview:btn];

}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CashCouponTableViewCell *cell = (CashCouponTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CashCouponTableViewCell"];
    if (!cell){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CashCouponTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    CouponModel *model = self.dataSource[indexPath.row];
    cell.delegate = self;
    cell.tag = indexPath.row;
    [cell setDataWithModel:model];
    return cell;
}

- (void)addActivity{
    EditeCashCouponViewController *vc = [[EditeCashCouponViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - CashCouponTableViewCellDelegate 删除 & 编辑
/**
 编辑按钮代理方法
 */
- (void)editeAction:(id)data{
    CashCouponTableViewCell *cell = (CashCouponTableViewCell *)data;
    EditeCashCouponViewController *vc = [[EditeCashCouponViewController alloc]init];
    vc.lastVCDict = self.dataArr[cell.tag];
    [self.navigationController pushViewController:vc animated:YES];
}
/**
 删除按钮代理方法
 */
- (void)deleteAction:(id)data{
    CashCouponTableViewCell *cell = (CashCouponTableViewCell *)data;
    CouponModel *model = self.dataSource[cell.tag];
    NSDictionary *dict = @{@"store_id":@(StoreId),
                           @"voucher_id":@(model.voucher_id)
                           };
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定删除该活动吗？" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [Http_url POST:@"voucher_del" dict:dict showHUD:NO WithSuccessBlock:^(id data) {
            if ([[data objectForKey:@"code"] integerValue] == 200){
                [[IFUtils share]showErrorInfo:@"删除成功"];
                [self.dataSource removeObjectAtIndex:cell.tag];
                [self.mainTableView reloadData];
            }
        } WithFailBlock:^(id data) {
            
        }];
    }]];
    [self presentViewController:alert animated:YES completion:nil];


}
#pragma mark - 懒加载
- (UITableView *)mainTableView{
    if (!_mainTableView){
        _mainTableView = [[UITableView alloc]init];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mainTableView setBackgroundColor:toPCcolor(@"#f5f5f5")];
        if (IPHONE_X == YES){
            [_mainTableView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y-IFAutoFitPx(96)-34)];
        }else{
            [_mainTableView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y-IFAutoFitPx(96))];
        }
        [_mainTableView setDelegate:self];
        [_mainTableView setDataSource:self];
        [_mainTableView setRowHeight:UITableViewAutomaticDimension];
    }
    return _mainTableView;
}
- (NSMutableArray *)dataSource{
    if (!_dataSource){
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
@end
