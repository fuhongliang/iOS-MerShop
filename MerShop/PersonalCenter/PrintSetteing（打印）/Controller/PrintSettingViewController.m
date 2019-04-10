//
//  PrintSettingViewController.m
//  MerShop
//
//  Created by mac on 2019/4/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "PrintSettingViewController.h"
#import "PrintSettringHeaderView.h"
#import "JWBluetoothManage.h"
#import "ZJTopImageBottomTitleButton.h"
#import "UIView+JHDrawCategory.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface PrintSettingViewController ()<UITableViewDelegate,UITableViewDataSource,CBCentralManagerDelegate>
@property (nonatomic ,strong)PrintSettringHeaderView *headerView;
@property (nonatomic ,strong)UITableView *mainTableView;
@property (nonatomic ,strong)JWBluetoothManage *manage;
@property (nonatomic ,strong)ZJTopImageBottomTitleButton *searchBtn;
@property (nonatomic ,strong)CBCentralManager *bluetoothManager;
@property (nonatomic ,strong)NSMutableArray *dataSource;
@end

@implementation PrintSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"添加打印机"];
    [self.view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    _bluetoothManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    self.manage = [JWBluetoothManage sharedInstance];

    [self setUI];
    [self printLab];
}

- (void)setUI{
    [self.view addSubview:self.mainTableView];
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PrintSettringHeaderView" owner:self options:nil];
    _headerView = [nib objectAtIndex:0];
    [_headerView setFrame:XFrame(0, 0, Screen_W, 253)];
    self.mainTableView.tableHeaderView = _headerView;
    
    UIView *bottomView = [[UIView alloc]init];
    [bottomView setBackgroundColor:[UIColor whiteColor]];
    [bottomView setFrame:XFrame(0, CGRectGetMaxY(_mainTableView.frame), Screen_W, IFAutoFitPx(96))];
    [self.view addSubview:bottomView];
    
    UIView *line = [[UIView alloc]init];
    [line drawDottedLine];
    [bottomView addSubview:line];
    
    _searchBtn = [[ZJTopImageBottomTitleButton alloc]init];
    [_searchBtn setFrame:XFrame(0, IFAutoFitPx(1), Screen_W, IFAutoFitPx(95))];
    [_searchBtn setImage:[UIImage imageNamed:@"dyj_ic_sousuosb"] forState:(UIControlStateNormal)];
    [_searchBtn setTitle:@"搜索设备" forState:(UIControlStateNormal)];
    [_searchBtn setTitleColor:IFThemeBlueColor forState:(UIControlStateNormal)];
    [_searchBtn.titleLabel setFont:XFont(11)];
    [_searchBtn addTarget:self action:@selector(searchBluetooth) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:_searchBtn];
}

- (void)printLab{
    UIButton *printbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [printbtn setFrame:XFrame(Screen_W-IFAutoFitPx(148)-IFAutoFitPx(30), StatusBar_H+IFAutoFitPx(15), IFAutoFitPx(148), Navagtion_H-IFAutoFitPx(30))];
    [printbtn setTitle:@"打印" forState:(UIControlStateNormal)];
    [printbtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [printbtn setBackgroundColor:IFThemeBlueColor];
    [printbtn addTarget:self action:@selector(print) forControlEvents:(UIControlEventTouchUpInside)];
    XViewLayerCB(printbtn, 1, 1, [UIColor whiteColor]);
    [self.navigationView addSubview:printbtn];
    
}

- (void)print{
    if (_manage.stage != JWScanStageCharacteristics) {
        [ProgressShow alertView:self.view Message:@"打印机正在准备中..." cb:nil];
        return;
    }
    JWPrinter *printer = [[JWPrinter alloc] init];
    NSString *str1 = @"=============银智付=============";
    [printer appendText:str1 alignment:HLTextAlignmentCenter];
    [printer appendTitle:@"商户名称：" value:@"樱花休闲娱乐会所"];
    [printer appendTitle:@"商户编号：" value:@"09891331"];
    [printer appendTitle:@"订单编号：" value:@"MS1234567890"];
    [printer appendTitle:@"交易类型：" value:@"微信支付"];
    [printer appendTitle:@"交易时间：" value:@"2019-03-14"];
    [printer appendTitle:@"金   额：" value:@"300元"];
    [printer appendTitle:@"服务技师：" value:@"小红"];
    [printer appendFooter:@"欢迎再次光临!"];
    [printer appendNewLine];
    NSData *mainData = [printer getFinalData];
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            NSLog(@"打印成功");
        }else{
            NSLog(@"写入错误---:%@",error);
        }
    }];

}

- (void)searchBluetooth{
    __weak typeof(self)weakself = self;
    [self.manage beginScanPerpheralSuccess:^(NSArray<CBPeripheral *> *peripherals, NSArray<NSNumber *> *rssis) {
        NSLog(@"%@",peripherals);
        weakself.dataSource = [NSMutableArray arrayWithArray:peripherals];
        [weakself.mainTableView reloadData];
        
        NSLog(@"------------蓝牙列表---------%@",weakself.dataSource);
    } failure:^(CBManagerState status) {
        
    }];
}

#pragma mark - TableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell){
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"UITableViewCell"];
    }
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    CBPeripheral *peripherral = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",peripherral.name];
    cell.imageView.image = [UIImage imageNamed:@"dyj_ic_lanya"];
    return cell;
}

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
                [[IFUtils share]showErrorInfo:@"连接成功"];
                self.headerView.title.text = bluetoothName;
                self.headerView.subTitle.text = @"已连接";
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
            [ProgressShow alertView:self.view Message:@"蓝牙暂未开启" cb:nil];
            _headerView.stateImage.image = [UIImage imageNamed:@"dyj_ic_wkq"];
            _headerView.title.text = @"蓝牙功能暂未开启";
            _headerView.subTitle.text = @"请先打开手机蓝牙功能,然后连接打印机";
            [self.dataSource removeAllObjects];
            [self.mainTableView reloadData];
        }
            break;
        case CBCentralManagerStatePoweredOn:
            _headerView.stateImage.image = [UIImage imageNamed:@"dyj_ic_ykq"];
            _headerView.title.text = @"正在搜索打印机...";
            _headerView.subTitle.text = @"搜索到的打印机会显示在下方";
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

#pragma mark - 懒加载
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
