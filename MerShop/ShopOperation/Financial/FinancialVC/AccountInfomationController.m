//
//  AccountInfomationController.m
//  MerShop
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AccountInfomationController.h"
#import "AccountInfoView.h"

@interface AccountInfomationController ()
@property (nonatomic ,weak)AccountInfoView *accountView;
@end

@implementation AccountInfomationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNaviTitle:@"账户信息"];
    [self.view setBackgroundColor:BackgroundColor];
    
    [self setUI];
}


- (void)setUI{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AccountInfoView" owner:self options:nil];
    _accountView = [nib objectAtIndex:0];
    [_accountView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [self.view addSubview:_accountView];
}


@end
