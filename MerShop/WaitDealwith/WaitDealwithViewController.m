//
//  WaitDealwithViewController.m
//  MerShop
//
//  Created by mac on 2019/3/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "WaitDealwithViewController.h"
#import "NewOrderTableViewCell1.h"
#import "refuseView.h"
#import "MJRefresh.h"
#import "OrderModel.h"
#import "EmptyOrderView.h"

@interface WaitDealwithViewController ()<UITableViewDelegate,UITableViewDataSource,NewOrderTableViewCell1Delegate,refuseViewDelegate>
@property (nonatomic ,strong)UITableView *mainTableview;
@property (nonatomic ,strong)NSMutableArray *dataArr;
@property (nonatomic ,strong)UIView *bgView;
@property (nonatomic ,assign)NSInteger orderID;
@property (nonatomic ,strong)refuseView *refuseView;
@property (nonatomic ,assign)NSInteger refuseIndex;
@property (nonatomic ,strong)EmptyOrderView *emptyView;
@end

@implementation WaitDealwithViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"新订单"];
    [self setHideBackBtn:YES];
    [self setUI];
    [self refreshHeader];
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EmptyOrderView" owner:self options:nil];
    _emptyView = [nib objectAtIndex:0];
    [_emptyView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y-Tabbar_H)];
    [_emptyView setBackgroundColor:toPCcolor(@"#f5f5f5")];
//    [self.mainTableview setTableHeaderView:nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.dataArr removeAllObjects];
    [self requestData];
}

- (void)refreshHeader{
    __weak typeof(self) weakself = self;
    [self.mainTableview addLegendHeaderWithRefreshingBlock:^{
        [weakself.dataArr removeAllObjects];
        [weakself requestData];
        [weakself.mainTableview.legendHeader endRefreshing];
    }];
}

- (void)requestData{
    NSInteger storeId = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"] objectForKey:@"store_id"] integerValue];
    [Http_url POST:@"get_neworder" dict:@{@"store_id":@(storeId)} showHUD:NO WithSuccessBlock:^(id data) {
        NSArray *arr = [data objectForKey:@"data"];
        if ([[data objectForKey:@"data"] isKindOfClass:[NSNull class]]){
            [self.mainTableview setTableHeaderView:self.emptyView];
        }else{
            [self.mainTableview setTableHeaderView:[[UIView alloc] init]];
            for (NSDictionary *dict in arr){
                OrderModel *model = [[OrderModel alloc]initWithDictionary:dict error:nil];
//                [self.dataArr addObject:model];
            }
            [self.mainTableview reloadData];
            
        }
        
    } WithFailBlock:^(id data) {
        
    }];
}

- (void)setUI{
    _mainTableview = [[UITableView alloc]init];
    [_mainTableview setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [_mainTableview setDelegate:self];
    [_mainTableview setDataSource:self];
    [_mainTableview setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [_mainTableview setRowHeight:UITableViewAutomaticDimension];
    [_mainTableview setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [self.view addSubview:_mainTableview];
    
    _bgView = [[UIView alloc]init];
    [_bgView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [_bgView setBackgroundColor:[UIColor blackColor]];
    [_bgView setAlpha:0.5];
    [_bgView setHidden:YES];
    [self.view addSubview:self.bgView];
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"refuseView" owner:self options:nil];
    self.refuseView = [nib objectAtIndex:0];
    [self.refuseView setFrame:XFrame(0, Screen_H-275-Tabbar_H, Screen_W, 275)];
    [self.refuseView setHidden:YES];
    self.refuseView.delegate = self;
    [self.view addSubview:self.refuseView];
    
}

- (void)refuseOrder:(id)cell{
    NewOrderTableViewCell1 *c = cell;
    OrderModel *model = self.dataArr[c.tag];
    _refuseIndex = c.tag;
    _orderID = model.order_id;
    [self.bgView setHidden:NO];
    [self.refuseView setHidden:NO];
}

- (void)receiveOrder:(id)cell{
    NewOrderTableViewCell1 *c = cell;
    _refuseIndex = c.tag;
    OrderModel *model = self.dataArr[c.tag];
    _orderID = model.order_id;
//    __weak typeof(self) weakself = self;
    [Http_url POST:@"receive_order" dict:@{@"order_id":@(_orderID)} showHUD:YES WithSuccessBlock:^(id data) {
        if (data){
            [[IFUtils share]showErrorInfo:@"已接单"];
            [self.dataArr removeObjectAtIndex:self.refuseIndex];
            [self.mainTableview reloadData];
        }
    } WithFailBlock:^(id data) {
        
    }];
}

- (void)refuseMethod:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"取消"]){
        [self.bgView setHidden:YES];
        [self.refuseView setHidden:YES];
        
    }else{
        [self.bgView setHidden:YES];
        [self.refuseView setHidden:YES];
        [self refuseRequest:sender.titleLabel.text];
    }
}

- (void)refuseRequest:(NSString *)reason{
    NSDictionary *dict = @{@"order_id":@(_orderID),
                           @"refuse_reason":reason,
                           };
//    __weak typeof(self)weakself = self;
    [Http_url POST:@"refuse_order" dict:dict showHUD:YES WithSuccessBlock:^(id data) {
        if (data){
            [[IFUtils share]showErrorInfo:@"已拒绝"];
            [self.dataArr removeObjectAtIndex:self.refuseIndex];
            [self.mainTableview reloadData];
        }
    } WithFailBlock:^(id data) {
        
    }];
}

- (NSMutableArray *)dataArr{
    if (!_dataArr){
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewOrderTableViewCell1 *cell = (NewOrderTableViewCell1 *)[tableView dequeueReusableCellWithIdentifier:@"NewOrderTableViewCell1"];
    if (!cell){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewOrderTableViewCell1" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if (self.dataArr.count >0){
        OrderModel *model = self.dataArr[indexPath.row];
        [cell addProduct:model];
    }
    cell.delegate = self;
    cell.tag = indexPath.row;
    return cell;
}



@end
