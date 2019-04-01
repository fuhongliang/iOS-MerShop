//
//  ManageCatergoryViewController.m
//  MerShop
//
//  Created by mac on 2019/3/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ManageCatergoryViewController.h"
#import "ManageCatergoryTableViewCell.h"
#import "SortViewController.h"
#import "CreateNewGoodsViewController.h"
#import "NewCatergoryViewController.h"

@interface ManageCatergoryViewController ()<UITableViewDelegate,UITableViewDataSource,ManageCatergoryTableViewCellDelegate>
@property (nonatomic ,strong)UITableView *tableview;
@property (nonatomic ,strong)UIButton *bottomBtn1;
@property (nonatomic ,strong)UIButton *bottomBtn2;
@property (nonatomic ,strong)NSMutableArray *dataSource;

@end

@implementation ManageCatergoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"管理分类"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSArray *arr = [user objectForKey:@"classArray"];
    [self.dataSource addObjectsFromArray:arr];
    [self.tableview reloadData];
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)setUI{
    _tableview = [[UITableView alloc]initWithFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y-IFAutoFitPx(108))];
    [_tableview setBackgroundColor:LineColor];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableview];
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:XFrame(0, CGRectGetMaxY(_tableview.frame), Screen_W, IFAutoFitPx(108))];
    [backgroundView setBackgroundColor:[UIColor whiteColor]];
    XViewLayerCB(backgroundView, 0, 0.5, LineColor);
    [self.view addSubview:backgroundView];
    
    
    _bottomBtn1  = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_bottomBtn1 setFrame:XFrame(IFAutoFitPx(30), IFAutoFitPx(14), (Screen_W-IFAutoFitPx(90))/2, IFAutoFitPx(80))];
    [_bottomBtn1 setTitle:@"排序/批量操作" forState:(UIControlStateNormal)];
    [_bottomBtn1 setImage:[UIImage imageNamed:@"editmenu_px"] forState:(UIControlStateNormal)];
    [_bottomBtn1.titleLabel setFont:XFont(17)];
    [_bottomBtn1 setTitleColor:BlackColor forState:(UIControlStateNormal)];
    XViewLayerCB(_bottomBtn1, 3, 0.5, LineColor);
    [_bottomBtn1 addTarget:self action:@selector(goSortVC) forControlEvents:(UIControlEventTouchUpInside)];
    [backgroundView addSubview:_bottomBtn1];
    
    _bottomBtn2  = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_bottomBtn2 setFrame:XFrame(IFAutoFitPx(30)+CGRectGetMaxX(_bottomBtn1.frame), IFAutoFitPx(14), (Screen_W-IFAutoFitPx(90))/2, IFAutoFitPx(80))];
    [_bottomBtn2 setTitle:@"新建分类" forState:(UIControlStateNormal)];
    [_bottomBtn2 setImage:[UIImage imageNamed:@"editmenu_add"] forState:(UIControlStateNormal)];
    [_bottomBtn2.titleLabel setFont:XFont(17)];
    [_bottomBtn2 setTitleColor:BlackColor forState:(UIControlStateNormal)];
    XViewLayerCB(_bottomBtn2, 3, 0.5, LineColor);
    [_bottomBtn2 addTarget:self action:@selector(goCreateNewClassVC) forControlEvents:(UIControlEventTouchUpInside)];
    [backgroundView addSubview:_bottomBtn2];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ManageCatergoryTableViewCell *cell = (ManageCatergoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ManageCatergoryTableViewCell"];
    if (!cell){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ManageCatergoryTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSString *className = [self.dataSource[indexPath.row] objectForKey:@"stc_name"];
    cell.catergoryLab.text = className;
    cell.tag = indexPath.row;
    cell.delegate = self;
    return cell;
}


- (void)goSortVC{
    SortViewController *vc = [[SortViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goCreateNewClassVC{
    NewCatergoryViewController *VC = [[NewCatergoryViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - ManageCatergoryTableViewCellDelegate
- (void)edite:(id)sender{
    ManageCatergoryTableViewCell *cell = (ManageCatergoryTableViewCell *)sender;
    NewCatergoryViewController *vc = [[NewCatergoryViewController alloc]init];
    vc.classId = [[self.dataSource[cell.tag] objectForKey:@"stc_id"] integerValue];
    vc.className = [self.dataSource[cell.tag] objectForKey:@"stc_name"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)createNewGoods{
    CreateNewGoodsViewController *vc = [[CreateNewGoodsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 懒加载
- (NSMutableArray *)dataSource{
    if (!_dataSource){
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

@end
