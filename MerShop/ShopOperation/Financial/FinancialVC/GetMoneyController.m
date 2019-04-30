//
//  GetMoneyController.m
//  MerShop
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "GetMoneyController.h"
#import "GetMoneyView.h"

@interface GetMoneyController ()
@property (weak, nonatomic)GetMoneyView *mainview;
@end

@implementation GetMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNaviTitle:@"提现"];
    [self.view setBackgroundColor:BackgroundColor];
    [self setUI];
}

- (void)setUI{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"GetMoneyView" owner:self options:nil];
    _mainview = [nib objectAtIndex:0];
    [_mainview setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [self.view addSubview:_mainview];
    
}

@end
