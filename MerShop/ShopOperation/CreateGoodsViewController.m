//
//  CreateGoodsViewController.m
//  MerShop
//
//  Created by mac on 2019/3/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CreateGoodsViewController.h"

@interface CreateGoodsViewController ()<UITextViewDelegate>
@property (nonatomic ,strong)UIView *view1;
@property (nonatomic ,strong)UIView *view2;
@property (nonatomic ,strong)UILabel *name;
@property (nonatomic ,strong)UILabel *descrip;
@property (nonatomic ,strong)UITextView *textview1;
@property (nonatomic ,strong)UITextView *textview2;
@property (nonatomic ,strong)UILabel *placeHolder1;
@property (nonatomic ,strong)UILabel *placeHolder2;
@property (nonatomic ,strong)UIButton *saveBtn;
@property (nonatomic ,strong)UIButton *cancelBtn;
@end

@implementation CreateGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"商品管理"];
    [self.view setBackgroundColor:LineColor];
    [self setUI];
    [self createPlaceHolder];
}

- (void)setUI{
    _view1 = [[UIView alloc]init];
    [_view1 setFrame:XFrame(0, ViewStart_Y, Screen_W, IFAutoFitPx(136))];
    [_view1 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_view1];
    
    _name = [[UILabel alloc]init];
    [_name setFrame:XFrame(IFAutoFitPx(30), IFAutoFitPx(30), Screen_W-IFAutoFitPx(60), IFAutoFitPx(32))];
    [_name setFont:XFont(17)];
    [_name setText:@"分类名称"];
    [_name setTextColor:BlackColor];
    [_view1 addSubview:_name];
    
    _textview1 = [[UITextView alloc]init];
    [_textview1 setFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(_name.frame)+IFAutoFitPx(10), Screen_W-IFAutoFitPx(60), IFAutoFitPx(60))];
    _textview1.delegate = self;
    [_view1 addSubview:_textview1];
    
    _view2 = [[UIView alloc]init];
    [_view2 setFrame:XFrame(0, CGRectGetMaxY(_view1.frame)+IFAutoFitPx(30), Screen_W, IFAutoFitPx(260))];
    [_view2 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_view2];
    
    _descrip = [[UILabel alloc]init];
    [_descrip setFrame:XFrame(IFAutoFitPx(30), IFAutoFitPx(30), Screen_W-IFAutoFitPx(60), IFAutoFitPx(32))];
    [_descrip setText:@"分类描述"];
    [_descrip setFont:XFont(17)];
    [_descrip setTextColor:BlackColor];
    [_view2 addSubview:_descrip];
    
    _textview2 = [[UITextView alloc]init];
    [_textview2 setFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(_descrip.frame)+IFAutoFitPx(10), Screen_W-IFAutoFitPx(60), IFAutoFitPx(168))];
    _textview2.delegate = self;
    [_view2 addSubview:_textview2];
    
    _saveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_saveBtn setFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(_view2.frame)+IFAutoFitPx(60), Screen_W-IFAutoFitPx(60), IFAutoFitPx(88))];
    [_saveBtn setBackgroundColor:IFThemeBlueColor];
    [_saveBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    [_saveBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    XViewLayerCB(_saveBtn, IFAutoFitPx(6), IFAutoFitPx(1), IFThemeBlueColor);
    [self.view addSubview:_saveBtn];
    
    _cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_cancelBtn setFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(_saveBtn.frame)+IFAutoFitPx(30), Screen_W-IFAutoFitPx(60), IFAutoFitPx(88))];
    [_cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [_cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [_cancelBtn setTitleColor:BlackColor forState:(UIControlStateNormal)];
    XViewLayerCB(_cancelBtn, IFAutoFitPx(6), IFAutoFitPx(1), toPCcolor(@"#DEDEDE"));
    [self.view addSubview:_cancelBtn];
    
}

- (void)createPlaceHolder{
    UILabel *placeHolder1 = [[UILabel alloc] initWithFrame:XFrame(IFAutoFitPx(0), 0, Screen_W-IFAutoFitPx(90), IFAutoFitPx(44))];
    placeHolder1.text = @"请输入分类名称";
    placeHolder1.textColor = toPCcolor(@"#999999");
    self.placeHolder1 = placeHolder1;
    placeHolder1.font = XFont(17);
    placeHolder1.numberOfLines = 0;
    placeHolder1.contentMode = UIViewContentModeTop;
    [self.textview1 addSubview:placeHolder1];
    
    UILabel *placeHolder2 = [[UILabel alloc] initWithFrame:XFrame(IFAutoFitPx(0), 0, Screen_W-IFAutoFitPx(60), IFAutoFitPx(44))];
    placeHolder2.text = @"请输入分类描述，最多40字";
    placeHolder2.textColor = toPCcolor(@"#999999");
    self.placeHolder2 = placeHolder2;
    placeHolder2.font = XFont(17);
    placeHolder2.numberOfLines = 0;
    placeHolder2.contentMode = UIViewContentModeTop;
    [self.textview2 addSubview:placeHolder2];
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView == _textview1){
        if (!_textview1.text.length){
            self.placeHolder1.alpha = 1;
        }else{
            self.placeHolder1.alpha = 0;
        }
    }else{
        if (!_textview2.text.length){
            self.placeHolder2.alpha = 1;
        }else{
            self.placeHolder2.alpha = 0;
        }
    }
}

@end
