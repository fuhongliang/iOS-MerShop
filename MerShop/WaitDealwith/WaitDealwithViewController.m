//
//  WaitDealwithViewController.m
//  MerShop
//
//  Created by mac on 2019/3/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "WaitDealwithViewController.h"
#import "NewOrderTableViewCell1.h"
#import "InfomationViewController.h"
#import "LoginInViewController.h"
#import "refuseView.h"
#import "MJRefresh.h"
#import "OrderModel.h"
#import "EmptyOrderView.h"


@interface WaitDealwithViewController ()<UITableViewDelegate,UITableViewDataSource,NewOrderTableViewCell1Delegate,refuseViewDelegate,XTScrollLabelViewDelegate>
@property (nonatomic ,strong)UITableView *mainTableview;
@property (nonatomic ,strong)NSMutableArray *dataArr;
@property (nonatomic ,strong)UIView *bgView;//拒单背景view
@property (nonatomic ,assign)NSInteger orderID;
@property (nonatomic ,strong)refuseView *refuseView;
@property (nonatomic ,assign)NSInteger refuseIndex;
@property (nonatomic ,strong)EmptyOrderView *emptyView;
@property (nonatomic ,strong)NSArray *noticeArray;
@property (nonatomic ,strong)UIView *lightBgView;//跑马灯背景view
@property (nonatomic ,strong)JhtHorizontalMarquee *horizontalMarquee;//跑马灯view

//判断每条订单是否是展开状态的数组，
@property (nonatomic ,strong)NSMutableArray *explandArr;
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
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.dataArr removeAllObjects];
    [self requestData];
    // 开启跑马灯
    [_horizontalMarquee marqueeOfSettingWithState:MarqueeStart_H];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

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
        //判断logintoken是否失效
        if ([[data objectForKey:@"code"] integerValue] == 3001){
            [self tokenLost];
            return ;
        }
        if (kISNullObject(data[@"data"])){
            
        }else{
            self.noticeArray = [data[@"data"][@"msg"] copy];
            NSArray *arr = [data objectForKey:@"data"][@"list"];
            
            [self.explandArr removeAllObjects];
            if (kISNullArray(arr)){
                [self.mainTableview setTableHeaderView:self.emptyView];
            }else{
                [self.mainTableview setTableHeaderView:[[UIView alloc] init]];
                for (NSDictionary *dict in arr){
                    OrderModel *model = [[OrderModel alloc]initWithDictionary:dict error:nil];
                    [self.dataArr addObject:model];
                    [self.explandArr addObject:@"0"];
                }
                [self.mainTableview reloadData];
                
            }
        }

        
    } WithFailBlock:^(id data) {
        
    }];
}

- (void)tokenLost{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfo"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"classArray"];
    LoginInViewController *loginVC = [[LoginInViewController alloc]init];
    NavigationViewController *navi = [[NavigationViewController alloc]initWithRootViewController:loginVC];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = navi;
}


