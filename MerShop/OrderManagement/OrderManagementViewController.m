//
//  OrderManagementViewController.m
//  MerShop
//
//  Created by mac on 2019/3/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "OrderManagementViewController.h"
#import "WaitDeliveryTableViewCell.h"
#import "AllReadyDeliveryTableViewCell.h"
#import "NewOrderTableViewCell1.h"
#import "NewOrderModel.h"
#import <MJRefresh.h>
#import "EmptyOrderView.h"

@interface OrderManagementViewController ()<UITableViewDelegate,UITableViewDataSource,WaitDeliveryTableViewCellDelegate,AllReadyDeliveryTableViewCellDelegate>
@property (nonatomic ,strong)UITableView *mainTableview;
@property (nonatomic ,strong)UIView *topBackgroundView;
@property (nonatomic ,strong)NSMutableArray *btnArr;
@property (nonatomic ,strong)NSMutableArray *onGoingArr;
@property (nonatomic ,strong)NSMutableArray *finishedArr;
@property (nonatomic ,strong)NSMutableArray *cancelArr;
@property (nonatomic ,strong)NSMutableArray *dataSource;
@property (nonatomic ,assign)NSInteger currentIndex;
@property (nonatomic ,strong)UIView *lineView;
@property (nonatomic ,copy)NSArray *indexArr;
@property (nonatomic ,strong)EmptyOrderView *emptyView;
@property (nonatomic ,copy)NSArray *dictArr;

//判断每条订单是否是展开状态的数组，
@property (nonatomic ,strong)NSMutableArray *explandArr;
@end

