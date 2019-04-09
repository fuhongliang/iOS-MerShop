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
@property (nonatomic ,copy)NSDictionary *storeData;
@property (nonatomic ,copy)NSString *DataUrl;
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"门店运营"];
    [self setHideBackBtn:YES];
    
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
            [self setUI];
        }
    } WithFailBlock:^(id data) {
        
    }];
}

- (void)setUI{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil];
    HeaderView *view = [nib objectAtIndex:0];
    [view setBackgroundColor:IFThemeBlueColor];
    view.delegate = self;
    [view setFrame:XFrame(0, 0, Screen_W, 278-43)];
//    [view setFrame:XFrame(0, ViewStart_Y, Screen_W, 278)];
    [view addStoreInfo:self.storeData];
    _tableview = [[UITableView alloc]init];
    [_tableview setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [_tableview setDelegate:self];
    [_tableview setDataSource:self];
    [_tableview setBackgroundColor:toPCcolor(@"#f5f5f5")];
    _tableview.scrollEnabled = NO;
    _tableview.tableHeaderView = view;
    _tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 1)];;
    [self.view addSubview:_tableview];
//    [self.view addSubview:view];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
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
//    if (indexPath.row == _titleArr.count-1) {
//        cell.separatorInset = UIEdgeInsetsMake(0, Screen_W, 0, 0);
//    }else{
//        cell.separatorInset = UIEdgeInsetsMake(0, FTDefaultMenuTextMargin, 0, 10+FTDefaultMenuTextMargin);
//    }
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
    vc.url = [NSString stringWithFormat:@"%@",[self.storeData objectForKey:@"jingying_url"]];
    [self.navigationController pushViewController:vc animated:NO];
}

@end
