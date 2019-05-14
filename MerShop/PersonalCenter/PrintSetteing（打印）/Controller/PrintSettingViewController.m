//
//  PrintSettingViewController.m
//  MerShop
//
//  Created by mac on 2019/4/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "PrintSettingViewController.h"
#import "PrintSettringHeaderView.h"
#import "ZJTopImageBottomTitleButton.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BluetoothHelpViewController.h"
#import "BluetoothSettingViewController.h"

@interface PrintSettingViewController ()<UITableViewDelegate,UITableViewDataSource,CBCentralManagerDelegate>
@property (nonatomic ,strong)PrintSettringHeaderView *headerView;
@property (nonatomic ,strong)UITableView *mainTableView;
@property (nonatomic ,strong)JWBluetoothManage *manage;
@property (nonatomic ,strong)ZJTopImageBottomTitleButton *searchBtn;
@property (nonatomic ,strong)CBCentralManager *bluetoothManager;
@property (nonatomic ,strong)NSMutableArray *dataSource;
@property (nonatomic ,strong)UIView *headerView1;
@property (nonatomic ,strong)UIView *headerView2;
@property (nonatomic ,strong)UILabel *connectDevice;
@property (nonatomic ,strong)UILabel *connectState;
//未连接蓝牙之前，搜索加载的菊花
@property (nonatomic ,strong)UIActivityIndicatorView *indicatorView;
//连接蓝牙之后，搜索加载的菊花
@property (nonatomic ,strong)UIActivityIndicatorView *indicatorView1;

@property (nonatomic ,strong)CBPeripheral *currentBluetooth;
@end

@implementation PrintSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"添加打印机"];
    [self.view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    _bluetoothManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    self.manage = [JWBluetoothManage sharedInstance];

    [self setUI];
    [self setHeaderView];
    [self printLab];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    LCWeakSelf(self)
    [self.manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
        if (!error){
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.connectDevice.text = [NSString stringWithFormat:@"%@",perpheral.name];
                weakself.connectState.text = @"已连接";
                weakself.mainTableView.tableHeaderView = weakself.headerView2;
                [weakself.mainTableView reloadData];
                weakself.currentBluetooth = perpheral;

            });
        }else{
            [ProgressShow alertView:self.view Message:error.domain cb:nil];
        }
    }];
}

- (void)setHeaderView{
    UILabel *newDevice = [[UILabel alloc]init];
    [newDevice setFrame:XFrame(IFAutoFitPx(34), IFAutoFitPx(20), Screen_W-IFAutoFitPx(60), IFAutoFitPx(58))];
    [newDevice setText:@"新设备"];
    [newDevice setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [newDevice setTextColor:toPCcolor(@"#808080")];
    [newDevice setFont:XFont(14)];
    [self.headerView1 addSubview:newDevice];
    
    self.indicatorView = [[UIActivityIndicatorView alloc]init];
    self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.headerView1 addSubview:self.indicatorView];
    [self.indicatorView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headerView1.right).offset(-15);
        make.centerY.equalTo(newDevice.centerY).offset(0);
        make.width.offset(15);
        make.height.offset(15);
    }];
    
    [self.mainTableView setTableHeaderView:self.headerView1];
    
    UILabel *myDeviceLab = [[UILabel alloc]init];
    [myDeviceLab setFrame:XFrame(IFAutoFitPx(34), IFAutoFitPx(20), Screen_W-IFAutoFitPx(60), IFAutoFitPx(58))];
    [myDeviceLab setText:@"我的设备"];
    [myDeviceLab setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [myDeviceLab setTextColor:toPCcolor(@"#808080")];
    [myDeviceLab setFont:XFont(14)];
    [self.headerView2 addSubview:myDeviceLab];
    
    UIView *view1 = [[UIView alloc]init];
    [view1 setBackgroundColor:[UIColor whiteColor]];
    [view1 setFrame:XFrame(0, IFAutoFitPx(88), Screen_W, IFAutoFitPx(96))];
    [self.headerView2 addSubview:view1];
    
    UIImageView *img = [[UIImageView alloc]init];
    [img setFrame:XFrame(IFAutoFitPx(34), IFAutoFitPx(31), IFAutoFitPx(30), IFAutoFitPx(30))];
    [img setImage:[UIImage imageNamed:@"dyj_ic_lanya"]];
    [view1 addSubview:img];
    
    UIButton *printBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [printBtn setFrame:XFrame(Screen_W-IFAutoFitPx(30)-IFAutoFitPx(32), IFAutoFitPx(30), IFAutoFitPx(32), IFAutoFitPx(32))];
    [printBtn setImage:[UIImage imageNamed:@"dyj_ic_sbxqgt"] forState:(UIControlStateNormal)];
    [printBtn addTarget:self action:@selector(goPrintSettingView) forControlEvents:(UIControlEventTouchUpInside)];
    [view1 addSubview:printBtn];
    
    _connectDevice = [[UILabel alloc]init];
    [_connectDevice setFrame:XFrame(CGRectGetMaxX(img.frame)+IFAutoFitPx(20), IFAutoFitPx(10), IFAutoFitPx(500), IFAutoFitPx(38))];
    [_connectDevice setTextColor:toPCcolor(@"#000000")];
    [_connectDevice setFont:XFont(14)];
    [view1 addSubview:_connectDevice];
    
    _connectState = [[UILabel alloc]init];
    [_connectState setFrame:XFrame(CGRectGetMaxX(img.frame)+IFAutoFitPx(20), CGRectGetMaxY(_connectDevice.frame), IFAutoFitPx(500), IFAutoFitPx(38))];
    [_connectState setTextColor:IFThemeBlueColor];
    [_connectState setFont:XFont(11)];
    [_connectState setText:@"已连接"];
    [view1 addSubview:_connectState];
    
    UILabel *newDevice2 = [[UILabel alloc]init];
    [newDevice2 setFrame:XFrame(IFAutoFitPx(34), CGRectGetMaxY(view1.frame)+IFAutoFitPx(30), Screen_W-IFAutoFitPx(60), IFAutoFitPx(48))];
    [newDevice2 setText:@"新设备"];
    [newDevice2 setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [newDevice2 setTextColor:toPCcolor(@"#808080")];
    [newDevice2 setFont:XFont(14)];
    [self.headerView2 addSubview:newDevice2];
    
    self.indicatorView1 = [[UIActivityIndicatorView alloc]init];
    self.indicatorView1.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.headerView2 addSubview:self.indicatorView1];
    [self.indicatorView1 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headerView2.right).offset(-15);
        make.centerY.equalTo(newDevice2.centerY).offset(0);
        make.width.offset(15);
        make.height.offset(15);
    }];
    

}

