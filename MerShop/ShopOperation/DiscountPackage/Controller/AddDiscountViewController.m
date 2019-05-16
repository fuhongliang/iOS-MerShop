//
//  AddDiscountViewController.m
//  MerShop
//
//  Created by mac on 2019/4/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AddDiscountViewController.h"
#import "AddActivityGoodsViewController.h"
#import "DiscountPackageGoodsCell.h"
#import "PackageView.h"
#import "FooterView.h"

@interface AddDiscountViewController ()<UITableViewDelegate,UITableViewDataSource,FooterViewDelegate,DiscountPackageGoodsCellDelegate,UITextFieldDelegate>
@property (nonatomic ,strong)UITableView *mainTableView;
@property (nonatomic ,strong)PackageView *headView;
@property (nonatomic ,strong)FooterView *footerView;
@property (nonatomic ,strong)NSMutableArray *dataArr;

//开关状态，打开为1，关闭为0
@property (nonatomic ,assign)NSInteger stateNumber;
//添加活动的总优惠价格
@property (nonatomic ,assign)NSInteger discountPrice;
@end

@implementation AddDiscountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"添加活动"];
    [self.view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    self.stateNumber = 1;
    [self setUI];
    [self reloadListData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.discountPrice = 0;
    self.dataArr = [[IFUserDefaults objectForKey:@"GoodsArray"] mutableCopy];
    for (NSDictionary *dict in self.dataArr){
        NSInteger p = [dict[@"xianshi_price"] integerValue];
        self.discountPrice = self.discountPrice+p;
    }
    _footerView.discountAllPrice.text = [NSString stringWithFormat:@"¥%ld",(long)self.discountPrice];
    [self.mainTableView reloadData];
}

- (void)reloadListData{
    NSString *lid = [NSString stringWithFormat:@"%ld",self.taocan_Id];
    if (self.activityInfo != nil){
        NSDictionary *dict = @{@"bundling_id":lid,
                               @"store_id":StoreIdString
                               };
        [Http_url POST:@"bundling_info" dict:dict showHUD:NO WithSuccessBlock:^(id data) {
            NSLog(@"%@",data);
            NSArray *arr = data[@"data"][@"goods_list"];
            if (kISNullArray(arr)){
                
            }else{
                self.dataArr = [arr mutableCopy];
            }
            self.headView.activityName.text = data[@"data"][@"bl_name"];
            self.footerView.discountAllPrice.text = [NSString stringWithFormat:@"¥ %@",data[@"data"][@"bl_price"]];
            if ([data[@"data"][@"bl_state"] integerValue] == 0){
                self.stateNumber = 0;
                [self.footerView.stateSwitch setOn:NO];
            }else{
                self.stateNumber = 1;
                [self.footerView.stateSwitch setOn:YES];
            }
            for (NSInteger i = 0;i<self.dataArr.count;i++){
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:self.dataArr[i]];
                NSArray *arr = [dict allKeys];
                //判断整个数组中是否有为空的值，然后存在UserDefaults
                for (NSString *key in arr){
                    if ([[dict objectForKey:key] isKindOfClass:[NSNull class]]){
                        [dict setObject:@"" forKey:key];
                    }
                }
                [dict setObject:dict[@"goods_price"] forKey:@"xianshi_price"];
                [dict setObject:dict[@"goods_origin_price"] forKey:@"goods_price"];
                [dict setObject:dict[@"img_name"] forKey:@"img_path"];
                [self.dataArr removeObjectAtIndex:i];
                [self.dataArr insertObject:dict atIndex:i];
            }
            [IFUserDefaults setObject:self.dataArr forKey:@"GoodsArray"];
            [self.mainTableView reloadData];
         
         } WithFailBlock:^(id data) {
             
         }];

    }
}


