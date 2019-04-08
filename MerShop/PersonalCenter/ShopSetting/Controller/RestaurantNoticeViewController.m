//
//  RestaurantNoticeViewController.m
//  MerShop
//
//  Created by mac on 2019/3/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RestaurantNoticeViewController.h"

@interface RestaurantNoticeViewController ()<UITextViewDelegate>
@property (nonatomic ,strong)UITextView *text;
@property (nonatomic ,strong)UIButton *save;
@property (nonatomic ,strong)UILabel *placeHolder;

@end

@implementation RestaurantNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"餐厅公告"];
    [self.view setBackgroundColor:LineColor];
    [self setUI];
    [self setPlaceHolder];
}

- (void)setRestaurantAnnouncementRequest:(NSString *)announcement{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSInteger storeId = [dict[@"store_id"] integerValue];
    [Http_url POST:@"store_set_desc" dict:@{@"store_id":@(storeId),@"store_desc":announcement} showHUD:YES WithSuccessBlock:^(id data) {
        NSMutableDictionary *userDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
        [userDict setValue:announcement forKey:@"store_description"];
        [[NSUserDefaults standardUserDefaults] setObject:userDict forKey:@"userInfo"];
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"设置成功");
    } WithFailBlock:^(id data) {
        
    }];
}

- (void)setUI{
    _text = [[UITextView alloc]init];
    [_text setFrame:XFrame(0,ViewStart_Y+IFAutoFitPx(22), Screen_W, IFAutoFitPx(320))];
    [_text setTextColor:BlackColor];
    [_text setFont:XFont(17)];
    [_text setBackgroundColor:[UIColor whiteColor]];
    _text.delegate = self;
    [self.view addSubview:_text];
    
    _save = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_save setFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(_text.frame)+IFAutoFitPx(60), Screen_W-IFAutoFitPx(60), IFAutoFitPx(88))];
    [_save setTitle:@"保存" forState:(UIControlStateNormal)];
    [_save setBackgroundColor:IFThemeBlueColor];
    [_save.titleLabel setFont:XFont(17)];
    [_save addTarget:self action:@selector(saveRestaurantAnnouncement) forControlEvents:(UIControlEventTouchUpInside)];
    [_save setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    _save.layer.cornerRadius = IFAutoFitPx(6);
    _save.layer.masksToBounds = YES;
    [self.view addSubview:_save];
}

- (void)saveRestaurantAnnouncement{
    [self setRestaurantAnnouncementRequest:self.text.text];
}

- (void)setPlaceHolder{
    UILabel *placeHolder = [[UILabel alloc]init];
    self.placeHolder = placeHolder;
    [placeHolder setFrame:XFrame(IFAutoFitPx(15), IFAutoFitPx(13), Screen_W-IFAutoFitPx(60), IFAutoFitPx(36))];
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSString *str = [dict objectForKey:@"store_description"];
    if (str.length == 0 || [str isKindOfClass:[NSNull class]]){
        [placeHolder setText:@"设置一条您的餐厅公告(200字以内)"];
    }else{
        self.text.text = str;
    }
    [placeHolder setFont:XFont(17)];
    [placeHolder setTextColor:GrayColor];
    [_text addSubview:placeHolder];
}

- (void)textViewDidChange:(UITextView *)textView{
    if (!_text.text.length){
        self.placeHolder.alpha = 1;
    }else{
        self.placeHolder.alpha = 0;
    }
}

@end