- (void)setUI{
    [self.view addSubview:self.mainTableView];
    
    UIView *bottomView = [[UIView alloc]init];
    [bottomView setBackgroundColor:[UIColor whiteColor]];
    [bottomView setFrame:XFrame(0, CGRectGetMaxY(_mainTableView.frame), Screen_W, IFAutoFitPx(96))];
    [self.view addSubview:bottomView];
    
    UIView *line = [[UIView alloc]init];
    [line setFrame:XFrame(0, 0, Screen_W, IFAutoFitPx(1))];
    [line setBackgroundColor:toPCcolor(@"#CCCCCC")];
    [bottomView addSubview:line];
    
    _searchBtn = [[ZJTopImageBottomTitleButton alloc]init];
    [_searchBtn setFrame:XFrame(0, IFAutoFitPx(1), Screen_W, IFAutoFitPx(80))];
    [_searchBtn setImage:[UIImage imageNamed:@"dyj_ic_sousuosb"] forState:(UIControlStateNormal)];
    [_searchBtn setTitle:@"搜索设备" forState:(UIControlStateNormal)];
    [_searchBtn setTitleColor:IFThemeBlueColor forState:(UIControlStateNormal)];
    [_searchBtn.titleLabel setFont:XFont(11)];
    [_searchBtn addTarget:self action:@selector(searchBluetooth) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:_searchBtn];
}

- (void)printLab{
    UIButton *printbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [printbtn setTitle:@"帮助" forState:(UIControlStateNormal)];
    [printbtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [printbtn setBackgroundColor:IFThemeBlueColor];
    [printbtn addTarget:self action:@selector(goHelpVC) forControlEvents:(UIControlEventTouchUpInside)];
    [printbtn.titleLabel setFont:XFont(18)];
    [self.navigationView addSubview:printbtn];
    
    [printbtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navigationView.right).offset(-15);
        make.top.equalTo(self.navigationView.top).offset(StatusBar_H);
        make.bottom.equalTo(self.navigationView.bottom).offset(0);
    }];
    
}

