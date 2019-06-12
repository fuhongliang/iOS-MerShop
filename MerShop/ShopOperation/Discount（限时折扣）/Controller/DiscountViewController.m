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
#import "EditeActivityTableViewCell.h"
#import "AddActivityGoodsViewController.h"

@interface DiscountViewController ()<UITableViewDataSource,UITableViewDelegate,ActivityHeaderViewDelegate,THDatePickerViewDelegate,EditeActivityTableViewCellDelegate,UITextFieldDelegate>
@property (nonatomic ,strong)UITableView *mainTableView;
@property (nonatomic ,strong)ActivityHeaderView *headerView;
@property (nonatomic ,assign)NSInteger lowerLimitNumber;
@property (nonatomic ,weak)THDatePickerView *dateView;
@property (nonatomic ,copy)NSString *selectTimeStr;
@property (nonatomic ,strong)UIView *dateBgview;
@property (nonatomic ,copy)NSString *startOrEnd;
@property (nonatomic ,strong)NSMutableArray *dataArr;
@property (nonatomic ,copy)NSString *discountId;
@end

@implementation DiscountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"编辑活动"];
    [self.view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    _lowerLimitNumber = 1;
    [self setUI];
    [self reloadListData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.dataArr = [[IFUserDefaults objectForKey:@"GoodsArray"] mutableCopy];
    [self.mainTableView reloadData];
}

- (void)reloadListData{
    NSString *lid = [NSString stringWithFormat:@"%ld",(long)self.xianshi_id];
    if (self.activityInfo != nil){
        NSDictionary *dict = @{@"xianshi_id":lid,
                               @"store_id":StoreIdString
                               };
        [Http_url POST:@"xianshi_info" dict:dict showHUD:NO WithSuccessBlock:^(id data) {
            NSLog(@"%@",data);
            if ([[data objectForKey:@"code"] integerValue] == 200){
                //点击编辑进来，在添加页面，显示活动信息
                NSString *name = data[@"data"][@"xianshi_name"];
                NSString *mark = data[@"data"][@"xianshi_title"];
                NSString *descStr = data[@"data"][@"xianshi_explain"];
                self.discountId = [NSString stringWithFormat:@"%@",data[@"data"][@"xianshi_id"]];
                self.headerView.activityNameText.text = [NSString stringWithFormat:@"%@",name];
                NSInteger start = [data[@"data"][@"start_time"] integerValue];
                NSString *startTime = [IFTools dateToString:[NSDate dateWithTimeIntervalSince1970:start] dateFormat:@"yyyy-MM-dd HH:mm"];
                [self.headerView.startTimeBtn setTitle:startTime forState:(UIControlStateNormal)];
                NSInteger end = [data[@"data"][@"end_time"] integerValue];
                NSString *endTime = [IFTools dateToString:[NSDate dateWithTimeIntervalSince1970:end] dateFormat:@"yyyy-MM-dd HH:mm"];
                [self.headerView.endTimeBtn setTitle:endTime forState:(UIControlStateNormal)];
                if ([mark isKindOfClass:[NSNull class]]){
                    self.headerView.markText.text = @"";
                }else{
                    self.headerView.markText.text = [NSString stringWithFormat:@"%@",mark];
                }
                self.headerView.descText.text = [NSString stringWithFormat:@"%@",descStr];
                self.headerView.numberLab.text = [NSString stringWithFormat:@"%@",data[@"data"][@"lower_limit"]];
                self.lowerLimitNumber = [data[@"data"][@"lower_limit"] integerValue];
                self.dataArr = [data[@"data"][@"goods_list"] mutableCopy];
                [IFUserDefaults setObject:self.dataArr forKey:@"GoodsArray"];
                [self.mainTableView reloadData];

            }

        } WithFailBlock:^(id data) {
            
        }];
    }
}



- (void)setUI{
    [self.view addSubview:self.mainTableView];
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ActivityHeaderView" owner:self options:nil];
    _headerView = [nib objectAtIndex:0];
    _headerView.delegate = self;
    _headerView.numberLab.text = [NSString stringWithFormat:@"%ld",(long)_lowerLimitNumber];
    _headerView.activityNameText.delegate = self;
    [_headerView setFrame:XFrame(0, 0, Screen_W, 410)];
    
    UIButton *saveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [saveBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [saveBtn setBackgroundColor:IFThemeBlueColor];
    [saveBtn setTitleColor:WhiteColor forState:(UIControlStateNormal)];
    [saveBtn addTarget:self action:@selector(commitAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:saveBtn];
    [saveBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(0);
        make.right.equalTo(self.view.right).offset(0);
        make.bottom.equalTo(self.view.bottom).offset(0);
        make.height.equalTo(55);
    }];
    
    UIView *footerView = [[UIView alloc]init];
    [footerView setFrame:XFrame(0, 0, Screen_W, IFAutoFitPx(276))];
    [footerView setBackgroundColor:toPCcolor(@"#f5f5f5")];
    
    UIView *line  = [[UIView alloc]init];
    [line setFrame:XFrame(0, 0, Screen_W, IFAutoFitPx(1))];
    [line setBackgroundColor:toPCcolor(@"#E5E5E5")];
    [footerView addSubview:line];
    
    UIButton *addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [addBtn setFrame:XFrame(0, IFAutoFitPx(1), Screen_W, IFAutoFitPx(87))];
    [addBtn setBackgroundColor:[UIColor whiteColor]];
    [addBtn setTitle:@"添加" forState:(UIControlStateNormal)];
    [addBtn setTitleColor:IFThemeBlueColor forState:(UIControlStateNormal)];
    addBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [addBtn setImage:[UIImage imageNamed:@"yhq_ic_add"] forState:(UIControlStateNormal)];
    [addBtn addTarget:self action:@selector(clickAddButton) forControlEvents:(UIControlEventTouchUpInside)];
    [footerView addSubview:addBtn];
    
    [_mainTableView setTableHeaderView:_headerView];
    [_mainTableView setTableFooterView:footerView];
    
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

- (void)showPickerView:(NSString *)data{
    self.startOrEnd = data;
    [self.dateBgview setHidden:NO];
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, Screen_H - 300, Screen_W, 300);
        [self.dateView show];
    }];
}
#pragma mark - TextViewDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.headerView.activityNameText){
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.headerView.activityNameText.text.length >= 20) {
            self.headerView.activityNameText.text = [textField.text substringToIndex:20];
            return NO;
        }
    }
    return YES;
}


