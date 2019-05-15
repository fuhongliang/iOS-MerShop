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
#import "ShopSetTableViewCell5.h"
#import "BusinessStatusViewController.h"
#import "RestaurantNoticeViewController.h"
#import "PhoneNumberSettingViewController.h"
#import "BusinessLicenseViewController.h"
#import "UIImageView+WebCache.h"


@interface ShopSetViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate>
@property (nonatomic ,strong)UITableView *tableview;
@property (nonatomic ,strong)UIPickerView *pickerView1;
@property (nonatomic ,strong)UIPickerView *pickerView2;
@property (nonatomic ,strong)UIView *pickerBgView;
@property (nonatomic ,strong)UIView *BackgroundView;
@property (nonatomic ,copy)NSArray *arr1;
@property (nonatomic ,copy)NSArray *arr2;
@property (nonatomic ,copy)NSString *startTime_h;
@property (nonatomic ,copy)NSString *startTime_m;
@property (nonatomic ,copy)NSString *endTime_h;
@property (nonatomic ,copy)NSString *endTime_m;
@property (nonatomic ,copy)NSString *startTime;
@property (nonatomic ,copy)NSString *endTime;

@end

@implementation ShopSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"门店设置"];
    _arr1 = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",];
    _arr2 = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59"];
    [self.view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [self.navigationController.navigationBar setHidden:YES];
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableview reloadData];
}

- (void)setUI{
    _tableview = [[UITableView alloc]init];
    [_tableview setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-Tabbar_H-ViewStart_Y)];
    [_tableview setDelegate:self];
    [_tableview setDataSource:self];
    [_tableview setBackgroundColor:toPCcolor(@"#f5f5f5")];
    _tableview.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableview];
    
    _BackgroundView = [[UIView alloc]init];
    [_BackgroundView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [_BackgroundView setBackgroundColor:BlackColor];
    [_BackgroundView setAlpha:0.6];
    [_BackgroundView setHidden:YES];
    [self.view addSubview:_BackgroundView];
    
    _pickerBgView = [[UIView alloc]initWithFrame:XFrame(0, Screen_H-IFAutoFitPx(564), Screen_W, IFAutoFitPx(564))];
    [_pickerBgView setBackgroundColor:[UIColor whiteColor]];
    [_pickerBgView setHidden:YES];
    [self.view addSubview:_pickerBgView];
    
    UIButton *cancel = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [cancel setFrame:XFrame(IFAutoFitPx(40), IFAutoFitPx(20), IFAutoFitPx(90), IFAutoFitPx(50))];
    [cancel setTitle:@"取消" forState:(UIControlStateNormal)];
    [cancel.titleLabel setFont:XFont(17)];
    [cancel setTitleColor:toPCcolor(@"#666666") forState:(UIControlStateNormal)];
    [cancel addTarget:self action:@selector(cancel) forControlEvents:(UIControlEventTouchUpInside)];
    [_pickerBgView addSubview:cancel];
    
    UIButton *ensure = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ensure setFrame:XFrame(Screen_W-IFAutoFitPx(130), IFAutoFitPx(20), IFAutoFitPx(90), IFAutoFitPx(50))];
    [ensure setTitle:@"确定" forState:(UIControlStateNormal)];
    [ensure.titleLabel setFont:XFont(17)];
    [ensure setTitleColor:IFThemeBlueColor forState:(UIControlStateNormal)];
    [ensure addTarget:self action:@selector(ensureTime) forControlEvents:(UIControlEventTouchUpInside)];
    [_pickerBgView addSubview:ensure];
    
    UIView *line = [[UIView alloc]initWithFrame:XFrame(0, IFAutoFitPx(89), Screen_W, IFAutoFitPx(1))];
    [line setBackgroundColor:LineColor];
    [_pickerBgView addSubview:line];
    
    UILabel *startTimeLab = [[UILabel alloc]init];
    [startTimeLab setFrame:XFrame(0, IFAutoFitPx(110), Screen_W/2, IFAutoFitPx(40))];
    [startTimeLab setText:@"开始时间"];
    [startTimeLab setTextColor:toPCcolor(@"#666666")];
    [startTimeLab setTextAlignment:(NSTextAlignmentCenter)];
    [_pickerBgView addSubview:startTimeLab];
    
    UILabel *endTimeLab = [[UILabel alloc]init];
    [endTimeLab setFrame:XFrame(Screen_W/2, IFAutoFitPx(110), Screen_W/2, IFAutoFitPx(40))];
    [endTimeLab setText:@"结束时间"];
    [endTimeLab setTextColor:toPCcolor(@"#666666")];
    [endTimeLab setTextAlignment:(NSTextAlignmentCenter)];
    [_pickerBgView addSubview:endTimeLab];
    
    _pickerView1 = [[UIPickerView alloc]init];
    [_pickerView1 setFrame:XFrame(0, IFAutoFitPx(170), Screen_W/2, IFAutoFitPx(394))];
    [_pickerView1 setDelegate:self];
    [_pickerView1 setDataSource:self];
    [_pickerView1 setShowsSelectionIndicator:YES];
    [_pickerBgView addSubview:_pickerView1];
    
    _pickerView2 = [[UIPickerView alloc]init];
    [_pickerView2 setFrame:XFrame(Screen_W/2, IFAutoFitPx(170), Screen_W/2, IFAutoFitPx(394))];
    [_pickerView2 setDelegate:self];
    [_pickerView2 setDataSource:self];
    [_pickerView2 setShowsSelectionIndicator:YES];
    [_pickerBgView addSubview:_pickerView2];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0){
        return _arr1.count;
    }
    return _arr2.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 40;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == _pickerView1){
        if (component == 0){
            _startTime_h = [_arr1 objectAtIndex:row];
        }else{
            _startTime_m = [_arr2 objectAtIndex:row];
        }
    }else{
        if (component == 0){
            _endTime_h = [_arr1 objectAtIndex:row];
        }else{
            _endTime_m = [_arr2 objectAtIndex:row];
        }
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == _pickerView1){
        if (component == 0){
            _startTime_h = [_arr1 objectAtIndex:row];
            return [_arr1 objectAtIndex:row];
            
        }else{
            _startTime_m = [_arr2 objectAtIndex:row];
            return [_arr2 objectAtIndex:row];
        }
    }else{
        if (component == 0){
            _endTime_h = [_arr1 objectAtIndex:row];
            return [_arr1 objectAtIndex:row];
        }else{
            _endTime_m = [_arr2 objectAtIndex:row];
            return [_arr2 objectAtIndex:row];
        }
    }

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1){
        return 5;
    }else{
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0){
        return IFAutoFitPx(40);
    }
