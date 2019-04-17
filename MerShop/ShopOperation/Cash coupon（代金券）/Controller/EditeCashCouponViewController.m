//
//  EditeCashCouponViewController.m
//  MerShop
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "EditeCashCouponViewController.h"

@interface EditeCashCouponViewController ()<EditeCouponViewDelegate>
@property (nonatomic ,strong)EditeCouponView *editeView;
@property (nonatomic ,assign)NSInteger lowerLimitNumber;
@end

@implementation EditeCashCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"添加活动"];
    _lowerLimitNumber = 1;
    [self.view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [self setUI];
}

- (void)setUI{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EditeCouponView" owner:self options:nil];
    _editeView = [nib objectAtIndex:0];
    _editeView.delegate = self;
    [_editeView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [self.view addSubview:self.editeView];
}

#pragma mark - EditeCouponViewDelegate
- (void)reduceNumber{
    if (_lowerLimitNumber == 1){
        NSLog(@"--------最低数量");
        return;
    }else{
        _lowerLimitNumber = _lowerLimitNumber - 1;
        _editeView.limitLab.text = [NSString stringWithFormat:@"%ld",_lowerLimitNumber];
    }
}

- (void)addNumber{
    _lowerLimitNumber ++;
    _editeView.limitLab.text = [NSString stringWithFormat:@"%ld",_lowerLimitNumber];
}
@end
