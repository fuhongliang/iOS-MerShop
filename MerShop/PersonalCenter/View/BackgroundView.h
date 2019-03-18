//
//  BackgroundView.h
//  MerShop
//
//  Created by mac on 2019/3/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackgroundViewDelegate <NSObject>

- (void)JumpToShopset:(UIButton *)button;

@end


@interface BackgroundView : UIView
@property (nonatomic ,strong)UIView *whiteView;
@property (nonatomic ,strong)UIImageView *headImage;
@property (nonatomic ,strong)UILabel *userName;
@property (nonatomic ,strong)UILabel *describe;
@property (nonatomic ,strong)UIButton *quitBtn;
@property (nonatomic ,weak)id<BackgroundViewDelegate>delegate;
@end

