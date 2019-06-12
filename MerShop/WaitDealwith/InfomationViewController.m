//
//  InfomationViewController.m
//  MerShop
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "InfomationViewController.h"
#import "NoticeTableViewCell.h"
#import "NoticeDetailViewController.h"

@interface InfomationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *mainTableView;
@property (nonatomic ,strong)NSMutableArray *dataSource;

@end

@implementation InfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"系统通知"];
    [self setUI];
    [self requestData];
}

- (void)requestData{
    [Http_url POST:@"msg_list" dict:@{@"store_id":@(StoreId)} showHUD:NO WithSuccessBlock:^(id data) {
        if ([[data objectForKey:@"code"] integerValue] == 200){
            NSArray *arr = [data objectForKey:@"data"];
            if (kISNullArray(arr)){
                [[IFUtils share]showErrorInfo:@"暂无新通知"];
            }else{
                self.dataSource = [[data objectForKey:@"data"] mutableCopy];
                [self.mainTableView reloadData];
            }
        }
        
    } WithFailBlock:^(id data) {
        
    }];
}

- (void)setUI{
    [self.view addSubview:self.mainTableView];
    [self.mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(ViewStart_Y);
        make.left.equalTo(self.view.left).offset(0);
        make.right.equalTo(self.view.right).offset(0);
        make.bottom.equalTo(self.view.bottom).offset(0);
    }];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 72;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"NoticeTableViewCell";
    NoticeTableViewCell *cell = (NoticeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:cellIndentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSDictionary *a = self.dataSource[indexPath.row];
    NSString *title = a[@"sm_content"];
    cell.title.text = @"系统消息";
    cell.subTitle.text = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSource.count > 0){
        NSDictionary *d = self.dataSource[indexPath.row];
        NoticeDetailViewController *vc = [[NoticeDetailViewController alloc]init];
        vc.noticeId = [d[@"sm_id"] integerValue];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 懒加载
- (UITableView *)mainTableView{
    if (!_mainTableView){
        _mainTableView = [[UITableView alloc]init];
        [_mainTableView setBackgroundColor:toPCcolor(@"#f5f5f5")];
        [_mainTableView setDelegate:self];
        [_mainTableView setDataSource:self];
        [_mainTableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
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
