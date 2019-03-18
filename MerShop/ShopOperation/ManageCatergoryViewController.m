//
//  ManageCatergoryViewController.m
//  MerShop
//
//  Created by mac on 2019/3/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ManageCatergoryViewController.h"
#import "ManageCatergoryTableViewCell.h"

@interface ManageCatergoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableview;
@property (nonatomic ,strong)UIButton *bottomBtn1;
@property (nonatomic ,strong)UIButton *bottomBtn2;

@end

@implementation ManageCatergoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"管理分类"];
    [self setUI];
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
    [backgroundView addSubview:_bottomBtn1];
    
    _bottomBtn2  = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_bottomBtn2 setFrame:XFrame(IFAutoFitPx(30)+CGRectGetMaxX(_bottomBtn1.frame), IFAutoFitPx(14), (Screen_W-IFAutoFitPx(90))/2, IFAutoFitPx(80))];
    [_bottomBtn2 setTitle:@"新建商品" forState:(UIControlStateNormal)];
    [_bottomBtn2 setImage:[UIImage imageNamed:@"editmenu_add"] forState:(UIControlStateNormal)];
    [_bottomBtn2.titleLabel setFont:XFont(17)];
    [_bottomBtn2 setTitleColor:BlackColor forState:(UIControlStateNormal)];
    XViewLayerCB(_bottomBtn2, 3, 0.5, LineColor);
    [backgroundView addSubview:_bottomBtn2];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
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
    return cell;
}

@end
