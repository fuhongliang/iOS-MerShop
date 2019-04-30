//
//  AddBankCardController.m
//  MerShop
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AddBankCardController.h"
#import "FinishBankCardInfo.h"

@interface AddBankCardController ()
@property (weak, nonatomic)FinishBankCardInfo *mainView;
@end

@implementation AddBankCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"添加银行卡"];
    [self.view setBackgroundColor:BackgroundColor];
    [self setUI];
}

- (void)setUI{
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FinishBankCardInfo" owner:self options:nil];
    _mainView = [nib objectAtIndex:0];
    [_mainView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [self.view addSubview:_mainView];
}
@end
