//
//  CreateNewGoodsViewController.m
//  MerShop
//
//  Created by mac on 2019/3/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CreateNewGoodsViewController.h"
#import "NewGoodsTableViewCell1.h"
#import "NewGoodsTableViewCell2.h"
#import "NewGoodsTableViewCell3.h"
#import "NewGoodsTableViewCell4.h"


@interface CreateNewGoodsViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,NewGoodsTableViewCell3Delegate>
@property (nonatomic ,strong)UITableView *mainTableview;
@property (nonatomic ,strong)UIPickerView *pickerView;
@property (nonatomic ,strong)UIView *BackgroundView;
@property (nonatomic ,strong)UIView *pickerBgView;
@property (nonatomic ,copy)NSArray *dataArr;
@property (nonatomic ,strong)UITextView *textview;
@property (nonatomic ,strong)UILabel *placeHolder;
@property (nonatomic ,strong)NSMutableArray *pickerDatasource;

@property (nonatomic ,copy)NSString *chooseClassName;
@property (nonatomic ,assign)NSInteger catergoryId;
@property (nonatomic ,copy)NSString *goodsName;
@property (nonatomic ,copy)NSString *currentPrice;
@property (nonatomic ,copy)NSString *oldPrice;

@end

@implementation CreateNewGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.switchStatus = 99999999;
    [self setNaviTitle:@"新建商品"];
    self.dataArr = @[@[@"商品名称*",@"商品分类*"],@[@"价格*",@"原价*",@"库存无限",
//                                            ,@"可售时间"
//                                            ,@"商品单位"
                                            ]];
    [self.view setBackgroundColor:LineColor];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [self.pickerDatasource addObjectsFromArray:[user objectForKey:@"classArray"]];
    _chooseClassName = [[self.pickerDatasource objectAtIndex:0] objectForKey:@"stc_name"];
    _catergoryId = [[[self.pickerDatasource objectAtIndex:0] objectForKey:@"stc_id"] integerValue];
    [self setUI];
}

- (void)setUI{
    _mainTableview = [[UITableView alloc]init];
    [_mainTableview setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [_mainTableview setBackgroundColor:LineColor];
    _mainTableview.delegate = self;
    _mainTableview.dataSource = self;
    
    UIView *view = [[UIView alloc]init];//footer灰色背景
    [view setFrame:XFrame(0, 0, Screen_W, IFAutoFitPx(410))];
    [view setBackgroundColor:LineColor];
    
    UIView *view1 = [[UIView alloc]init];//footer上textview的白色背景
    [view1 setFrame:XFrame(0, 0, Screen_W, IFAutoFitPx(234))];
    [view1 setBackgroundColor:[UIColor whiteColor]];
    [view addSubview:view1];
    
    UIView *line = [[UIView alloc]init];
    [line setFrame:XFrame(IFAutoFitPx(30), 0, Screen_W-IFAutoFitPx(30), IFAutoFitPx(2))];
    [line setBackgroundColor:LineColor];
    [view1 addSubview:line];
    
    UILabel *des = [[UILabel alloc]init];
    [des setText:@"商品描述"];
    [des setFrame:XFrame(IFAutoFitPx(30), IFAutoFitPx(22), Screen_W, IFAutoFitPx(32))];
    [des setTextColor:[UIColor blackColor]];
    [view1 addSubview:des];
    
    _textview = [[UITextView alloc]init];
    [_textview setFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(des.frame)+IFAutoFitPx(20), Screen_W-IFAutoFitPx(60), IFAutoFitPx(160))];
    _textview.delegate = self;
    _textview.font = XFont(15);
    [view1 addSubview:_textview];
    
    UILabel *placeHolder1 = [[UILabel alloc] initWithFrame:XFrame(0, IFAutoFitPx(10), Screen_W-IFAutoFitPx(60), IFAutoFitPx(44))];
    placeHolder1.text = @"介绍一下您的产品吧，200字以内就可以哦";
    placeHolder1.textColor = toPCcolor(@"#999999");
    self.placeHolder = placeHolder1;
    placeHolder1.font = XFont(15);
    placeHolder1.numberOfLines = 0;
    placeHolder1.contentMode = UIViewContentModeTop;
    [self.textview addSubview:placeHolder1];
    
    
    UIButton *saveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [saveBtn setFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(view1.frame)+IFAutoFitPx(61), Screen_W-IFAutoFitPx(60), IFAutoFitPx(88))];
    [saveBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    [saveBtn setBackgroundColor:IFThemeBlueColor];
    saveBtn.layer.cornerRadius = 3;
    saveBtn.layer.masksToBounds = YES;
    [saveBtn addTarget:self action:@selector(save) forControlEvents:(UIControlEventTouchUpInside)];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [view addSubview:saveBtn];
    
    _mainTableview.tableFooterView = view;
    [self.view addSubview:_mainTableview];
    
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
    [ensure addTarget:self action:@selector(ensureClass) forControlEvents:(UIControlEventTouchUpInside)];
    [_pickerBgView addSubview:ensure];
    
    UIView *line1 = [[UIView alloc]initWithFrame:XFrame(0, IFAutoFitPx(89), Screen_W, IFAutoFitPx(1))];
    [line1 setBackgroundColor:LineColor];
    [_pickerBgView addSubview:line1];
    
    _pickerView = [[UIPickerView alloc]init];
    [_pickerView setFrame:XFrame(0, IFAutoFitPx(110), Screen_W, IFAutoFitPx(454))];
    [_pickerView setDataSource:self];
    [_pickerView setDelegate:self];
    [_pickerView setShowsSelectionIndicator:YES];
    [_pickerBgView addSubview:_pickerView];
}