- (void)setUI{
    [self.view addSubview:self.mainTableView];
    
    _headView = [[[NSBundle mainBundle]loadNibNamed:@"PackageView" owner:self options:nil] objectAtIndex:0];
    [_headView setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [_headView setFrame:XFrame(0, 0, Screen_W, 103)];
    _headView.activityName.delegate = self;
    [self.mainTableView setTableHeaderView:_headView];
    
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
    
    _footerView = [[[NSBundle mainBundle]loadNibNamed:@"FooterView" owner:self options:nil] objectAtIndex:0];
    [_footerView setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [_footerView setFrame:XFrame(0, 0, Screen_W, 310)];
    _footerView.delegate = self;
    _footerView.discountAllPrice.text = @"";
    [self.mainTableView setTableFooterView:_footerView];
    
}

#pragma mark - TextView Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.headView.activityName){
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.headView.activityName.text.length >= 20) {
            self.headView.activityName.text = [textField.text substringToIndex:20];
            return NO;
        }
    }
    return YES;
}

#pragma mark - footerview代理方法
/**
 点击添加按钮，跳转添加活动商品
 */
- (void)addActivityGoods{
    AddActivityGoodsViewController *vc = [[AddActivityGoodsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
/**
 提交添加的优惠套餐活动
 */
- (void)submit{
    if (self.headView.activityName.text.length == 0){
        [[IFUtils share]showErrorInfo:@"请填写活动名称"];
        return;
    }
    if (self.dataArr.count == 0){
        [[IFUtils share]showErrorInfo:@"请添加活动商品"];
        return;
    }
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    NSInteger allPrice = 0;
    for (NSDictionary *dict in self.dataArr){
        //优惠套餐的总价格
        NSInteger p = [dict[@"xianshi_price"] integerValue];
        allPrice = allPrice + p;
        //商品数组
        NSInteger gid = [dict[@"goods_id"] integerValue];
        NSString *discountPrice = dict[@"xianshi_price"];
        NSDictionary *dict = @{@"goods_id":@(gid),
                               @"goods_price":discountPrice
                               };
        [arr addObject:dict];
    }
    NSDictionary *dict;
    if(self.activityInfo != nil){//判断是否是从点击管理按钮进来
        dict = @{@"bundling_id":[NSString stringWithFormat:@"%ld",(long)self.taocan_Id],
                 @"store_id":StoreIdString,
                 @"bundling_name":_headView.activityName.text,
                 @"discount_price":[NSString stringWithFormat:@"%ld",(long)allPrice],
                 @"goods_list":arr,
                 @"bl_state":@(self.stateNumber)
                 };
    }else{
        dict = @{@"store_id":StoreIdString,
                 @"bundling_name":_headView.activityName.text,
                 @"discount_price":[NSString stringWithFormat:@"%ld",(long)allPrice],
                 @"goods_list":arr,
                 @"bl_state":@(self.stateNumber)
                 };
    }
    [Http_url POST:@"bundling_edit" dict:dict showHUD:NO WithSuccessBlock:^(id data) {
        if ([[data objectForKey:@"code"] integerValue] == 200){
            [IFUserDefaults removeObjectForKey:@"GoodsArray"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } WithFailBlock:^(id data) {
        NSLog(@"%@",data);
    }];
}
- (void)open:(id)data{
    self.stateNumber = [data integerValue];
}
/**
 导航返回按钮，返回时删除保存的商品数据
 */
- (void)popViewController{
    [IFUserDefaults removeObjectForKey:@"GoodsArray"];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - DiscountPackageGoodsCellDelegate
/**
 删除所添加的活动商品,数据源更改
 */
- (void)deleteGoods:(id)data{
    DiscountPackageGoodsCell *cell = (DiscountPackageGoodsCell *)data;
    [self.dataArr removeObjectAtIndex:cell.tag];
    [IFUserDefaults setObject:self.dataArr forKey:@"GoodsArray"];
    self.discountPrice = 0;
    for (NSDictionary *dict in self.dataArr){
        NSInteger p = [dict[@"xianshi_price"] integerValue];
        self.discountPrice = self.discountPrice+p;
    }
    _footerView.discountAllPrice.text = [NSString stringWithFormat:@"¥%ld",(long)self.discountPrice];
    [self.mainTableView reloadData];
}
#pragma mark - tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscountPackageGoodsCell *cell = (DiscountPackageGoodsCell *)[tableView dequeueReusableCellWithIdentifier:@"DiscountPackageGoodsCell"];
    if (!cell){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DiscountPackageGoodsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.delegate = self;
    cell.tag = indexPath.row;
    [cell setDataWithDict:self.dataArr[indexPath.row]];
    return cell;
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
