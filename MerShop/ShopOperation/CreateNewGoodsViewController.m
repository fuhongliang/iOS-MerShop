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


@interface CreateNewGoodsViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property (nonatomic ,strong)UITableView *mainTableview;
@property (nonatomic ,copy)NSArray *dataArr;
@property (nonatomic ,strong)UITextView *textview;
@property (nonatomic ,strong)UILabel *placeHolder;
@end

@implementation CreateNewGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"新建商品"];
    self.dataArr = @[@[@"商品名称*",@"商品分类*"],@[@"价格*",@"原价*",@"库存无限",@"可售时间",@"商品单位"]];
    [self.view setBackgroundColor:LineColor];
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
    [view1 addSubview:_textview];
    
    UILabel *placeHolder1 = [[UILabel alloc] initWithFrame:XFrame(0, 0, Screen_W-IFAutoFitPx(60), IFAutoFitPx(44))];
    placeHolder1.text = @"介绍一下您的产品吧，200字以内就可以哦";
    placeHolder1.textColor = toPCcolor(@"#999999");
    self.placeHolder = placeHolder1;
    placeHolder1.font = XFont(17);
    placeHolder1.numberOfLines = 0;
    placeHolder1.contentMode = UIViewContentModeTop;
    [self.textview addSubview:placeHolder1];
    
    
    UIButton *saveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [saveBtn setFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(view1.frame)+IFAutoFitPx(61), Screen_W-IFAutoFitPx(60), IFAutoFitPx(88))];
    [saveBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    [saveBtn setBackgroundColor:IFThemeBlueColor];
    saveBtn.layer.cornerRadius = 3;
    saveBtn.layer.masksToBounds = YES;
    [saveBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [view addSubview:saveBtn];
    
    _mainTableview.tableFooterView = view;
    [self.view addSubview:_mainTableview];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){
        return 2;
    }else{
        return 5;
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
            cell4.leftLabel.text = _dataArr[indexPath.section][indexPath.row];
            return cell4;
        }else{
            if (!cell2){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewGoodsTableViewCell2" owner:self options:nil];
                cell2 = [nib objectAtIndex:0];
                
            }
            cell2.leftLabel.text = _dataArr[indexPath.section][indexPath.row];
            return cell2;
        }
    }else{
        if (indexPath.row == 2){
            if (!cell3){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewGoodsTableViewCell3" owner:self options:nil];
                cell3 = [nib objectAtIndex:0];
            }
            cell3.leftLabel.text = _dataArr[indexPath.section][indexPath.row];
            return cell3;
        }else if (indexPath.row == 3){
            if (!cell2){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewGoodsTableViewCell2" owner:self options:nil];
                cell2 = [nib objectAtIndex:0];
            }
            cell2.leftLabel.text = _dataArr[indexPath.section][indexPath.row];
            return cell2;
        }else if (indexPath.row == 4){
            if (!cell1){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewGoodsTableViewCell1" owner:self options:nil];
                cell1 = [nib objectAtIndex:0];
            }
            cell1.leftLabel.text = _dataArr[indexPath.section][indexPath.row];
            return cell1;
        }else{
            if (!cell4){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewGoodsTableViewCell4" owner:self options:nil];
                cell4 = [nib objectAtIndex:0];
            }
            cell4.text.placeholder = @"请填写价格";
            cell4.leftLabel.text = _dataArr[indexPath.section][indexPath.row];
            return cell4;
        }
    }
    return nil;
}

@end