- (void)ensureClass{
    [_BackgroundView setHidden:YES];
    [_pickerBgView setHidden:YES];
    [self.mainTableview reloadData];
}

- (void)cancel{
    [_BackgroundView setHidden:YES];
    [_pickerBgView setHidden:YES];
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView == self.textview){
        if (!_textview.text.length){
            self.placeHolder.alpha = 1;
        }else{
            self.placeHolder.alpha = 0;
        }
    }
}


#pragma mark - tableview delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){
        return 2;
    }else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0){
        return IFAutoFitPx(35);
    }else{
        return 0;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0){
        UIView *view = [[UIView alloc]initWithFrame:XFrame(0, 0, Screen_W, IFAutoFitPx(35))];
        [view setBackgroundColor:LineColor];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewGoodsTableViewCell1 *cell1 = (NewGoodsTableViewCell1 *)[tableView dequeueReusableCellWithIdentifier:@"NewGoodsTableViewCell1"];
    NewGoodsTableViewCell2 *cell2 = (NewGoodsTableViewCell2 *)[tableView dequeueReusableCellWithIdentifier:@"NewGoodsTableViewCell2"];
    NewGoodsTableViewCell3 *cell3 = (NewGoodsTableViewCell3 *)[tableView dequeueReusableCellWithIdentifier:@"NewGoodsTableViewCell3"];
    NewGoodsTableViewCell4 *cell4 = (NewGoodsTableViewCell4 *)[tableView dequeueReusableCellWithIdentifier:@"NewGoodsTableViewCell4"];
    if (indexPath.section == 0){
        if (indexPath.row == 0){
            if (!cell4){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewGoodsTableViewCell4" owner:self options:nil];
                cell4 = [nib objectAtIndex:0];
            }
            cell4.text.placeholder = @"限30字以内";
            cell4.text.delegate = self;
            cell4.text.tag = 2;
            cell4.leftLabel.text = _dataArr[indexPath.section][indexPath.row];
            return cell4;
        }else{
            if (!cell2){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewGoodsTableViewCell2" owner:self options:nil];
                cell2 = [nib objectAtIndex:0];
                
            }
            cell2.leftLabel.text = _dataArr[indexPath.section][indexPath.row];
            cell2.rightLabel.text = _chooseClassName;
            return cell2;
        }
    }else{
        if (indexPath.row == 2){
            if (!cell3){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewGoodsTableViewCell3" owner:self options:nil];
                cell3 = [nib objectAtIndex:0];
            }
            cell3.leftLabel.text = _dataArr[indexPath.section][indexPath.row];
            cell3.delegate = self;
            return cell3;
        }
//        else if (indexPath.row == 3){
//            if (!cell2){
//                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewGoodsTableViewCell2" owner:self options:nil];
//                cell2 = [nib objectAtIndex:0];
//            }
//            cell2.leftLabel.text = _dataArr[indexPath.section][indexPath.row];
//            return cell2;
//        }
        else if (indexPath.row == 3){
            if (!cell1){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewGoodsTableViewCell1" owner:self options:nil];
                cell1 = [nib objectAtIndex:0];
            }
            cell1.leftLabel.text = _dataArr[indexPath.section][indexPath.row];
            cell1.rightLabel.text = @"份";
            return cell1;
        }else{
            if (!cell4){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewGoodsTableViewCell4" owner:self options:nil];
                cell4 = [nib objectAtIndex:0];
            }
            cell4.text.placeholder = @"请填写价格";
            cell4.text.delegate = self;
            cell4.text.tag = indexPath.row;
            cell4.leftLabel.text = _dataArr[indexPath.section][indexPath.row];
            return cell4;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        if (indexPath.row == 1){
            [_BackgroundView setHidden:NO];
            [_pickerBgView setHidden:NO];
        }
    }
}

#pragma mark - uipickerview delegate &datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickerDatasource.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 400;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *title = [[self.pickerDatasource objectAtIndex:row] objectForKey:@"stc_name"];
    _catergoryId = [[[self.pickerDatasource objectAtIndex:row] objectForKey:@"stc_id"] integerValue];
    _chooseClassName = title;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = [[self.pickerDatasource objectAtIndex:row] objectForKey:@"stc_name"];
//    _chooseClassName = title;
//    _catergoryId = [[[self.pickerDatasource objectAtIndex:row] objectForKey:@"stc_id"] integerValue];
    return title;
}

