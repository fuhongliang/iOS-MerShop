//
//  FullReductionViewController.m
//  MerShop
//
//  Created by mac on 2019/4/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "FullReductionViewController.h"
//#import "FullReductionTableViewCell.h"
#import "FullReduceTableViewCell.h"
#import "AddFullReductionViewController.h"
#import "FullReductionModel.h"

@interface FullReductionViewController ()<UITableViewDataSource,UITableViewDelegate,FullReduceTableViewCellDelegate>
@property (nonatomic ,strong)UITableView *mainTableView;
@property (nonatomic ,strong)NSMutableArray *dataSource;
@end

@implementation FullReductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"满立减"];
    [self.view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [self setUI];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadListData];
}

- (void)reloadListData{
    NSDictionary *dict = @{@"store_id":StoreIdString};
    [Http_url POST:@"mamsong_list" dict:dict showHUD:NO WithSuccessBlock:^(id data) {
        NSLog(@"%@",[data objectForKey:@"data"]);
        NSArray *arr = [data objectForKey:@"data"];
        if (![arr isEqual:[NSNull null]]){
            [self.dataSource removeAllObjects];
            for (NSDictionary *dict in arr){
                FullReductionModel *model = [[FullReductionModel alloc]initWithDictionary:dict error:nil];
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
    FullReduceTableViewCell *cell = (FullReduceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FullReduceTableViewCell"];
    if (!cell){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FullReduceTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    FullReductionModel *model = self.dataSource[indexPath.row];
    cell.delegate = self;
    cell.tag = indexPath.row;
    [cell setDataWithModel:model];
    return cell;
}

#pragma mark - 删除活动接口
- (void)deleteActivity:(id)data{
    FullReduceTableViewCell *cell = (FullReduceTableViewCell *)data;
    FullReductionModel *model = self.dataSource[cell.tag];
    NSDictionary *dict = @{@"mansong_id":[NSString stringWithFormat:@"%ld",model.mansong_id],
                           @"store_id":StoreIdString
                           };
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定删除该活动吗？" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [Http_url POST:@"mamsong_del" dict:dict showHUD:YES WithSuccessBlock:^(id data) {
            if ([[data objectForKey:@"code"] integerValue] == 200){
                [self.dataSource removeObjectAtIndex:cell.tag];
                [self.mainTableView reloadData];
            }
        } WithFailBlock:^(id data) {
            
        }];
    }]];
    [self presentViewController:alert animated:YES completion:nil];


}

- (void)addActivity{
    AddFullReductionViewController *vc = [[AddFullReductionViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 懒加载
- (UITableView *)mainTableView{
    if (!_mainTableView){
        _mainTableView = [[UITableView alloc]init];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mainTableView setBackgroundColor:toPCcolor(@"#f5f5f5")];
        [_mainTableView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y-IFAutoFitPx(96))];
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
