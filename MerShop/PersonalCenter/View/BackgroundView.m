//
//  BackgroundView.m
//  MerShop
//
//  Created by mac on 2019/3/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BackgroundView.h"
#import "ZJTopImageBottomTitleButton.h"


@implementation BackgroundView{
    NSMutableArray *imageArr;
    NSMutableArray *titleArr;
    NSInteger index;
}

- (instancetype )initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    
    imageArr = [NSMutableArray arrayWithCapacity:0];
    titleArr = [NSMutableArray arrayWithCapacity:0];
    
    NSArray *imgarr1 = @[@"personal_ic_mdsz",@"personal_ic_dysz",@"personal_ic_xxls"];
    NSArray *imgarr2 = @[@"personal_ic_yyzt",@"personal_ic_zhaq",@"personal_ic_yjfk"];
    NSArray *imgarr3 = @[@"personal_ic_gywm",@"personal_ic_kfzx"];
    NSArray *title1 = @[@"门店设置",@"打印设置",@"消息和铃声"];
    NSArray *title2 = @[@"营业状态",@"账户与安全",@"意见反馈"];
    NSArray *title3 = @[@"关于我们",@"客服中心"];
    
    [imageArr addObject:imgarr1];
    [imageArr addObject:imgarr2];
    [imageArr addObject:imgarr3];
    
    [titleArr addObject:title1];
    [titleArr addObject:title2];
    [titleArr addObject:title3];
    
    CGFloat white_h = Screen_H-ViewStart_Y-IFAutoFitPx(126);
    _whiteView = [[UIView alloc]init];
    [_whiteView setFrame:XFrame(0, IFAutoFitPx(100), Screen_W, white_h)];
    [_whiteView setBackgroundColor:[UIColor whiteColor]];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_whiteView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(17, 17)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = _whiteView.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    self.whiteView.layer.mask = maskLayer;
    
    [self addSubview:_whiteView];
    
    _headImage = [[UIImageView alloc]init];
    [_headImage setFrame:XFrame(Screen_W/2-IFAutoFitPx(78), CGRectGetMinY(_whiteView.frame)-IFAutoFitPx(78), IFAutoFitPx(156), IFAutoFitPx(156))];
    _headImage.layer.cornerRadius = IFAutoFitPx(78);
    _headImage.layer.masksToBounds = YES;
    _headImage.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_headImage];
    
    _userName = [[UILabel alloc]init];
    [_userName setFrame:XFrame(0, CGRectGetMaxY(_headImage.frame)+IFAutoFitPx(24), Screen_W, IFAutoFitPx(36))];
    [_userName setText:@"前海一户"];
    [_userName setTextAlignment:(NSTextAlignmentCenter)];
    [_userName setTextColor:toPCcolor(@"#000000")];
    [_userName setFont:XFont(19)];
    [self addSubview:_userName];
    
    _describe = [[UILabel alloc]init];
    [_describe setFrame:XFrame(0, CGRectGetMaxY(_userName.frame)+IFAutoFitPx(24), Screen_W, IFAutoFitPx(36))];
    [_describe setTextAlignment:(NSTextAlignmentCenter)];
    [_describe setText:@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈"];
    [_describe setTextColor:toPCcolor(@"#999999")];
    [_describe setFont:XFont(15)];
    [self addSubview:_describe];
    
    index = 1000;
    CGFloat width_w =  (Screen_W-IFAutoFitPx(30)*4)/3;
    CGFloat point_y =  CGRectGetMaxY(_describe.frame)+IFAutoFitPx(72);
    for (NSInteger i=0; i<3; i++){
        for (NSInteger j=0; j<3; j++){
            
            if (j == 2 && i == 2){
                break;
            }
            ZJTopImageBottomTitleButton *btn = [[ZJTopImageBottomTitleButton alloc]init];
            [btn setFrame:XFrame((IFAutoFitPx(30)+width_w)*i+IFAutoFitPx(30), point_y+(IFAutoFitPx(120)+IFAutoFitPx(62))*j, width_w, IFAutoFitPx(120))];
            [btn setImage:[UIImage imageNamed:imageArr[j][i]] forState:(UIControlStateNormal)];
            index = index +1;
            btn.tag = index;
            NSLog(@"%ld~~~~%@",btn.tag,titleArr[j][i]);
            [btn setTitle:titleArr[j][i] forState:(UIControlStateNormal)];
            [btn setTitleColor:toPCcolor(@"#333333") forState:(UIControlStateNormal)];
            [btn.titleLabel setFont:XFont(12)];
            [btn addTarget:self action:@selector(touch:) forControlEvents:(UIControlEventTouchUpInside)];
            [self addSubview:btn];
            
            if (j == 2 && i == 1){
                _quitBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
                [_quitBtn setFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(btn.frame)+IFAutoFitPx(90), Screen_W-IFAutoFitPx(60), IFAutoFitPx(88))];
                [_quitBtn setTitle:@"退出登录" forState:(UIControlStateNormal)];
                [_quitBtn setBackgroundColor:IFThemeBlueColor];
                [_quitBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
                [_quitBtn addTarget:self action:@selector(quit) forControlEvents:(UIControlEventTouchUpInside)];
                _quitBtn.layer.cornerRadius = IFAutoFitPx(8);
                _quitBtn.layer.masksToBounds = YES;
                [self addSubview:_quitBtn];
            }
        }
    }
}

- (void)quit{
    if (self.delegate && [self.delegate respondsToSelector:@selector(SignOut)]){
        [self.delegate performSelector:@selector(SignOut) withObject:nil];
    }
}

- (void)setMyInformation:(NSDictionary *)userinfo{
    self.userName.text = [userinfo objectForKey:@"store_name"];
    self.describe.text = [userinfo objectForKey:@"store_description"];
}

- (void)touch:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(JumpToShopset:)]){
        [self.delegate performSelector:@selector(JumpToShopset:) withObject:sender];
    }
}

@end
