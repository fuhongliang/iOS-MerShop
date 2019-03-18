//
//  BasicViewController.m
//  MerShop
//
//  Created by mac on 2019/3/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController (){
    
    UILabel *naviTitle;
}

@end

@implementation BasicViewController
@synthesize backBtn;
@synthesize line;
@synthesize bgImgView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationBar];
}

#pragma  mark - SetNavigationBarEvent
- (void)createNavigationBar{
    UIView *xphNavgationBar = [[UIView alloc] init];
    [xphNavgationBar setBackgroundColor:IFThemeBlueColor];
    [xphNavgationBar setFrame:CGRectMake(0.0, 0.0, Screen_W, Navagtion_H+StatusBar_H)];
    [self.view addSubview:xphNavgationBar];
    
    self.navigationView = xphNavgationBar;
    
    backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backBtn setFrame:XFrame(0, StatusBar_H, Navagtion_H, Navagtion_H)];
    [backBtn setImage:[UIImage imageNamed:@"navBack"] forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(popViewController) forControlEvents:(UIControlEventTouchUpInside)];
    [xphNavgationBar addSubview:backBtn];
    
    naviTitle = [[UILabel alloc] init];
    [naviTitle setFrame:CGRectMake(Screen_W*0.2, StatusBar_H, Screen_W*0.6, Navagtion_H)];
    [naviTitle setBackgroundColor:[UIColor clearColor]];
    [naviTitle setTextAlignment:NSTextAlignmentCenter];
    [naviTitle setFont:XFont(18)];
    [naviTitle setTextColor:[UIColor whiteColor]];
    [xphNavgationBar addSubview:naviTitle];
    
}

- (void)setNaviTitle:(NSString *)title{
    if (title){
        [naviTitle setText:title];
    }else{
        [naviTitle setHidden:YES];
    }
}

- (void)setNaviTitleColor:(UIColor *)color{
    [naviTitle setTintColor:color];
}

- (void)setHideBackBtn:(BOOL)YesOrNo{
    [self.backBtn setHidden:YesOrNo];
}

- (void)sethideNaViGation:(BOOL)YesOrNo{
    [self.navigationController.navigationBar setHidden:YesOrNo];
}

- (void)pushViewController:(id)pushVc{
    [self.navigationController pushViewController:pushVc animated:YES];
}
- (void)popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
