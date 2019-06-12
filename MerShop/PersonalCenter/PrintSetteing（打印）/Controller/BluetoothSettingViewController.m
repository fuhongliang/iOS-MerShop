//
//  BluetoothSettingViewController.m
//  MerShop
//
//  Created by mac on 2019/4/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BluetoothSettingViewController.h"
#import "BlueSettingView.h"

@interface BluetoothSettingViewController ()<BlueSettingViewDelegate>
@property (nonatomic ,strong)UITableView *tableview;
@property (nonatomic ,strong)BlueSettingView *headview;
@property (nonatomic ,strong)JWBluetoothManage *manage;
@end

@implementation BluetoothSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"蓝牙设置"];
    [self.view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [self setUI];
    self.manage = [JWBluetoothManage sharedInstance];
}

- (void)setUI{
    [self.view addSubview:self.tableview];
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"BlueSettingView" owner:self options:nil];
    _headview = [nib objectAtIndex:0];
    [_headview setFrame:XFrame(0, 0, Screen_W, Screen_H-ViewStart_Y)];
    _headview.delegate = self;
    [self.tableview setTableHeaderView:_headview];
}

- (void)print{
    NSDictionary *dict;
    [self printOrderWithDict:dict];
}

- (UITableView *)tableview{
    if (!_tableview){
        _tableview = [[UITableView alloc]init];
        [_tableview setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
        [_tableview setBackgroundColor:toPCcolor(@"#f5f5f5")];

    }
    return _tableview;
}



@end