- (void)setUI{
    
    _lightBgView = [[UIView alloc]init];
    [_lightBgView setBackgroundColor:toPCcolor(@"#FDF6DB")];
    [_lightBgView setFrame:XFrame(0, ViewStart_Y, Screen_W, 30)];
    [_lightBgView setHidden:YES];
    [self.view addSubview:_lightBgView];
    
    UIImageView *voiceImg = [[UIImageView alloc]init];
    [voiceImg setImage:[UIImage imageNamed:@"home_xt_tzz"]];
    [voiceImg setFrame:XFrame(15, 7, 15, 15)];
    [_lightBgView addSubview:voiceImg];
    
    self.horizontalMarquee.text = @"                                                                   您有一笔新订单，系统已自动接单~              ";
    self.horizontalMarquee.textColor = toPCcolor(@"#F16A11");
    [_lightBgView addSubview:self.horizontalMarquee];

    
    UIButton *closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [closeBtn setFrame:XFrame(Screen_W-30, 7, 15, 15)];
    [closeBtn setImage:[UIImage imageNamed:@"home_xt_gb"] forState:(UIControlStateNormal)];
    [closeBtn addTarget:self action:@selector(closeNotice) forControlEvents:(UIControlEventTouchUpInside)];
    [_lightBgView addSubview:closeBtn];
    
    _mainTableview = [[UITableView alloc]init];
    [_mainTableview setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [_mainTableview setDelegate:self];
    [_mainTableview setDataSource:self];
    [_mainTableview setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [_mainTableview setRowHeight:UITableViewAutomaticDimension];
    [_mainTableview setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [self.view addSubview:_mainTableview];
    
    UIButton *noticeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [noticeBtn setImage:[UIImage imageNamed:@"home_xt_ts"] forState:(UIControlStateNormal)];
    [noticeBtn addTarget:self action:@selector(clickNotice) forControlEvents:(UIControlEventTouchUpInside)];
    [self.navigationView addSubview:noticeBtn];
    [noticeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navigationView.right).offset(-18);
        make.width.equalTo(17);
        make.height.equalTo(16);
        make.bottom.equalTo(self.navigationView.bottom).offset(-13);
    }];
    
}


- (void)setLoopView{
    [UIView animateWithDuration:0.3 animations:^{
        [self.lightBgView setHidden:NO];
        [self.mainTableview setFrame:XFrame(0, ViewStart_Y+30, Screen_W, Screen_H-ViewStart_Y-30)];
    }];
}
/**
    关闭顶部跑马灯
 */
- (void)closeNotice{
    [UIView animateWithDuration:0.3 animations:^{
        [self.lightBgView setHidden:YES];
        [self.mainTableview setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    }];
}

/**
    点击导航条通知按钮
 */
- (void)clickNotice{
    InfomationViewController *noticeVC = [[InfomationViewController alloc]init];
    [self.navigationController pushViewController:noticeVC animated:YES];
}

/**
    拒绝订单
 */
- (void)refuseOrder:(id)cell{
    NewOrderTableViewCell1 *c = cell;
    OrderModel *model = self.dataArr[c.tag];
    _refuseIndex = c.tag;
    _orderID = model.order_id;
    
    _bgView = [[UIView alloc]init];
    [_bgView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [_bgView setBackgroundColor:[UIColor blackColor]];
    [_bgView setAlpha:0.4];
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"refuseView" owner:self options:nil];
    self.refuseView = [nib objectAtIndex:0];
    [self.refuseView setFrame:XFrame(0, Screen_H-275, Screen_W, 275)];
    self.refuseView.delegate = self;
    
    UIApplication *ap = [UIApplication sharedApplication];
    [ap.keyWindow addSubview:self.bgView];
    [ap.keyWindow addSubview:self.refuseView];
    
    [self.bgView setHidden:NO];
    [self.refuseView setHidden:NO];
}

/**
    接收订单
 */
- (void)receiveOrder:(id)cell{
    NewOrderTableViewCell1 *c = cell;
    _refuseIndex = c.tag;
    OrderModel *model = self.dataArr[c.tag];
    _orderID = model.order_id;
    [Http_url POST:@"receive_order" dict:@{@"order_id":@(_orderID)} showHUD:YES WithSuccessBlock:^(id data) {
        if (data){
            [[IFUtils share]showErrorInfo:@"已接单"];
            //删除已接单的数据元
            [self.dataArr removeObjectAtIndex:self.refuseIndex];
            [self.explandArr removeObjectAtIndex:self.refuseIndex];
            if (self.dataArr.count == 0){
                [self.mainTableview setTableHeaderView:self.emptyView];
            }
            [self.mainTableview reloadData];
        }
    } WithFailBlock:^(id data) {
        
    }];
}

/**
    展开按钮代理方法
 */
- (void)explandOrder:(id)data{
    NewOrderTableViewCell1 *cell = (NewOrderTableViewCell1 *)data[0];
    [self.explandArr replaceObjectAtIndex:cell.tag withObject:data[1]];
    [self.mainTableview reloadData];


}

/**
    拨打用户电话按钮方法
 */
- (void)playCallAction:(id)data{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否拨打客户的联系电话" preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",data];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
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
    [Http_url POST:@"refuse_order" dict:dict showHUD:YES WithSuccessBlock:^(id data) {
        if (data){
            [[IFUtils share]showErrorInfo:@"已拒绝"];
            //删除拒绝的数据元
            [self.dataArr removeObjectAtIndex:self.refuseIndex];
            [self.explandArr removeObjectAtIndex:self.refuseIndex];
            if (self.dataArr.count == 0){
                [self.mainTableview setTableHeaderView:self.emptyView];
            }
            [self.mainTableview reloadData];
        }
    } WithFailBlock:^(id data) {
        
    }];
}

#define mark - 懒加载
- (NSMutableArray *)dataArr{
    if (!_dataArr){
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}

- (NSMutableArray *)explandArr{
    if (!_explandArr){
        _explandArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _explandArr;
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
        [cell addProduct:model withExplandState:self.explandArr[indexPath.row]];
    }
    cell.delegate = self;
    cell.tag = indexPath.row;
    return cell;
}

- (JhtHorizontalMarquee *)horizontalMarquee{
    if (!_horizontalMarquee) {
        _horizontalMarquee = [[JhtHorizontalMarquee alloc] initWithFrame:CGRectMake(40, 0, Screen_W-75, 30) singleScrollDuration:0.0];
    }
    return _horizontalMarquee;
}

@end
