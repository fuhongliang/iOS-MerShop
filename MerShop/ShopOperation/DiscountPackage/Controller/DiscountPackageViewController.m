//
//  DiscountPackageViewController.m
//  MerShop
//
//  Created by mac on 2019/4/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DiscountPackageViewController.h"
#import "DiscountPackageTableViewCell.h"

@interface DiscountPackageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *mainTableView;
@end

@implementation DiscountPackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"优惠套餐"];
    [self.view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [self setUI];
    
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
    [btn setFrame:XFrame((Screen_W-IFAutoFitPx(200))/2, IFAutoFitPx(1), IFAutoFitPx(200), IFAutoFitPx(95))];
    [btn setTitle:@"添加活动" forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:@"yhq_addhuodong"] forState:(UIControlStateNormal)];
    [btn setTitleColor:IFThemeBlueColor forState:(UIControlStateNormal)];
    [btn setBackgroundColor:WhiteColor];
    [btn.titleLabel setFont:XFont(11)];
    [view addSubview:btn];

}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscountPackageTableViewCell *cell = (DiscountPackageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DiscountPackageTableViewCell"];
    if (!cell){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DiscountPackageTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell setDataWithModel];
    return cell;
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


@end
