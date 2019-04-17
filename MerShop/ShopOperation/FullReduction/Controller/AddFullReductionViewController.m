//
//  AddFullReductionViewController.m
//  MerShop
//
//  Created by mac on 2019/4/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AddFullReductionViewController.h"
#import "FullReductionCell.h"
#import "FullReductionHeadView.h"
#import "FullReductionFootView.h"

@interface AddFullReductionViewController ()<UITableViewDelegate,UITableViewDataSource,FullReductionFootViewDelegate,UITextFieldDelegate,FullReductionCellDelegate>
@property (nonatomic ,strong)UITableView *mainTableView;
@property (nonatomic ,strong)FullReductionHeadView *headerView;
@property (nonatomic ,strong)FullReductionFootView *footerView;
@property (nonatomic ,copy)NSString *fullStr;
@property (nonatomic ,copy)NSString *reduceStr;
@property (nonatomic ,strong)NSMutableArray *dataSource;
@end

@implementation AddFullReductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"添加活动"];
    [self.view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [self setUI];
}

- (void)setUI{
    [self.view addSubview:self.mainTableView];
    
    _headerView = [[[NSBundle mainBundle]loadNibNamed:@"FullReductionHeadView" owner:self options:nil] objectAtIndex:0];
    [_headerView setFrame:XFrame(0, 0, Screen_W, 220)];
    [self.mainTableView setTableHeaderView:_headerView];
    
    _footerView = [[[NSBundle mainBundle]loadNibNamed:@"FullReductionFootView" owner:self options:nil] objectAtIndex:0];
    _footerView.delegate = self;
    [_footerView setFrame:XFrame(0, 1, Screen_W, 354)];
    [self.mainTableView setTableFooterView:_footerView];
}

#pragma mark - TableViewDelegate && TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FullReductionCell *cell = (FullReductionCell *)[tableView dequeueReusableCellWithIdentifier:@"FullReductionCell"];
    if (!cell){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FullReductionCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.delegate = self;
    cell.tag = indexPath.row;
    cell.fullStr.text = [self.dataSource[indexPath.row] objectForKey:@"full"];
    cell.reduceStr.text = [self.dataSource[indexPath.row] objectForKey:@"reduce"];
    return cell;
}


- (void)addFullReduction{
    _fullStr = [NSString stringWithFormat:@"%@",_footerView.priceText1.text];
    _reduceStr = [NSString stringWithFormat:@"%@",_footerView.priceText2.text];
    if (_fullStr.length == 0 || _reduceStr.length == 0){
        [[IFUtils share]showErrorInfo:@"请添加满减价格"];
        return;
    }else{
        NSDictionary *dict = @{@"full":_fullStr,
                               @"reduce":_reduceStr
                               };
        [self.dataSource addObject:dict];
        [self.mainTableView reloadData];
        _footerView.priceText1.text = @"";
        _footerView.priceText2.text = @"";
    }
}

#pragma mark - TextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 0){
        _fullStr = textField.text;
    }else if (textField.tag == 1){
        _reduceStr = textField.text;
    }
    
}

#pragma mark - FullReductionCellDelegate
- (void)deleteData:(id)data{
    FullReductionCell *a = (FullReductionCell *)data;
    [self.dataSource removeObjectAtIndex:a.tag];
    [self.mainTableView reloadData];
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
        [_mainTableView setBackgroundColor:toPCcolor(@"#f5f5f5")];
        [_mainTableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
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
