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

@interface DiscountViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *mainTableView;
@end

@implementation DiscountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"添加活动"];
    [self.view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [self setUI];
    
}

- (void)setUI{
    [self.view addSubview:self.mainTableView];
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ActivityHeaderView" owner:self options:nil];
    ActivityHeaderView *headerView = [nib objectAtIndex:0];
    [headerView setFrame:XFrame(0, 0, Screen_W, 389)];
    [_mainTableView setTableHeaderView:headerView];
}

#define mark - UITableViewDelegate & UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddGoodsTableViewCell *cell = (AddGoodsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AddGoodsTableViewCell"];
    if (!cell){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AddGoodsTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    return cell;
}

- (UITableView *)mainTableView{
    if (!_mainTableView){
        _mainTableView = [[UITableView alloc]init];
        [_mainTableView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y-IFAutoFitPx(88))];
        [_mainTableView setBackgroundColor:[UIColor whiteColor]];
        [_mainTableView setTableFooterView:[[UIView alloc]init]];
        [_mainTableView setDelegate:self];
        [_mainTableView setDataSource:self];
        [_mainTableView setRowHeight:UITableViewAutomaticDimension];

    }
    return _mainTableView;
}
@end
