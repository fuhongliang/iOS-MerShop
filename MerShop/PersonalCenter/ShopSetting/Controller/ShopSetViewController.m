//
//  ShopSetViewController.m
//  MerShop
//
//  Created by mac on 2019/3/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ShopSetViewController.h"
#import "ShopSetTableViewCell1.h"
#import "ShopSetTableViewCell2.h"
#import "ShopSetTableViewCell3.h"
#import "ShopSetTableViewCell4.h"
#import "BusinessStatusViewController.h"
#import "RestaurantNoticeViewController.h"

@interface ShopSetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableview;
@end

@implementation ShopSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"门店设置"];
    [self.view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [self.navigationController.navigationBar setHidden:YES];
    [self setUI];
}

- (void)setUI{
    _tableview = [[UITableView alloc]init];
    [_tableview setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-Tabbar_H-ViewStart_Y)];
    [_tableview setDelegate:self];
    [_tableview setDataSource:self];
    [_tableview setBackgroundColor:toPCcolor(@"#f5f5f5")];
    _tableview.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){
        return 2;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0){
        return IFAutoFitPx(40);
    }
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0){
        UIView *view = [[UIView alloc]init];
        [view setFrame:XFrame(0, 0, Screen_W, IFAutoFitPx(40))];
        [view setBackgroundColor:toPCcolor(@"#f5f5f5")];
        return view;
    }
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0){
        if (indexPath.row ==1){
            return 85;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0){
            return 55;
        }
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        if (indexPath.row ==0){
            ShopSetTableViewCell1 *cell = (ShopSetTableViewCell1 *)[tableView dequeueReusableCellWithIdentifier:@"ShopSetTableViewCell1"];
            if (!cell){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShopSetTableViewCell1" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell.Title.text = @"营业状态";
            cell.SubTitle.text = @"待开始营业";
            return cell;
        }else{
            ShopSetTableViewCell4 *cell = (ShopSetTableViewCell4 *)[tableView dequeueReusableCellWithIdentifier:@"ShopSetTableViewCell4"];
            if (!cell){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShopSetTableViewCell4" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell.Title.text = @"餐厅公告";
            cell.SubTitle.text = @"您还没发布餐厅公告";
            return cell;
        }
    }
    if (indexPath.row == 0){
        ShopSetTableViewCell2 *cell = (ShopSetTableViewCell2 *)[tableView dequeueReusableCellWithIdentifier:@"ShopSetTableViewCell2"];
        if (!cell){
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShopSetTableViewCell2" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.ShopHeadIcon.image = [UIImage imageNamed:@"logo"];
        cell.Title.text = @"店铺头像";
        return cell;
    }else if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row ==4){
        ShopSetTableViewCell1 *cell = (ShopSetTableViewCell1 *)[tableView dequeueReusableCellWithIdentifier:@"ShopSetTableViewCell1"];
        if (!cell){
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShopSetTableViewCell1" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        if (indexPath.row == 1){
            cell.SubTitle.text = @"1888888888";
            cell.Title.text = @"餐厅电话";
            return cell;
        }else if (indexPath.row == 4){
            cell.SubTitle.text = @"";
            cell.Title.text = @"营业资质";
            return cell;
        }else{
            cell.SubTitle.text = @"09:00～22:00";
            cell.Title.text = @"营业时间";
            return cell;
        }
        
    }else{
        ShopSetTableViewCell3 *cell = (ShopSetTableViewCell3 *)[tableView dequeueReusableCellWithIdentifier:@"ShopSetTableViewCell3"];
        if (!cell){
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShopSetTableViewCell3" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.SubTitle.text = @"广州市天河区天上人间";
        cell.Title.text = @"餐厅地址";
        return cell;
        
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        if (indexPath.row == 0){
            BusinessStatusViewController *VC = [[BusinessStatusViewController alloc]init];
            [self.navigationController pushViewController:VC animated:NO];
        }else{
            RestaurantNoticeViewController *VC = [[RestaurantNoticeViewController alloc]init];
            [self.navigationController pushViewController:VC animated:NO];
        }
    }
}


@end
