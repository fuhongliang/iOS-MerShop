//
//  EditeCashCouponView.h
//  MerShop
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditeCouponViewDelegate <NSObject>

- (void)addNumber;
- (void)reduceNumber;
- (void)showPickerView:(id)data;

@end

@interface EditeCouponView : UIView

@property (weak, nonatomic) IBOutlet UIView *backgroundView;

//代金券名称
@property (weak, nonatomic) IBOutlet UILabel *cashCouponLab;
//代金券输入框
@property (weak, nonatomic) IBOutlet UITextField *cashCouponNameText;
//使用条件输入框
@property (weak, nonatomic) IBOutlet UITextField *serviceConditionText;
//面值选择按钮
@property (weak, nonatomic) IBOutlet UIButton *selectNumber;
//时间选择按钮
@property (weak, nonatomic) IBOutlet UIButton *selectTime;
//发放张数输入框
@property (weak, nonatomic) IBOutlet UITextField *couponNumberText;
//限领减少按钮
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
//限领增加按钮
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
//限领文本
@property (weak, nonatomic) IBOutlet UILabel *limitLab;
//描述输入框
@property (weak, nonatomic) IBOutlet UITextField *couponDescription;

@property (weak, nonatomic)id<EditeCouponViewDelegate>delegate;
- (IBAction)addAction:(id)sender;
- (IBAction)reduceAction:(id)sender;
- (IBAction)selectNumAction:(id)sender;
- (IBAction)selectTimeAction:(id)sender;

@end

