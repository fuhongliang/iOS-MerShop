//
//  NewCatergoryViewController.m
//  MerShop
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "NewCatergoryViewController.h"

@interface NewCatergoryViewController ()
@property (nonatomic ,strong)UITextField *text;
@end

@implementation NewCatergoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"分类编辑"];
    [self.view setBackgroundColor:LineColor];
    [self createUI];
}

- (void)createUI{
    UIView *view = [[UIView alloc]init];
    [view setFrame:XFrame(0, ViewStart_Y, Screen_W, IFAutoFitPx(136))];
    [view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view];
    
    UILabel *nameLab = [[UILabel alloc]init];
    [nameLab setFrame:XFrame(IFAutoFitPx(20), 0, Screen_W, IFAutoFitPx(68))];
    [nameLab setText:@"分类名称"];
    [nameLab setBackgroundColor:[UIColor whiteColor]];
    [nameLab setTextColor:toPCcolor(@"#000000")];
    [view addSubview:nameLab];
    
    _text = [[UITextField alloc]init];
    [_text setFrame:XFrame(IFAutoFitPx(20), IFAutoFitPx(68), Screen_W, IFAutoFitPx(68))];
    _text.placeholder = @"请输入分类名称";
    if (![self.className isKindOfClass:[NSNull class]]){
        [_text setText:_className];
    }
    [view addSubview:_text];
    
    UIButton *saveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [saveBtn setFrame:XFrame(IFAutoFitPx(20), CGRectGetMaxY(view.frame)+IFAutoFitPx(60), Screen_W-IFAutoFitPx(40), IFAutoFitPx(88))];
    [saveBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    [saveBtn setBackgroundColor:IFThemeBlueColor];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [saveBtn addTarget:self action:@selector(save) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:saveBtn];
}

- (void)save{
    NSUserDefaults *UserDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userinfo = [UserDefaults objectForKey:@"userInfo"];
    NSInteger storeID = [[ userinfo objectForKey:@"store_id"] integerValue];
    
    NSDictionary *dict = @{@"class_id":@(_classId),
                           @"store_id":@(storeID),
                           @"class_name":self.text.text
                           };
    [Http_url POST:@"add_goods_class" dict:dict showHUD:YES WithSuccessBlock:^(id data) {
        NSLog(@"新建成功");
    } WithFailBlock:^(id data) {
        
    }];
}

@end