- (void)open:(NSString *)data{
    self.switchStatus = [data integerValue];
}

- (void)save{
    
    NSInteger storeid = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"] objectForKey:@"store_id"] integerValue];
    if(_goodsName == nil){
        [[IFUtils share]showErrorInfo:@"商品名称画不能为空"];
        return;
    }else if (_oldPrice == nil){
        [[IFUtils share]showErrorInfo:@"原来价格不能为空"];
        return;
    }else if (_currentPrice == nil){
        [[IFUtils share]showErrorInfo:@"价格不能为空"];
        return;
    }else if (_chooseClassName == nil){
        [[IFUtils share]showErrorInfo:@"分类名称不能为空"];
        return;
    }
    NSDictionary *sell_timeDict = @{@"start_time":@"00:00",@"end_time":@"23:99"};
    NSDictionary *dict = @{@"store_id":@(storeid),
                           @"class_id":@(_catergoryId),
                           @"goods_name":_goodsName,
                           @"goods_price":@([_currentPrice doubleValue]),
                           @"origin_price":@([_oldPrice doubleValue]),
                           @"goods_storage":@(self.switchStatus),
                           @"sell_time":[self toJSONString:sell_timeDict],
                           @"goods_desc":self.textview.text
                           };
    NSLog(@"%@%@%@%ld",_goodsName,_oldPrice,_currentPrice,self.switchStatus);
    [Http_url POST:@"add_goods" dict:dict showHUD:YES WithSuccessBlock:^(id data) {
        
        
    } WithFailBlock:^(id data) {
        
    }];
}

//转换成json
-(NSString*)toJSONString:(NSDictionary*)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    str = [NSString stringWithFormat:@"%@",str];
    return str;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 0){
        _currentPrice = textField.text;
    }else if (textField.tag == 1){
        _oldPrice = textField.text;
    }else{
        _goodsName = textField.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 懒加载
- (NSMutableArray *)pickerDatasource{
    if (!_pickerDatasource){
        _pickerDatasource = [NSMutableArray arrayWithCapacity:0];
    }
    return _pickerDatasource;
}
@end
