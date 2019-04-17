//
//  AddDiscountViewController.m
//  MerShop
//
//  Created by mac on 2019/4/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AddDiscountViewController.h"
#import "DiscountPackageGoodsCell.h"
#import "PackageView.h"
#import "FooterView.h"

@interface AddDiscountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *mainTableView;
@property (nonatomic ,strong)PackageView *headView;
@property (nonatomic ,strong)FooterView *footerView;
@end

@implementation AddDiscountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"添加活动"];
    [self.view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [self setUI];
}

- (void)setUI{
    [self.view addSubview:self.mainTableView];
    
    _headView = [[[NSBundle mainBundle]loadNibNamed:@"PackageView" owner:self options:nil] objectAtIndex:0];
    [_headView setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [_headView setFrame:XFrame(0, 0, Screen_W, 103)];
    [self.mainTableView setTableHeaderView:_headView];
    
    _footerView = [[[NSBundle mainBundle]loadNibNamed:@"FooterView" owner:self options:nil] objectAtIndex:0];
    [_footerView setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [_footerView setFrame:XFrame(0, 0, Screen_W, 310)];
    [self.mainTableView setTableFooterView:_footerView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscountPackageGoodsCell *cell = (DiscountPackageGoodsCell *)[tableView dequeueReusableCellWithIdentifier:@"DiscountPackageGoodsCell"];
    if (!cell){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DiscountPackageGoodsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    return cell;
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
