//
//  PhoneNumberSettingViewController.m
//  MerShop
//
//  Created by mac on 2019/3/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "PhoneNumberSettingViewController.h"

@interface PhoneNumberSettingViewController ()
@property (nonatomic ,strong)UITextField *text;
@property (nonatomic ,strong)UIButton *save;
@property (nonatomic ,copy)NSString *phoneNumber;
@end

@implementation PhoneNumberSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"餐厅电话"];
    [self.view setBackgroundColor:LineColor];
    [self setUI];
}

- (void)setUI{
    UIView *whiteView = [[UIView alloc]init];
    [whiteView setBackgroundColor:[UIColor whiteColor]];
    [whiteView setFrame:XFrame(0, IFAutoFitPx(20)+ViewStart_Y, Screen_W, IFAutoFitPx(88))];
    [self.view addSubview:whiteView];
    
    _text = [[UITextField alloc]init];
    [_text setFrame:XFrame(IFAutoFitPx(30), 0, Screen_W-IFAutoFitPx(30), IFAutoFitPx(88))];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    _phoneNumber = [[user objectForKey:@"userInfo"] objectForKey:@"store_phone"];
    [_text setText:_phoneNumber];
    [_text setBackgroundColor:[UIColor whiteColor]];
    _text.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [whiteView addSubview:_text];
    
    _save = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_save setFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(whiteView.frame)+IFAutoFitPx(60), Screen_W-IFAutoFitPx(60), IFAutoFitPx(88))];
    [_save setTitle:@"保存" forState:(UIControlStateNormal)];
    [_save setBackgroundColor:IFThemeBlueColor];
    [_save addTarget:self action:@selector(savePhoneNumber) forControlEvents:(UIControlEventTouchUpInside)];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_save.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(3, 3)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _save.bounds;
    maskLayer.path = maskPath.CGPath;
    self.save.layer.mask = maskLayer;
    [self.view addSubview:_save];
}

- (void)savePhoneNumber{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSInteger storeId = [[[user objectForKey:@"userInfo"] objectForKey:@"store_id"] integerValue];
    if ([self.text.text isEqualToString:_phoneNumber]){
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }else if (self.text.text.length == 0){
        [[IFUtils share]showErrorInfo:@"请输入电话号码"];
        return;
    }
    [Http_url POST:@"store_set_phone" dict:@{@"store_id":@(storeId),@"phone_number":self.text.text} showHUD:YES WithSuccessBlock:^(id data) {
        if ([[data objectForKey:@"code"] integerValue] == 200){
            [[IFUtils share]showErrorInfo:@"保存成功"];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:[user objectForKey:@"userInfo"]];
            [dict setObject:self.text.text forKey:@"store_phone"];
            [user setObject:dict forKey:@"userInfo"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } WithFailBlock:^(id data) {
        
    }];
}

@end
