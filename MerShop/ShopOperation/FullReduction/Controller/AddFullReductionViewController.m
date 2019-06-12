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

@interface AddFullReductionViewController ()<UITableViewDelegate,UITableViewDataSource,FullReductionHeadViewDelegate,FullReductionFootViewDelegate,UITextFieldDelegate,FullReductionCellDelegate,THDatePickerViewDelegate>
@property (nonatomic ,strong)UITableView *mainTableView;
@property (nonatomic ,strong)FullReductionHeadView *headerView;
@property (nonatomic ,strong)FullReductionFootView *footerView;
@property (nonatomic ,weak) THDatePickerView *dateView;
@property (nonatomic ,strong)UIView *dateBgview;
@property (nonatomic ,copy)NSString *fullStr;
@property (nonatomic ,copy)NSString *reduceStr;
@property (nonatomic ,strong)NSMutableArray *dataSource;

@property (nonatomic ,copy)NSString *startOrEnd;//判断点击开始时间还是结束时间

@property (nonatomic ,copy)NSString *activityName;
@property (nonatomic ,copy)NSString *startTime;
@property (nonatomic ,copy)NSString *endTime;
@property (nonatomic ,copy)NSString *remarkStr;
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
    _headerView.delegate = self;
    _headerView.activityText.delegate = self;
    [self.mainTableView setTableHeaderView:_headerView];
    
    UIButton *saveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [saveBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [saveBtn setBackgroundColor:IFThemeBlueColor];
    [saveBtn setTitleColor:WhiteColor forState:(UIControlStateNormal)];
    [saveBtn addTarget:self action:@selector(submit) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:saveBtn];
    [saveBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(0);
        make.right.equalTo(self.view.right).offset(0);
        make.bottom.equalTo(self.view.bottom).offset(0);
        make.height.equalTo(55);
    }];
    
    _footerView = [[[NSBundle mainBundle]loadNibNamed:@"FullReductionFootView" owner:self options:nil] objectAtIndex:0];
    _footerView.delegate = self;
    _footerView.priceText1.delegate = self;
    _footerView.priceText2.delegate = self;
    _footerView.remarkText.delegate = self;
    [_footerView setFrame:XFrame(0, 1, Screen_W, 354)];
    [self.mainTableView setTableFooterView:_footerView];
    
    _dateBgview = [[UIView alloc]init];
    [_dateBgview setFrame:XFrame(0, 0, Screen_W, Screen_H)];
    [_dateBgview setBackgroundColor:[UIColor blackColor]];
    [_dateBgview setAlpha:0.4];
    [_dateBgview setHidden:YES];
    [self.view addSubview:_dateBgview];
    
    THDatePickerView *dateView = [[THDatePickerView alloc] initWithFrame:CGRectMake(0, Screen_H, Screen_W, 300)];
    dateView.delegate = self;
    dateView.title = @"请选择时间";
    [self.view addSubview:dateView];
    self.dateView = dateView;
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
    cell.fullStr.text = [self.dataSource[indexPath.row] objectForKey:@"price"];
    cell.reduceStr.text = [self.dataSource[indexPath.row] objectForKey:@"discount"];
    return cell;
}

#pragma mark - footerView添加,提交代理方法
- (void)addFullReduction{
    _fullStr = [NSString stringWithFormat:@"%@",_footerView.priceText1.text];
    _reduceStr = [NSString stringWithFormat:@"%@",_footerView.priceText2.text];
    if (self.dataSource.count>=4){
        [[IFUtils share]showErrorInfo:@"最多只能添加4条规则"];
        return;
    }
    if ([_fullStr integerValue] <= [_reduceStr integerValue]){
        [[IFUtils share]showErrorInfo:@"满减金额必须小于规则金额"];
        return;
    }
    if (_fullStr.length == 0 || _reduceStr.length == 0){
        [[IFUtils share]showErrorInfo:@"请添加满减价格"];
        return;
    }else{
        NSDictionary *dict = @{@"price":_fullStr,
                               @"discount":_reduceStr
                               };
        [self.dataSource addObject:dict];
        [self.mainTableView reloadData];
        _footerView.priceText1.text = @"";
        _footerView.priceText2.text = @"";
    }
}

- (void)submit{
    if (_activityName == nil){
        [[IFUtils share]showErrorInfo:@"请输入活动名称！"];
        return;
    }
    if (_startTime == nil){
        [[IFUtils share]showErrorInfo:@"请输入开始时间！"];
        return;
    }
    if (_endTime == nil){
        [[IFUtils share]showErrorInfo:@"请输入结束时间！"];
        return;
    }
    if (self.dataSource.count == 0){
        [[IFUtils share]showErrorInfo:@"请输入满减金额！"];
        return;
    }
    if (self.footerView.remarkText.text.length == 0){
        _remarkStr = @"";
    }else{
        _remarkStr = self.footerView.remarkText.text;
    }
    NSDictionary *dict = @{@"store_id":[UserInfoDict objectForKey:@"store_id"],
                           @"mansong_name":_activityName,
                           @"start_time":_startTime,
                           @"end_time":_endTime,
                           @"remark":_remarkStr,
                           @"rules":self.dataSource
                           };
    [Http_url POST:@"mamsong_edit" dict:dict showHUD:YES WithSuccessBlock:^(id data) {
        
        if ([[data objectForKey:@"code"] integerValue] == 200){
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } WithFailBlock:^(id data) {
        
    }];
}

#pragma mark - TextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 0){
        _fullStr = textField.text;
    }else if (textField.tag == 1){
        _reduceStr = textField.text;
    }else if (textField.tag == 2){
        _remarkStr = textField.text;
    }else if (textField.tag == 3){
        _activityName = textField.text;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.headerView.activityText){
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.headerView.activityText.text.length >= 20) {
            self.headerView.activityText.text = [textField.text substringToIndex:20];
            return NO;
        }
    }
    return YES;
}

- (void)showDatePickerView:(NSString *)data{
    self.startOrEnd = data;
    [self.dateBgview setHidden:NO];
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, Screen_H - 300, Screen_W, 300);
        [self.dateView show];
    }];

}

#pragma mark - THDatePickerViewDelegate
/**
 保存按钮代理方法

 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    NSLog(@"保存点击");
    if ([self.startOrEnd isEqualToString:@"开始"]){
        [self.headerView.startTimeBtn setTitle:timer forState:(UIControlStateNormal)];
        self.startTime = timer;
    }else{
        [self.headerView.endTimeBtn setTitle:timer forState:(UIControlStateNormal)];
        self.endTime = timer;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, Screen_H, Screen_W, 300);
        [self.dateBgview setHidden:YES];
    }];
    
}

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate {
    NSLog(@"取消点击");
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, Screen_H, Screen_W, 300);
        [self.dateBgview setHidden:YES];
    }];
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
        [_mainTableView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y-55)];
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
