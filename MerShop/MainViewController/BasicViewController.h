//
//  BasicViewController.h
//  MerShop
//
//  Created by mac on 2019/3/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BasicViewController : UIViewController<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIView *navigationView;

@property (nonatomic,strong) UIButton *backBtn;

@property (nonatomic,strong) UIImageView *bgImgView;

@property (nonatomic,strong) UIView *line;

- (void)setNaviTitle:(NSString *)title;//设置导航标题

- (void)setNaviTitleColor:(UIColor *)color;//设置导航标题颜色

- (void)setHideBackBtn:(BOOL)YesOrNo;//隐藏返回按钮

- (void)sethideNaViGation:(BOOL)YesOrNo;//隐藏导航条

- (void)popViewController;
@end


