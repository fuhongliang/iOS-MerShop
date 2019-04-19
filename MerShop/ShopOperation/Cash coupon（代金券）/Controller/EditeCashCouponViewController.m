//
//  EditeCashCouponViewController.m
//  MerShop
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "EditeCashCouponViewController.h"
#import "TimePickerView.h"

@interface EditeCashCouponViewController ()<EditeCouponViewDelegate,TimePickerViewDelegate,THDatePickerViewDelegate,UITextFieldDelegate>
@property (nonatomic ,strong)EditeCouponView *editeView;
@property (nonatomic ,weak)TimePickerView *numberPickerView;
@property (nonatomic ,weak)THDatePickerView *dateView;
@property (nonatomic ,strong)UIView *pickerBgView;

@property (nonatomic ,copy)NSString *selectNumStr;
@property (nonatomic ,copy)NSString *selectTimeStr;
@property (nonatomic ,copy)NSString *limitNumber;
@property (nonatomic ,assign)NSInteger lowerLimitNumber;

@end

@implementation EditeCashCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"添加活动"];
    _lowerLimitNumber = 1;
    [self.view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [Http_url POST:@"mianzhi_list" dict:nil showHUD:NO WithSuccessBlock:^(id data) {
        NSLog(@"%@",data);
        NSArray *a = [[NSBundle mainBundle]loadNibNamed:@"TimePickerView" owner:self options:nil];
        self.numberPickerView = [a objectAtIndex:0];
        [self.numberPickerView setFrame:XFrame(0, Screen_H, Screen_W, 283)];
        self.numberPickerView.delegate = self;
        self.numberPickerView.titleStr = @"请选择面值";
        self.numberPickerView.data = [data objectForKey:@"data"];
        [self.view addSubview:self.numberPickerView];
        
    } WithFailBlock:^(id data) {
        
    }];

    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)setUI{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EditeCouponView" owner:self options:nil];
    _editeView = [nib objectAtIndex:0];
    _editeView.delegate = self;
    if (_lastVCDict != nil){
        [self fillEdite:_lastVCDict];
    }
    [_editeView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [self.view addSubview:self.editeView];
    
    _pickerBgView = [[UIView alloc]init];
    [_pickerBgView setBackgroundColor:[UIColor blackColor]];
    [_pickerBgView setFrame:XFrame(0, 0, Screen_W, Screen_H)];
    [_pickerBgView setAlpha:0.4];
    [_pickerBgView setHidden:YES];
    [self.view addSubview:_pickerBgView];
    
    THDatePickerView *dateView = [[THDatePickerView alloc] initWithFrame:CGRectMake(0, Screen_H, Screen_W, 300)];
    dateView.delegate = self;
    dateView.title = @"请选择时间";
    [self.view addSubview:dateView];
    self.dateView = dateView;
}

- (void)fillEdite:(NSDictionary *)dict{
    _editeView.cashCouponNameText.text = dict[@"voucher_title"];
//    [_editeView.selectNumber setTitle:dict[@""] forState:(UIControlStateNormal)];
    _editeView.serviceConditionText.text = dict[@"voucher_limit"];
    [_editeView.selectTime setTitle:dict[@"voucher_end_date"] forState:(UIControlStateNormal)];
    _editeView.couponNumberText.text = [NSString stringWithFormat:@"%@",dict[@"voucher_surplus"]];
    _editeView.limitLab.text = [NSString stringWithFormat:@"%@",dict[@"voucher_eachlimit"]];
}

/**
 选择器弹出
 */
- (void)showPickerView:(id)data{
    if ([data isEqualToString:@"时间"]){
        [self.pickerBgView setHidden:NO];
        [UIView animateWithDuration:0.3 animations:^{
            self.dateView.frame = CGRectMake(0, Screen_H - 300, Screen_W, 300);
            [self.dateView show];
        }];
    }else{
        [self.pickerBgView setHidden:NO];
        [UIView animateWithDuration:0.3 animations:^{
            self.numberPickerView.frame = CGRectMake(0, Screen_H - 283, Screen_W, 283);
        }];
    }
}


#pragma mark - NumberPickerViewDelegate
/**
选择金额 取消按钮代理方法
 */
- (void)cancel{
    [self.pickerBgView setHidden:YES];
    [UIView animateWithDuration:0.3 animations:^{
        [self.numberPickerView setFrame:XFrame(0, Screen_H, Screen_W, 283)];
    }];
}
/**
 选择金额 确定按钮代理方法
 @param data 选择的券的面额
 */
- (void)ensure:(id)data{
    [self.pickerBgView setHidden:YES];
    _selectNumStr = data;
    [_editeView.selectNumber setTitle:data forState:(UIControlStateNormal)];
    [UIView animateWithDuration:0.3 animations:^{
        [self.numberPickerView setFrame:XFrame(0, Screen_H, Screen_W, 283)];
    }];
}

#pragma mark - THDatePickerViewDelegate
/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    NSLog(@"保存点击");
    _selectTimeStr = timer;
    [_editeView.selectTime setTitle:timer forState:(UIControlStateNormal)];
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, Screen_H, Screen_W, 300);
        [self.pickerBgView setHidden:YES];
    }];
    
}

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate {
    NSLog(@"取消点击");
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, Screen_H, Screen_W, 300);
        [self.pickerBgView setHidden:YES];
    }];
}

#pragma mark - EditeCouponViewDelegate
- (void)submit{

    NSDictionary *dict = @{@"store_id":@(StoreId),
                           @"title":_editeView.cashCouponNameText.text,
                           @"mianzhi":_editeView.selectNumber.titleLabel.text,
                           @"limit_price":_editeView.serviceConditionText.text,
                           @"describe":_editeView.couponDescription.text,
                           @"end_time":_editeView.selectTime.titleLabel.text,
                           @"total_nums":@([_editeView.couponNumberText.text integerValue]),
                           @"each_limit":@([_editeView.limitLab.text integerValue])
                           };
    NSLog(@"%@",dict);
    
    [Http_url POST:@"voucher_edit" dict:dict showHUD:YES WithSuccessBlock:^(id data) {
        
        if ([[data objectForKey:@"code"] integerValue] == 200){
            [self.navigationController popViewControllerAnimated:YES];
        }
    } WithFailBlock:^(id data) {
        
    }];
}
/**
 减少按钮代理方法
 */
- (void)reduceNumber{
    if (_lowerLimitNumber == 1){
        NSLog(@"--------最低数量");
        return;
    }else{
        _lowerLimitNumber = _lowerLimitNumber - 1;
        _editeView.limitLab.text = [NSString stringWithFormat:@"%ld",(long)_lowerLimitNumber];
    }
}
/**
 增加按钮代理方法
 */
- (void)addNumber{
    _lowerLimitNumber ++;
    _editeView.limitLab.text = [NSString stringWithFormat:@"%ld",(long)_lowerLimitNumber];
}

@end