@implementation OrderManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentIndex = 0;
    [self setNaviTitle:@"订单管理"];
    [self setHideBackBtn:YES];
    [self setUI];
    [self requet:25];
    [self refreshHeader];
    
    //空页面
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EmptyOrderView" owner:self options:nil];
    _emptyView = [nib objectAtIndex:0];
    [_emptyView setFrame:XFrame(0, ViewStart_Y+IFAutoFitPx(88), Screen_W, Screen_H-ViewStart_Y-Tabbar_H)];
    [_emptyView setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [self.mainTableview setTableHeaderView:_emptyView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)refreshHeader{
    LCWeakSelf(self)
    [self.mainTableview addLegendHeaderWithRefreshingBlock:^{
        [weakself.dataSource removeAllObjects];
        if (weakself.currentIndex == 0){
            [weakself requet:25];
        }else if (weakself.currentIndex == 1){
            [weakself requet:40];
        }else{
            [weakself requet:0];
        }
        [weakself.mainTableview.legendHeader endRefreshing];
    }];
}

- (void)requet:(NSInteger )stateId{
    NSInteger storeId = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"] objectForKey:@"store_id"] integerValue];
    
    [Http_url POST:@"order_list" dict:@{@"order_state":@(stateId),@"store_id":@(storeId)} showHUD:YES WithSuccessBlock:^(id data) {
        self.dictArr = [data objectForKey:@"data"];
        //每次请求数据删除，删除原有数据,判断是否是展开状态
        [self.explandArr removeAllObjects];
        if ([[data objectForKey:@"data"] isKindOfClass:[NSNull class]]){
            [self.mainTableview setTableHeaderView:self.emptyView ];
        }else{
            [self.mainTableview setTableHeaderView:[[UIView alloc] init]];
            for (NSDictionary *dict in self.dictArr){
                NewOrderModel *model = [[NewOrderModel alloc]initWithDictionary:dict error:nil];
                [self.dataSource addObject:model];
                [self.explandArr addObject:@"0"];
            }
        }
        [self.mainTableview reloadData];
    } WithFailBlock:^(id data) {
        
    }];
}

- (void)setUI{
    _topBackgroundView = [[UIView alloc]init];
    [_topBackgroundView setFrame:XFrame(0, ViewStart_Y, Screen_W, IFAutoFitPx(88))];
    XViewLayerCB(_topBackgroundView, 0, 0.5, LineColor);
    [self.view addSubview:_topBackgroundView];
    
    UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn1 setFrame:XFrame(0, IFAutoFitPx(10), Screen_W/3, IFAutoFitPx(68))];
    [btn1 setTitle:@"进行中" forState:(UIControlStateNormal)];
    [btn1 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [btn1.titleLabel setFont:XFont(16)];
    btn1.tag = 0;
    [btn1 addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [_topBackgroundView addSubview:btn1];
    [self.btnArr addObject:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn2 setFrame:XFrame(Screen_W/3, IFAutoFitPx(10), Screen_W/3, IFAutoFitPx(68))];
    [btn2 setTitle:@"已完成" forState:(UIControlStateNormal)];
    [btn2 setTitleColor:GrayColor forState:(UIControlStateNormal)];
    [btn2.titleLabel setFont:XFont(16)];
    btn2.tag = 1;
    [btn2 addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [_topBackgroundView addSubview:btn2];
    [self.btnArr addObject:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn3 setFrame:XFrame(Screen_W/3*2, IFAutoFitPx(10), Screen_W/3, IFAutoFitPx(68))];
    [btn3 setTitle:@"已取消" forState:(UIControlStateNormal)];
    [btn3 setTitleColor:GrayColor forState:(UIControlStateNormal)];
    [btn3.titleLabel setFont:XFont(16)];
    btn3.tag = 2;
    [btn3 addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [_topBackgroundView addSubview:btn3];
    [self.btnArr addObject:btn3];
    
    _lineView = [[UIView alloc]init];
    [_lineView setFrame:XFrame(0, IFAutoFitPx(88-4), Screen_W/3, IFAutoFitPx(4))];
    [_lineView setBackgroundColor:IFThemeBlueColor];
    [_topBackgroundView addSubview:_lineView];
    
    _mainTableview = [[UITableView alloc]init];
    [_mainTableview setFrame:XFrame(0, ViewStart_Y+IFAutoFitPx(88), Screen_W, Screen_H-ViewStart_Y-IFAutoFitPx(88)-Tabbar_H)];
    [_mainTableview setRowHeight:UITableViewAutomaticDimension];
    [_mainTableview setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [_mainTableview setBackgroundColor:toPCcolor(@"#f5f5f5")];
    _mainTableview.delegate = self;
    _mainTableview.dataSource = self;
    [self.view addSubview:_mainTableview];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WaitDeliveryTableViewCell *cell1 = (WaitDeliveryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"WaitDeliveryTableViewCell"];
    AllReadyDeliveryTableViewCell *cell2 = (AllReadyDeliveryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AllReadyDeliveryTableViewCell"];
    NewOrderModel *model;
    if (self.dataSource.count > 0){
        model = self.dataSource[indexPath.row];
    }
    if ([model.order_state isEqualToString:@"配送中"] || [model.order_state isEqualToString:@"已完成"]){
        if (!cell2){
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AllReadyDeliveryTableViewCell" owner:self options:nil];
            cell2 = [nib objectAtIndex:0];
        }
        if (self.dataSource.count > 0){
            [cell2 addProduct:self.dataSource[indexPath.row] withExplandState:self.explandArr[indexPath.row]];
        }
        cell2.tag = indexPath.row;
        cell2.delegate = self;
        return cell2;
    }else{
        if (!cell1){
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"WaitDeliveryTableViewCell" owner:self options:nil];
            cell1 = [nib objectAtIndex:0];
        }
        if (self.dataSource.count >0){
            NewOrderModel *model = self.dataSource[indexPath.row];
            [cell1 addProduct:model withExplandState:self.explandArr[indexPath.row]];
        }
        cell1.tag = indexPath.row;
        cell1.delegate = self;
        return cell1;
    }
    return nil;
}

#pragma mark - WaitDeliveryTableViewCellDelegate
/**
    待配送的打印订单按钮方法
 */
- (void)printOrder:(id)data{
    WaitDeliveryTableViewCell *cell = (WaitDeliveryTableViewCell *)data;
    NSInteger index = cell.tag;
    NSDictionary *dict = self.dictArr[index];
    [self printOrderWithDict:dict];
    
}
/**
    待配送cell展开按钮方法
 */
- (void)explandOrder:(id)data{
    WaitDeliveryTableViewCell *cell = (WaitDeliveryTableViewCell *)data[0];
    [self.explandArr replaceObjectAtIndex:cell.tag withObject:data[1]];
    [self.mainTableview reloadData];
}

#pragma mark - AllReadyDeliveryTableViewCellDelegate
/**
    已完成的打印订单按钮方法
 */
- (void)printfOrder:(id)data{
    AllReadyDeliveryTableViewCell *cell = (AllReadyDeliveryTableViewCell *)data;
    NSInteger index = cell.tag;
    NSDictionary *dict = self.dictArr[index];
    [self printOrderWithDict:dict];
}
/**
    已完成cell展开按钮方法
 */
- (void)finishedExplandOrder:(id)data{
    AllReadyDeliveryTableViewCell *cell = (AllReadyDeliveryTableViewCell *)data[0];
    [self.explandArr replaceObjectAtIndex:cell.tag withObject:data[1]];
    [self.mainTableview reloadData];
}

#pragma mark - 懒加载
- (NSMutableArray *)dataSource{
    if (!_dataSource){
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

- (NSMutableArray *)btnArr{
    if (!_btnArr){
        _btnArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _btnArr;
}

- (NSMutableArray *)cancelArr{
    if (!_cancelArr){
        _cancelArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _cancelArr;
}

- (NSMutableArray *)onGoingArr{
    if (!_onGoingArr){
        _onGoingArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _onGoingArr;
}

- (NSMutableArray *)finishedArr{
    if (!_finishedArr){
        _finishedArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _finishedArr;
}

- (NSMutableArray *)explandArr{
    if (!_explandArr){
        _explandArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _explandArr;
}

- (void)clickBtn:(UIButton *)sender{
    [self.dataSource removeAllObjects];
    _currentIndex = sender.tag;
    if (_currentIndex == 0){
        [self requet:25];
    }else if (_currentIndex == 1){
        [self requet:40];
    }else{
        [self requet:0];
    }
    [_lineView setFrame:XFrame(Screen_W/3*_currentIndex, IFAutoFitPx(88-4), Screen_W/3, IFAutoFitPx(4))];
    for (UIButton *btn in _btnArr){
        if (btn.tag == _currentIndex){
            [btn setTitleColor:BlackColor forState:(UIControlStateNormal)];
        }else{
            [btn setTitleColor:GrayColor forState:(UIControlStateNormal)];
        }
    }
}


@end
