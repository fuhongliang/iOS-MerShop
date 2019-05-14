//
//  BusinessStatusViewController.m
//  MerShop
//
//  Created by mac on 2019/3/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BusinessStatusViewController.h"

@interface BusinessStatusViewController ()
@property (nonatomic ,strong)UIImageView *status;
@property (nonatomic ,strong)UILabel *waitStartLab;
@property (nonatomic ,strong)UILabel *timeLab;
@property (nonatomic ,strong)UIButton *stop;
@property (nonatomic ,strong)UILabel *bottomLab;
@property (nonatomic ,copy)NSString *startTime;
@property (nonatomic ,copy)NSString *endTime;
@property (nonatomic ,assign)NSInteger store_state;
@property (nonatomic ,assign)BOOL close;

@end

@implementation BusinessStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"营业状态"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setHidden:YES];
    NSDictionary *userDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    _store_state = [[userDict objectForKey:@"store_state"] integerValue];
    _startTime = [userDict objectForKey:@"work_start_time"];
    _endTime = [userDict objectForKey:@"work_end_time"];
    if (_store_state == 0){
        self.close = YES;
    }else{
        self.close = NO;
    }
    [self setUI];
}

- (void)setUI{
    _status = [[UIImageView alloc]init];
    [_status setFrame:XFrame(IFAutoFitPx(30),ViewStart_Y+IFAutoFitPx(40), IFAutoFitPx(120), IFAutoFitPx(120))];
    [_status setImage:[UIImage imageNamed:@"personal_ic_yyzt"]];
    _status.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.status];
    if (_store_state == 0){
        [self.status setImage:[UIImage imageNamed:@"yingye_ic_weiyingye"]];
    }else{
        [self.status setImage:[UIImage imageNamed:@"yingye_ic_yiyingye"]];
    }

    
    _waitStartLab = [[UILabel alloc]init];
    [_waitStartLab setFrame:XFrame(CGRectGetMaxX(_status.frame)+IFAutoFitPx(26), CGRectGetMinY(_status.frame)+IFAutoFitPx(18), IFAutoFitPx(400), IFAutoFitPx(32))];
    [_waitStartLab setFont:XFont(17)];
    [self.view addSubview:self.waitStartLab];
    
    _timeLab = [[UILabel alloc]init];
    [_timeLab setFrame:XFrame(CGRectGetMaxX(_status.frame)+IFAutoFitPx(26), CGRectGetMaxY(_waitStartLab.frame)+IFAutoFitPx(26), IFAutoFitPx(600), IFAutoFitPx(28))];
    [_timeLab setText:[NSString stringWithFormat:@"%@~%@",_startTime,_endTime]];
    [_timeLab setTextColor:toPCcolor(@"#666666")];
    [_timeLab setFont:XFont(15)];
    [self.view addSubview:self.timeLab];
    
    _stop = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_stop setFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(_status.frame)+IFAutoFitPx(82), Screen_W-IFAutoFitPx(60), IFAutoFitPx(88))];
    [_stop setBackgroundColor:IFThemeBlueColor];
    [_stop addTarget:self action:@selector(CloseDoor) forControlEvents:(UIControlEventTouchUpInside)];
    [_stop.titleLabel setFont:XFont(17)];
    
    _stop.layer.cornerRadius = IFAutoFitPx(6);
    _stop.layer.masksToBounds = YES;
    [self.view addSubview:self.stop];
    
    _bottomLab = [[UILabel alloc]init];
    [_bottomLab setFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(_stop.frame)+IFAutoFitPx(30), Screen_W-IFAutoFitPx(60), IFAutoFitPx(78))];
    [_bottomLab setText:@"当您希望长时间不再接受订单时，请点击上方按钮停止营业，开启后需要手动恢复"];
    [_bottomLab setFont:XFont(14)];
    [_bottomLab setTextColor:toPCcolor(@"#666666")];
    [_bottomLab setNumberOfLines:0];
    [self.view addSubview:self.bottomLab];
    
    NSDictionary *userDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSInteger store_state = [[userDict objectForKey:@"store_state"] integerValue];
    if (store_state == 0){
        [_waitStartLab setText:@"已停止营业"];
        [_stop setTitle:@"开始营业" forState:(UIControlStateNormal)];
    }else{
        [_waitStartLab setText:@"正在营业"];
        [_stop setTitle:@"停止营业" forState:(UIControlStateNormal)];
    }
}

- (void)CloseDoor{
    NSLog(@"关门");
    _close = !_close;
    if (_close == YES){
        [self setStoreState:0];
    }else{
        [self setStoreState:1];
    }
}

- (void)setStoreState:(NSInteger )number{
    NSString *title;
    if (number == 0){
        title = @"确定停止营业吗？";
    }else{
        title = @"确定开始营业吗？";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        __weak typeof(self) weakSelf = self;
        [Http_url POST:@"store_set_workstate" dict:@{@"store_id":@(StoreId),@"store_state":@(number)} showHUD:YES WithSuccessBlock:^(id data) {
            if (data){
                if (number == 0){
                    NSMutableDictionary *userDict1 = [[NSMutableDictionary alloc]initWithDictionary:UserInfoDict];
                    [userDict1 setValue:@"0" forKey:@"store_state"];
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    [user setObject:userDict1 forKey:@"userInfo"];
                    [weakSelf.waitStartLab setText:@"已停止营业"];
                    [weakSelf.stop setTitle:@"开始营业" forState:(UIControlStateNormal)];
                    [weakSelf.status setImage:[UIImage imageNamed:@"yingye_ic_weiyingye"]];
                }else{
                    NSMutableDictionary *userDict1 = [[NSMutableDictionary alloc]initWithDictionary:UserInfoDict];
                    [userDict1 setValue:@"1" forKey:@"store_state"];
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    [user setObject:userDict1 forKey:@"userInfo"];
                    [weakSelf.waitStartLab setText:@"正在营业"];
                    [weakSelf.stop setTitle:@"停止营业" forState:(UIControlStateNormal)];
                    [weakSelf.status setImage:[UIImage imageNamed:@"yingye_ic_yiyingye"]];
                }
                
            }
            
        } WithFailBlock:^(id data) {
            
        }];
    }]];
    [self presentViewController:alert animated:YES completion:nil];

}

@end
