//
//  DiscountViewController.m
//  MerShop
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DiscountViewController.h"
#import "ActivityHeaderView.h"
#import "AddGoodsTableViewCell.h"
#import "EditeActivityTableViewCell.h"
#import "AddActivityGoodsViewController.h"

@interface DiscountViewController ()<UITableViewDataSource,UITableViewDelegate,ActivityHeaderViewDelegate>
@property (nonatomic ,strong)UITableView *mainTableView;
@property (nonatomic ,strong)ActivityHeaderView *headerView;
@property (nonatomic ,assign)NSInteger lowerLimitNumber;
@end

@implementation DiscountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"编辑活动"];
    [self.view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    _lowerLimitNumber = 1;
    [self setUI];
    
}

- (void)setUI{
    [self.view addSubview:self.mainTableView];
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ActivityHeaderView" owner:self options:nil];
    _headerView = [nib objectAtIndex:0];
    _headerView.delegate = self;
    _headerView.numberLab.text = [NSString stringWithFormat:@"%ld",_lowerLimitNumber];
    [_headerView setFrame:XFrame(0, 0, Screen_W, 389)];
    
    UIView *footerView = [[UIView alloc]init];
    [footerView setFrame:XFrame(0, 0, Screen_W, IFAutoFitPx(276))];
    [footerView setBackgroundColor:toPCcolor(@"#f5f5f5")];
    
    UIView *line  = [[UIView alloc]init];
    [line setFrame:XFrame(0, 0, Screen_W, IFAutoFitPx(1))];
    [line setBackgroundColor:toPCcolor(@"#E5E5E5")];
    [footerView addSubview:line];
    
    UIButton *addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [addBtn setFrame:XFrame(0, IFAutoFitPx(1), Screen_W, IFAutoFitPx(87))];
    [addBtn setBackgroundColor:[UIColor whiteColor]];
    [addBtn setTitle:@"添加" forState:(UIControlStateNormal)];
    [addBtn setTitleColor:IFThemeBlueColor forState:(UIControlStateNormal)];
    addBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [addBtn setImage:[UIImage imageNamed:@"yhq_ic_add"] forState:(UIControlStateNormal)];
    [addBtn addTarget:self action:@selector(clickAddButton) forControlEvents:(UIControlEventTouchUpInside)];
    [footerView addSubview:addBtn];
    
    UIButton *commitBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [commitBtn setFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(addBtn.frame)+IFAutoFitPx(60), Screen_W-IFAutoFitPx(60), IFAutoFitPx(88))];
    [commitBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [commitBtn setBackgroundColor:IFThemeBlueColor];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    commitBtn.layer.cornerRadius = 3;
    commitBtn.layer.masksToBounds = YES;
    [footerView addSubview:commitBtn];
    
    [_mainTableView setTableHeaderView:_headerView];
    [_mainTableView setTableFooterView:footerView];
}

#pragma mark - UITableViewDelegate & UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EditeActivityTableViewCell *cell = (EditeActivityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"EditeActivityTableViewCell"];
    if (!cell){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EditeActivityTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    return cell;
}

#pragma mark - ActivityHeaderViewDelegate
- (void)reduceNumber{
    if (_lowerLimitNumber == 1){
        NSLog(@"--------最低数量");
        return;
    }else{
        _lowerLimitNumber = _lowerLimitNumber - 1;
        _headerView.numberLab.text = [NSString stringWithFormat:@"%ld",_lowerLimitNumber];
    }
}

- (void)addNumber{
    _lowerLimitNumber ++;
    _headerView.numberLab.text = [NSString stringWithFormat:@"%ld",_lowerLimitNumber];
}

- (void)clickAddButton{
    AddActivityGoodsViewController *vc = [[AddActivityGoodsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 懒加载
- (UITableView *)mainTableView{
    if (!_mainTableView){
        _mainTableView = [[UITableView alloc]init];
        [_mainTableView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
        [_mainTableView setBackgroundColor:[UIColor whiteColor]];
        [_mainTableView setTableFooterView:[[UIView alloc]init]];
        [_mainTableView setDelegate:self];
        [_mainTableView setDataSource:self];
        [_mainTableView setRowHeight:UITableViewAutomaticDimension];

    }
    return _mainTableView;
}
@end