//    else if (section == 1){
//        return IFAutoFitPx(40);
//    }
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
            
            NSDictionary *dict = [self getUserInfo];
            NSInteger store_state = [[dict objectForKey:@"store_state"] integerValue];
            if (store_state == 1){
                cell.SubTitle.text = @"正在营业";
            }else{
                cell.SubTitle.text = @"已停止营业";
            }
            return cell;
        }else{
            ShopSetTableViewCell4 *cell = (ShopSetTableViewCell4 *)[tableView dequeueReusableCellWithIdentifier:@"ShopSetTableViewCell4"];
            if (!cell){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShopSetTableViewCell4" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            NSDictionary *user = [self getUserInfo];
            cell.Title.text = @"餐厅公告";
            NSString *str = user[@"store_description"];
            if ([str isKindOfClass:[NSNull class]] || str.length == 0){
                cell.SubTitle.text = @"您还未设置任何公告";
            }else{
                cell.SubTitle.text = user[@"store_description"];
            }
            return cell;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0){
            ShopSetTableViewCell2 *cell = (ShopSetTableViewCell2 *)[tableView dequeueReusableCellWithIdentifier:@"ShopSetTableViewCell2"];
            if (!cell){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShopSetTableViewCell2" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            NSString *imageStr = [NSString stringWithFormat:@"%@%@",img_path,[[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"] objectForKey:@"store_avatar"]];
            [cell.ShopHeadIcon sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"moren_dianpu"]];
            cell.Title.text = @"店铺头像";
            return cell;
        }else if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row ==4){
            ShopSetTableViewCell1 *cell = (ShopSetTableViewCell1 *)[tableView dequeueReusableCellWithIdentifier:@"ShopSetTableViewCell1"];
            if (!cell){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShopSetTableViewCell1" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            if (indexPath.row == 1){
                cell.Title.text = @"餐厅电话";
                NSDictionary *userDict = [self getUserInfo];
                cell.SubTitle.text = [NSString stringWithFormat:@"%@",userDict[@"store_phone"]];
                return cell;
            }else if (indexPath.row == 4){
                cell.SubTitle.text = @"";
                cell.Title.text = @"营业资质";
                return cell;
            }else{
                NSDictionary *user = [self getUserInfo];
                cell.SubTitle.text = [NSString stringWithFormat:@"%@~%@",user[@"work_start_time"],user[@"work_end_time"]];
                cell.Title.text = @"营业时间";
                return cell;
            }
            
        }else{
            ShopSetTableViewCell3 *cell = (ShopSetTableViewCell3 *)[tableView dequeueReusableCellWithIdentifier:@"ShopSetTableViewCell3"];
            if (!cell){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShopSetTableViewCell3" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
            cell.SubTitle.text = dict[@"area_info"];
            cell.Title.text = @"餐厅地址";
            return cell;
            
        }
    }else{
        NSArray *a = @[@"自动接单",@"自动打印"];
        ShopSetTableViewCell5 *cell = (ShopSetTableViewCell5 *)[tableView dequeueReusableCellWithIdentifier:@"ShopSetTableViewCell5"];
        if (!cell){
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShopSetTableViewCell5" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.title.text = a[indexPath.row];
        return cell;
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        if (indexPath.row == 0){
            BusinessStatusViewController *VC = [[BusinessStatusViewController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }else{
            RestaurantNoticeViewController *VC = [[RestaurantNoticeViewController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 3){
            [self.BackgroundView setHidden:NO];
            [self.pickerBgView setHidden:NO];
        }else if (indexPath.row == 1){
            PhoneNumberSettingViewController *vc = [[PhoneNumberSettingViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 4){
            BusinessLicenseViewController *vc = [[BusinessLicenseViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 0){
            [self changeStoreImg];
        }
    }
}

/**
    调用相册、相机,上传店铺头像
 */
- (void)changeStoreImg{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择头像来源" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cameral = [UIAlertAction actionWithTitle:@"直接拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self openCameral];
    }];
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"图片库" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotoLibrary];
    }];
    [alert addAction:cameral];
    [alert addAction:album];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

//打开相机
- (void)openCameral{
    if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]){
        //摄像头
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.allowsEditing = YES;
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else{
        NSLog(@"无摄像头");
    }
}

//打开相册
- (void)openPhotoLibrary{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:^{
        NSLog(@"打开相册");
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"取消");
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        //图片存入相册
        UIImageWriteToSavedPhotosAlbum(info[UIImagePickerControllerEditedImage], nil, nil, nil);
    }
    LCWeakSelf(self)
    UIImage *uploadImg = info[UIImagePickerControllerEditedImage];
    [Http_url POST:@"image_upload" image: uploadImg showHUD:NO WithSuccessBlock:^(id data) {
        if ([[data objectForKey:@"code"] integerValue] == 200){
            NSString *imagePath = [NSString stringWithFormat:@"%@",[data objectForKey:@"data"]];
            NSDictionary *uploadImgDict = @{@"store_id":@(StoreId),
                                            @"avator":imagePath
                                            };
            [Http_url POST:@"change_avator" dict:uploadImgDict showHUD:NO WithSuccessBlock:^(id data) {
                NSLog(@"%@",data);
                NSMutableDictionary *userInfoDict = [[NSMutableDictionary alloc]initWithDictionary:[data objectForKey:@"data"]];
                NSArray *arr = [userInfoDict allKeys];
                for (NSString *key in arr){
                    if ([[userInfoDict objectForKey:key] isKindOfClass:[NSNull class]]){
                        [userInfoDict setObject:@"" forKey:key];
                    }
                }
                if (userInfoDict){
                    [IFUserDefaults setObject:userInfoDict forKey:@"userInfo"];
                    [IFUserDefaults synchronize];
                    [weakself.tableview reloadData];
                }
                
            } WithFailBlock:^(id data) {
                
            }];
        }
        
    } WithFailBlock:^(id data) {
        
    }];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)cancel{
    [self.BackgroundView setHidden:YES];
    [self.pickerBgView setHidden:YES];
}

- (void)ensureTime{
    [self.BackgroundView setHidden:YES];
    [self.pickerBgView setHidden:YES];
    _startTime = [NSString stringWithFormat:@"%@:%@",_startTime_h,_startTime_m];
    _endTime = [NSString stringWithFormat:@"%@:%@",_endTime_h,_endTime_m];
    NSLog(@"开始时间=====%@结束时间=====%@",_startTime,_endTime);
    NSDictionary *user = [self getUserInfo];
    NSInteger storeId = [[user objectForKey:@"store_id"] integerValue];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:user];
    [dict setValue:_startTime forKey:@"work_start_time"];
    [dict setValue:_endTime forKey:@"work_end_time"];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setObject:dict forKey:@"userInfo"];
    [Http_url POST:@"store_set_worktime" dict:@{@"store_id":@(storeId),@"work_start_time":_startTime,@"work_end_time":_endTime} showHUD:YES WithSuccessBlock:^(id data) {
        
    } WithFailBlock:^(id data) {
        
    }];
    [self.tableview reloadData];
}

- (id)getUserInfo{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userInfo objectForKey:@"userInfo"];
    return dict;
}

@end
