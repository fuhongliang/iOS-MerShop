//
//  RingSettingViewController.m
//  MerShop
//
//  Created by mac on 2019/3/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RingSettingViewController.h"
#import "NewsSettingview.h"

@interface RingSettingViewController ()

@end

@implementation RingSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"消息和铃声设置"];
    [self.navigationController.navigationBar setHidden:YES];
    [self.view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [self setUI];
}

- (void)setUI{
    
    NSArray *nibView = [[NSBundle mainBundle]loadNibNamed:@"NewsSettingview" owner:self options:nil];
    NewsSettingview *view = [nibView objectAtIndex:0];
    [view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [view setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [self.view addSubview:view];
    
}

@end
