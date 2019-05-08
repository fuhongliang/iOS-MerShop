//
//  AllbillsViewController.m
//  MerShop
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AllbillsViewController.h"
#import "FinancialCell.h"
#import "AllbillsHeaderView.h"
#import <BRPickerView.h>

@interface AllbillsViewController ()<UITableViewDelegate,UITableViewDataSource,AllbillsHeaderViewDelegate>
@property (nonatomic ,strong)UIView *topBackgroundView;
@property (nonatomic ,strong)NSMutableArray *btnArr;
@property (nonatomic ,assign)NSInteger currentIndex;
@property (nonatomic ,strong)UIView *lineView;

@property (nonatomic ,strong)UITableView *mainTableView;
@property (nonatomic ,strong)NSMutableArray *dataSource;

@property (nonatomic ,strong)AllbillsHeaderView *headerView;
@property (nonatomic ,strong)BRDatePickerView *dateView;
@end

@implementation AllbillsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"全部账单"];
    _currentIndex = 0;
    [self.view setBackgroundColor:BackgroundColor];
    [self setUI];
    NSDate *date = [NSDate date];
    [self requestDataWithYear:[IFTools dateToString:date dateFormat:@"yyyy"]];
    
}

/**
    获取结算数据
 */
- (void)requestDataWithYear:(NSString *)date{
    
    NSDictionary *dict = @{@"year":@([date integerValue]),
                           @"store_id":@(StoreId)
                           };
    [Http_url POST:@"all_store_jiesuan" dict:dict showHUD:NO WithSuccessBlock:^(id data) {
        if ([[data objectForKey:@"code"] integerValue] == 200){
            NSDictionary *dic = data[@"data"];
            [self.dataSource removeAllObjects];
            if (![dic isKindOfClass:[NSNull class]]){
                self.dataSource = [dic[@"list"] mutableCopy];
                if (self.currentIndex == 0){
                    [self.headerView.dateBtn setTitle:[NSString stringWithFormat:@"%@年",date] forState:(UIControlStateNormal)];
                    self.headerView.getMoneyLabel.text = [NSString stringWithFormat:@"已结算：¥%@",dic[@"y_jiesuan"]];
                    self.headerView.restMoneyLabel.text = [NSString stringWithFormat:@"待结算：¥%@",dic[@"d_jiesuan"]];
                }
            }
            [self.mainTableView reloadData];
            
        }
        
    } WithFailBlock:^(id data) {
        
    }];
}

/**
    获取提现数据
 */
- (void)requestDataWithYearAndMonth:(NSString *)date{
    NSDictionary *dict = @{@"store_id":StoreIdString,
                           @"keyword":date
                           };
    [Http_url POST:@"pd_cash_list" dict:dict showHUD:NO WithSuccessBlock:^(id data) {
        if ([[data objectForKey:@"code"] integerValue] == 200){
            NSDictionary *dic = [data objectForKey:@"data"];
            [self.dataSource removeAllObjects];
            if (![dic isKindOfClass:[NSNull class]]){
                self.dataSource = [dic[@"data"] mutableCopy];
                if(self.currentIndex == 1){
                    [self.headerView.dateBtn setTitle:date forState:(UIControlStateNormal)];
                    self.headerView.getMoneyLabel.text = [NSString stringWithFormat:@"已提现：¥%@",dic[@"total_amount"]];
                    self.headerView.restMoneyLabel.text = [NSString stringWithFormat:@"余额：¥%@",dic[@"balance"]];
                    
                }
                [self.mainTableView reloadData];
            }
        }
        
    } WithFailBlock:^(id data) {
        
    }];
}

