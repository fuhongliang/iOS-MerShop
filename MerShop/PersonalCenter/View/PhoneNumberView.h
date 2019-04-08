//
//  PhoneNumberView.h
//  MerShop
//
//  Created by mac on 2019/3/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhoneNumberViewDelegate <NSObject>

- (void)cancelCall:(UIButton *)sender;
- (void)playCall:(UIButton *)sender;

@end

@interface PhoneNumberView : UIView
@property (nonatomic ,strong)UILabel *titleLab;
@property (nonatomic ,strong)UILabel *numberLab;
@property (nonatomic ,strong)UIButton *cancelBtn;
@property (nonatomic ,strong)UIButton *confirmBtn;
@property (nonatomic ,weak)id<PhoneNumberViewDelegate>delegate;

- (void)setViewTitle:(NSString *)title
            subTitle:(NSString *)str
              cancel:(NSString *)cancel
              ensure:(NSString *)ensure;
@end

