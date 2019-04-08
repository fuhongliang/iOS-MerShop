//
//  BusinessLicenseViewController.m
//  MerShop
//
//  Created by mac on 2019/3/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BusinessLicenseViewController.h"
#import <Masonry.h>
#import "UIImageView+WebCache.h"

@interface BusinessLicenseViewController ()
@property (nonatomic ,strong)UIView *bgView;
@property (nonatomic ,strong)UIImageView *licenseImg;
@end

@implementation BusinessLicenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"营业资质"];
    [self.view setBackgroundColor:LineColor];
    [self setUI];
}

- (void)setUI{
    _bgView = [[UIView alloc]init];
    [_bgView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_bgView];
    
    _licenseImg = [[UIImageView alloc]init];
    [_licenseImg setContentMode:(UIViewContentModeScaleAspectFill)];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *licenseStr = [[userDefaults objectForKey:@"userInfo"] objectForKey:@"business_licence_number_electronic"];
    [_licenseImg sd_setImageWithURL:[NSURL URLWithString:licenseStr] placeholderImage:[UIImage imageNamed:@"photo_zhizhao"]];
    [_bgView addSubview:_licenseImg];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.top.equalTo(self.view.mas_top).offset(ViewStart_Y+10);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.equalTo(@(217));
    }];
    [_licenseImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_left).offset(66);
        make.top.equalTo(self.bgView.mas_top).offset(31);
        make.right.equalTo(self.bgView.mas_right).offset(-66);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-31);
    }];
    
}

@end
