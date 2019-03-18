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

@end

@implementation BusinessStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"营业状态"];
    [self.navigationController.navigationBar setHidden:YES];
    [self setUI];
}

- (void)setUI{
    _status = [[UIImageView alloc]init];
    [_status setFrame:XFrame(IFAutoFitPx(30),ViewStart_Y+IFAutoFitPx(40), IFAutoFitPx(120), IFAutoFitPx(120))];
    [_status setImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:self.status];
    
    _waitStartLab = [[UILabel alloc]init];
    [_waitStartLab setFrame:XFrame(CGRectGetMaxX(_status.frame)+IFAutoFitPx(26), CGRectGetMinY(_status.frame)+IFAutoFitPx(18), IFAutoFitPx(400), IFAutoFitPx(32))];
    [_waitStartLab setText:@"待开始营业"];
    [_waitStartLab setFont:XFont(17)];
    [self.view addSubview:self.waitStartLab];
    
    _timeLab = [[UILabel alloc]init];
    [_timeLab setFrame:XFrame(CGRectGetMaxX(_status.frame)+IFAutoFitPx(26), CGRectGetMaxY(_waitStartLab.frame)+IFAutoFitPx(26), IFAutoFitPx(600), IFAutoFitPx(28))];
    [_timeLab setText:@"营业时间：09:00～22:00"];
    [_timeLab setTextColor:toPCcolor(@"#666666")];
    [_timeLab setFont:XFont(15)];
    [self.view addSubview:self.timeLab];
    
    _stop = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_stop setFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(_status.frame)+IFAutoFitPx(82), Screen_W-IFAutoFitPx(60), IFAutoFitPx(88))];
    [_stop setTitle:@"停止营业" forState:(UIControlStateNormal)];
    [_stop setBackgroundColor:IFThemeBlueColor];
    [_stop addTarget:self action:@selector(CloseDoor) forControlEvents:(UIControlEventTouchUpInside)];
    [_stop.titleLabel setFont:XFont(17)];
    _stop.layer.cornerRadius = IFAutoFitPx(6);
    _stop.layer.masksToBounds = YES;
    [self.view addSubview:self.stop];
    
    _bottomLab = [[UILabel alloc]init];
    [_bottomLab setFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(_stop.frame)+IFAutoFitPx(32), Screen_W-IFAutoFitPx(60), IFAutoFitPx(78))];
    [_bottomLab setText:@"当您希望长时间不再接受订单时m，请点击上方按钮停止营业，开启后需要手动恢复"];
    [_bottomLab setFont:XFont(14)];
    [_bottomLab setTextColor:toPCcolor(@"#666666")];
    [_bottomLab setNumberOfLines:2];
    [self.view addSubview:self.bottomLab];
}

- (void)CloseDoor{
    NSLog(@"关门");
}

//- (UIImageView *)status{
//    if (!_status){
//        _status = [[UIImageView alloc]init];
//    }
//    return _status;
//}
//
//- (UILabel *)waitStartLab{
//    if (!_waitStartLab){
//        _waitStartLab = [[UILabel alloc]init];
//
//    }
//    return _waitStartLab;
//}
//
//- (UILabel *)timeLab{
//    if (!_timeLab){
//        _timeLab = [[UILabel alloc]init];
//
//    }
//    return _timeLab;
//}
//
//- (UIButton *)stop{
//    if (!_stop){
//        _stop = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    }
//    return _stop;
//}
//
//- (UILabel *)bottomLab{
//    if (!_bottomLab){
//        _bottomLab = [[UILabel alloc]init];
//    }
//    return _bottomLab;
//}

@end