//跳转打印参数设置页面
- (void)goPrintSettingView{
    BluetoothSettingViewController *vc = [[BluetoothSettingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//跳转蓝牙帮助页面
- (void)goHelpVC{
    BluetoothHelpViewController *vc = [[BluetoothHelpViewController alloc]init];
    vc.navTitle = @"帮助";
    vc.htmlName = @"Bluetooth";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)searchBluetooth{
    LCWeakSelf(self)
    [self.searchBtn setImage:[UIImage imageNamed:@"dyj_ic_sousuosb01"] forState:(UIControlStateNormal)];
    [self.searchBtn setTitleColor:toPCcolor(@"#999999") forState:(UIControlStateNormal)];
    [self.indicatorView startAnimating];
    [self.indicatorView1 startAnimating];
    [self.manage beginScanPerpheralSuccess:^(NSArray<CBPeripheral *> *peripherals, NSArray<NSNumber *> *rssis) {
        NSLog(@"%@",peripherals);
        weakself.dataSource = [NSMutableArray arrayWithArray:peripherals];
        [weakself.indicatorView1 stopAnimating];
        [weakself.indicatorView stopAnimating];
        [self.searchBtn setImage:[UIImage imageNamed:@"dyj_ic_sousuosb"] forState:(UIControlStateNormal)];
        [self.searchBtn setTitleColor:toPCcolor(@"#1c98f6") forState:(UIControlStateNormal)];
        [weakself.mainTableView reloadData];
        
        
        
        NSLog(@"------------蓝牙列表---------%@",weakself.dataSource);
    } failure:^(CBManagerState status) {
        
    }];
}

#pragma mark - TableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return IFAutoFitPx(88);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell){
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"UITableViewCell"];
    }
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    CBPeripheral *peripherral = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",peripherral.name];
    cell.textLabel.font = XFont(14);
    cell.imageView.image = [UIImage imageNamed:@"dyj_ic_lanya"];
    return cell;
}

//点击cell 是否连接蓝牙
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CBPeripheral *peripherral = [self.dataSource objectAtIndex:indexPath.row];
    NSString *bluetoothName = [NSString stringWithFormat:@"%@",peripherral.name];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"蓝牙配对请求" message:[NSString stringWithFormat:@"是否要与%@此打印机配对",bluetoothName] preferredStyle:UIAlertControllerStyleAlert];
    //取消
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    //配对
    [alertController addAction:[UIAlertAction actionWithTitle:@"配对" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        CBPeripheral *peripherral = [self.dataSource objectAtIndex:indexPath.row];
        [self.manage connectPeripheral:peripherral completion:^(CBPeripheral *perpheral, NSError *error) {
            if (!error){
                LCWeakSelf(self)
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[IFUtils share]showErrorInfo:@"连接成功"];
                    weakself.connectDevice.text = bluetoothName;
                    weakself.currentBluetooth = perpheral;
                    [weakself.mainTableView setTableHeaderView:weakself.headerView2];
                    [weakself.dataSource removeObjectAtIndex:indexPath.row];
                    [weakself.mainTableView reloadData];
                });
            }else{
                [[IFUtils share]showErrorInfo:error.domain];
            }
        }];
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 判断蓝牙是否打开
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStatePoweredOff:{
            [self.mainTableView setTableHeaderView:[[UIView alloc] init]];
            [self showAlertView];
            [self.dataSource removeAllObjects];
            [self.mainTableView reloadData];
        }
            break;
        case CBCentralManagerStatePoweredOn:
            [self searchBluetooth];
            break;
        case CBCentralManagerStateResetting:
            break;
        case CBCentralManagerStateUnauthorized:
            break;
        case CBCentralManagerStateUnknown:
            break;
        case CBCentralManagerStateUnsupported:
            [[IFUtils share]showErrorInfo:@"当前设备不支持蓝牙"];
            break;
        default:
            break;
    }
    
}

#pragma mark - 蓝牙未打开提示
- (void)showAlertView{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"蓝牙未开启" message:@"请先打开手机蓝牙功能，然后连接打印机" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSString * urlString = @"App-Prefs:root=WIFI";
        //跳转蓝牙设置
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[urlString stringByReplacingOccurrencesOfString:@"App-P" withString:@"p"]]];
        }
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 懒加载
- (UIView *)headerView1{
    if (!_headerView1){
        _headerView1 = [[UIView alloc]init];
        [_headerView1 setFrame:XFrame(0, 0, Screen_W, IFAutoFitPx(88))];
        [_headerView1 setBackgroundColor:toPCcolor(@"#f5f5f5")];
    }
    return _headerView1;
}

- (UIView *)headerView2{
    if (!_headerView2){
        _headerView2 = [[UIView alloc]init];
        [_headerView2 setFrame:XFrame(0, 0, Screen_W, IFAutoFitPx(274))];
        [_headerView2 setBackgroundColor:toPCcolor(@"#f5f5f5")];
    }
    return _headerView2;
}

- (UITableView *)mainTableView{
    if (!_mainTableView){
        _mainTableView = [[UITableView alloc]init];
        [_mainTableView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y-IFAutoFitPx(96))];
        [_mainTableView setBackgroundColor:toPCcolor(@"#f5f5f5")];
        [_mainTableView setTableFooterView:[[UIView alloc]init]];
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
@end
