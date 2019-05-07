//
//  AllbillsViewController.m
//  MerShop
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AllbillsViewController.h"
#import "FinancialCell.h"

@interface AllbillsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UIView *topBackgroundView;
@property (nonatomic ,strong)NSMutableArray *btnArr;
@property (nonatomic ,assign)NSInteger currentIndex;
@property (nonatomic ,strong)UIView *lineView;

@property (nonatomic ,strong)UITableView *mainTableView;
@property (nonatomic ,strong)NSMutableArray *dataSource;
@end

@implementation AllbillsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"全部账单"];
    [self.view setBackgroundColor:BackgroundColor];
    [self setUI];
    [self requestData];
    
}

- (void)requestData{
    
}

- (void)setUI{
    _topBackgroundView = [[UIView alloc]init];
    [_topBackgroundView setFrame:XFrame(0, ViewStart_Y, Screen_W, IFAutoFitPx(88))];
    XViewLayerCB(_topBackgroundView, 0, 0.5, LineColor);
    [self.view addSubview:_topBackgroundView];
    
    UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn1 setFrame:XFrame(0, IFAutoFitPx(10), Screen_W/2, IFAutoFitPx(68))];
    [btn1 setTitle:@"已结算" forState:(UIControlStateNormal)];
    [btn1 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [btn1.titleLabel setFont:XFont(16)];
    btn1.tag = 0;
    [btn1 addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [_topBackgroundView addSubview:btn1];
    [self.btnArr addObject:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn2 setFrame:XFrame(Screen_W/2, IFAutoFitPx(10), Screen_W/2, IFAutoFitPx(68))];
    [btn2 setTitle:@"已提现" forState:(UIControlStateNormal)];
    [btn2 setTitleColor:GrayColor forState:(UIControlStateNormal)];
    [btn2.titleLabel setFont:XFont(16)];
    btn2.tag = 1;
    [btn2 addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [_topBackgroundView addSubview:btn2];
    [self.btnArr addObject:btn2];
    
    _lineView = [[UIView alloc]init];
    [_lineView setFrame:XFrame(0, IFAutoFitPx(88-4), Screen_W/2, IFAutoFitPx(4))];
    [_lineView setBackgroundColor:IFThemeBlueColor];
    [_topBackgroundView addSubview:_lineView];
    
    [self.view addSubview:self.mainTableView];
}

//顶部按钮点击方法
- (void)clickBtn:(UIButton *)sender{
    _currentIndex = sender.tag;

    [_lineView setFrame:XFrame(Screen_W/2*_currentIndex, IFAutoFitPx(88-4), Screen_W/2, IFAutoFitPx(4))];
    for (UIButton *btn in _btnArr){
        if (btn.tag == _currentIndex){
            [btn setTitleColor:BlackColor forState:(UIControlStateNormal)];
        }else{
            [btn setTitleColor:GrayColor forState:(UIControlStateNormal)];
        }
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FinancialCell *cell = (FinancialCell *)[tableView dequeueReusableCellWithIdentifier:@"FinancialCell"];
    if (!cell){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FinancialCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    return cell;
}

#pragma mark - 懒加载
- (UITableView *)mainTableView{
    if (!_mainTableView){
        _mainTableView = [[UITableView alloc]init];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mainTableView setBackgroundColor:toPCcolor(@"#f5f5f5")];
        [_mainTableView setFrame:XFrame(0, ViewStart_Y+IFAutoFitPx(88), Screen_W, Screen_H-ViewStart_Y-IFAutoFitPx(88))];
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
- (NSMutableArray *)btnArr{
    if (!_btnArr){
        _btnArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _btnArr;
}
@end
