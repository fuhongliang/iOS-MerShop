//
//  AccountSecurityViewController.m
//  MerShop
//
//  Created by mac on 2019/3/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AccountSecurityViewController.h"
#import "ShopSetTableViewCell1.h"
#import "ShopSetTableViewCell3.h"
#import "ChangePasswordViewController.h"

@interface AccountSecurityViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableview;
@end

@implementation AccountSecurityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"账户安全"];
    [self setUI];
    
}

- (void)setUI{
    _tableview = [[UITableView alloc]init];
    [_tableview setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [_tableview setBackgroundColor:toPCcolor(@"#f5f5f5")];
    _tableview.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==2){
        ShopSetTableViewCell1 *cell = (ShopSetTableViewCell1 *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ShopSetTableViewCell1"];
        if (!cell){
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShopSetTableViewCell1" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.Title.text = @"修改密码";
        cell.SubTitle.text = @"";
        cell.Title.textColor = BlackColor;
        cell.SubTitle.textColor = GrayColor;
        return cell;
    }else{
        ShopSetTableViewCell3 *cell = (ShopSetTableViewCell3 *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ShopSetTableViewCell3"];
        if (!cell){
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShopSetTableViewCell3" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        if (indexPath.row == 0){
            cell.Title.text = @"绑定手机";
            cell.SubTitle.text = @"188****1234";
        }else{
            cell.Title.text = @"登录账号";
            cell.SubTitle.text = @"Sofia****8686";
        }
        cell.Title.textColor = BlackColor;
        cell.SubTitle.textColor = GrayColor;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 2){
        ChangePasswordViewController *VC = [[ChangePasswordViewController alloc]init];
        [self.navigationController pushViewController:VC animated:NO];
    }
}

@end