#pragma mark - THDatePickerViewDelegate
/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    NSLog(@"保存点击");
    _selectTimeStr = timer;
    if ([self.startOrEnd isEqualToString:@"开始"]){
        [_headerView.startTimeBtn setTitle:timer forState:(UIControlStateNormal)];
    }else{
        [_headerView.endTimeBtn setTitle:timer forState:(UIControlStateNormal)];
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


#pragma mark - UITableViewDelegate & UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EditeActivityTableViewCell *cell = (EditeActivityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"EditeActivityTableViewCell"];
    if (!cell){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EditeActivityTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.delegate = self;
    cell.tag = indexPath.row;
    [cell setDataWithDict:self.dataArr[indexPath.row]];
    return cell;
}

#pragma mark - EditeActivityTableViewCellDelegate 删除按钮代理方法
- (void)deleteGoods:(id)data{
    EditeActivityTableViewCell *cell = (EditeActivityTableViewCell *)data;
    [self.dataArr removeObjectAtIndex:cell.tag];
    [IFUserDefaults setObject:self.dataArr forKey:@"GoodsArray"];
    [self.mainTableView reloadData];
}

#pragma mark - ActivityHeaderViewDelegate
- (void)reduceNumber{
    if (_lowerLimitNumber == 1){
        NSLog(@"--------最低数量");
        return;
    }else{
        _lowerLimitNumber = _lowerLimitNumber - 1;
        _headerView.numberLab.text = [NSString stringWithFormat:@"%ld",(long)_lowerLimitNumber];
    }
}
- (void)addNumber{
    _lowerLimitNumber ++;
    _headerView.numberLab.text = [NSString stringWithFormat:@"%ld",(long)_lowerLimitNumber];
}

- (void)clickAddButton{
    AddActivityGoodsViewController *vc = [[AddActivityGoodsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)commitAction{
    if (self.headerView.activityNameText.text.length == 0){
        [[IFUtils share]showErrorInfo:@"请添加活动名称"];
        return;
    }
    if ([self.headerView.startTimeBtn.titleLabel.text isEqualToString:@"请选择"]){
        [[IFUtils share]showErrorInfo:@"请选择开始时间"];
        return;
    }
    if ([self.headerView.endTimeBtn.titleLabel.text isEqualToString:@"请选择"]){
        [[IFUtils share]showErrorInfo:@"请选择结束时间"];
        return;
    }
    if (self.headerView.descText.text.length == 0){
        [[IFUtils share]showErrorInfo:@"请添加活动描述"];
        return;
    }
    if (self.dataArr.count == 0){
        [[IFUtils share]showErrorInfo:@"请添加活动商品"];
        return;
    }
    NSString *markStr;
    if (self.headerView.markText.text.length == 0){
        markStr = @"限时折扣";
    }else{
        markStr = self.headerView.markText.text;
    }
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dict in self.dataArr){
        NSInteger gid = [dict[@"goods_id"] integerValue];
        NSString *discountPrice = dict[@"xianshi_price"];
        NSDictionary *dict = @{@"goods_id":@(gid),
                               @"xianshi_price":discountPrice
                               };
        [arr addObject:dict];
    }
    NSDictionary *dict;
    if (self.activityInfo != nil){
        dict = @{@"xianshi_id":self.discountId,
                   @"store_id":StoreIdString,
               @"xianshi_name":_headerView.activityNameText.text,
              @"xianshi_title":markStr,
            @"xianshi_explain":_headerView.descText.text,
                 @"start_time":_headerView.startTimeBtn.titleLabel.text,
                   @"end_time":_headerView.endTimeBtn.titleLabel.text,
                @"lower_limit":_headerView.numberLab.text,
                 @"goods_list":arr
                 };
    }else{
            dict = @{@"store_id":StoreIdString,
                 @"xianshi_name":_headerView.activityNameText.text,
                @"xianshi_title":markStr,
              @"xianshi_explain":_headerView.descText.text,
                   @"start_time":_headerView.startTimeBtn.titleLabel.text,
                     @"end_time":_headerView.endTimeBtn.titleLabel.text,
                  @"lower_limit":_headerView.numberLab.text,
                   @"goods_list":arr
                    };
    }

    [Http_url POST:@"xianshi_edit" dict:dict showHUD:NO WithSuccessBlock:^(id data) {
        if ([[data objectForKey:@"code"] integerValue] == 200){
            [[IFUtils share]showErrorInfo:@"添加成功"];
            [IFUserDefaults removeObjectForKey:@"GoodsArray"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } WithFailBlock:^(id data) {
        
    }];
}
/**
 返回时候,删除保存的商品
 */
- (void)popViewController{
    [IFUserDefaults removeObjectForKey:@"GoodsArray"];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 懒加载
- (UITableView *)mainTableView{
    if (!_mainTableView){
        _mainTableView = [[UITableView alloc]init];
        [_mainTableView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y-55)];
        [_mainTableView setBackgroundColor:toPCcolor(@"f5f5f5")];
        [_mainTableView setTableFooterView:[[UIView alloc]init]];
        [_mainTableView setDelegate:self];
        [_mainTableView setDataSource:self];
        [_mainTableView setRowHeight:UITableViewAutomaticDimension];
        
    }
    return _mainTableView;
}
- (NSMutableArray *)dataArr{
    if (!_dataArr){
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}
@end