- (void)setUI{
    _topBackgroundView = [[UIView alloc]init];
    [_topBackgroundView setFrame:XFrame(0, ViewStart_Y, Screen_W, IFAutoFitPx(88))];
    [_topBackgroundView setBackgroundColor:WhiteColor];
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
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AllbillsHeaderView" owner:self options:nil];
    _headerView = [nib objectAtIndex:0];
    [_headerView setFrame:XFrame(0, 0, Screen_W, 82)];
    _headerView.delegate = self;
    [self.mainTableView setTableHeaderView:_headerView];
    
}

- (void)chooseDate{
    NSDate *minDate = [NSDate br_setYear:1990 month:3 day:12];
    NSDate *maxDate = [NSDate date];
    if (self.currentIndex == 0){
        [BRDatePickerView showDatePickerWithTitle:@"日期" dateType:(BRDatePickerModeY) defaultSelValue:@"2019" minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectValue) {
            
            NSString *dateStr = [NSString stringWithFormat:@"%@年",selectValue];
            [self.headerView.dateBtn setTitle:dateStr forState:(UIControlStateNormal)];
            [self requestDataWithYear:selectValue];
            
        }];
    }else{
        [BRDatePickerView showDatePickerWithTitle:@"日期" dateType:(BRDatePickerModeYM) defaultSelValue:@"2019-05" minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectValue) {
            
            NSString *dateStr = [NSString stringWithFormat:@"%@",selectValue];
            [self.headerView.dateBtn setTitle:dateStr forState:(UIControlStateNormal)];
            [self requestDataWithYearAndMonth:selectValue];
            
        }];
    }

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
    NSDate *date = [NSDate date];
    if (_currentIndex == 1){
        [self requestDataWithYearAndMonth:[IFTools dateToString:date dateFormat:@"yyyy-MM"]];
    }else{
        [self requestDataWithYear:[IFTools dateToString:date dateFormat:@"yyyy"]];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FinancialCell *cell = (FinancialCell *)[tableView dequeueReusableCellWithIdentifier:@"FinancialCell"];
    if (!cell){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FinancialCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSDictionary *d;
    if (_dataSource.count> 0){
        d = self.dataSource[indexPath.row];
        if (_currentIndex == 0){
            NSString *timestr = [NSString stringWithFormat:@"%@",d[@"os_month"]];
            NSString *month = [timestr substringFromIndex:timestr.length-2];
            cell.timeLabel.text = [NSString stringWithFormat:@"%@月",month];
            cell.moneyLabel.text = [NSString stringWithFormat:@"¥%@",d[@"amount"]];
            cell.cardLabel.text = [NSString stringWithFormat:@"结算尾号：%@",d[@"ob_no"]];
            if ([d[@"state"] isEqualToString:@"1"]){
                cell.state.text = @"已出账";
            }else if ([d[@"state"] isEqualToString:@"2"]){
                cell.state.text = @"店家已确认";
            }else if ([d[@"state"] isEqualToString:@"3"]){
                cell.state.text = @"平台已审核";
            }else if ([d[@"state"] isEqualToString:@"4"]){
                cell.state.text = @"结算完成";
            }
        }else{
            
            cell.timeLabel.text = [NSString stringWithFormat:@"转至%@账户",d[@"bank_no"]];
            cell.moneyLabel.text = [NSString stringWithFormat:@"¥%@",d[@"amount"]];
            NSInteger timeInterval = [d[@"add_time"] integerValue];
            cell.cardLabel.text = [NSString stringWithFormat:@"%@",[IFTools dateToString:[NSDate dateWithTimeIntervalSince1970:timeInterval] dateFormat:@"yyyy-MM-dd"]];
            if ([d[@"payment_state"] isEqualToString:@"0"]){
                cell.state.text = @"已出账";
            }else if ([d[@"payment_state"] isEqualToString:@"2"]){
                cell.state.text = @"店家已确认";
            }else if ([d[@"payment_state"] isEqualToString:@"3"]){
                cell.state.text = @"平台已审核";
            }else if ([d[@"payment_state"] isEqualToString:@"4"]){
                cell.state.text = @"结算完成";
            }
        }
        
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
