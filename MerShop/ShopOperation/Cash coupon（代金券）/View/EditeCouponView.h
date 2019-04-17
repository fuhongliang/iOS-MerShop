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

@end

@interface EditeCouponView : UIView
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel *cashCouponLab;
@property (weak, nonatomic) IBOutlet UITextField *cashCouponNameText;
@property (weak, nonatomic) IBOutlet UITextField *serviceConditionText;
@property (weak, nonatomic) IBOutlet UITextField *couponNumber;
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *limitLab;
@property (weak, nonatomic) IBOutlet UITextField *couponDescription;
@property (weak, nonatomic)id<EditeCouponViewDelegate>delegate;
- (IBAction)submitAction:(id)sender;
- (IBAction)addAction:(id)sender;
- (IBAction)reduceAction:(id)sender;

@end

