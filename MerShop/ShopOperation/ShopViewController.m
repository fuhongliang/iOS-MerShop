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

@interface ShopViewController ()<UITableViewDelegate,UITableViewDataSource,HeaderViewDelegate>
@property (nonatomic ,strong)HeaderView *headView;
@property (nonatomic ,strong)UITableView *tableview;
@property (nonatomic ,copy)NSArray *iconArr;
@property (nonatomic ,copy)NSArray *titleArr;
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"门店运营"];
    [self setHideBackBtn:YES];
    self.iconArr = @[@"find_ic_xszk",@"find_ic_mlj",@"find_ic_yhtc",@"find_ic_djq"];
    self.titleArr = @[@"限时折扣",@"满立减",@"优惠套餐",@"代金券管理"];
    [self setUI];
}

- (void)setUI{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil];
    HeaderView *view = [nib objectAtIndex:0];
    [view setBackgroundColor:IFThemeBlueColor];
    view.delegate = self;
    [view setFrame:XFrame(0, 0, Screen_W, 290)];

    _tableview = [[UITableView alloc]init];
    [_tableview setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [_tableview setDelegate:self];
    [_tableview setDataSource:self];
    [_tableview setBackgroundColor:LineColor];
    _tableview.tableHeaderView = view;
    _tableview.tableFooterView = [[UIView alloc]init];
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
    [self.navigationController pushViewController:vc animated:NO];
}

@end
