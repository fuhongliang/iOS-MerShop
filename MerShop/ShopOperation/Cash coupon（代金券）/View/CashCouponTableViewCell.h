//
//  CashCouponTableViewCell.h
//  MerShop
//
//  Created by mac on 2019/4/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponModel.h"

@protocol CashCouponTableViewCellDelegate <NSObject>

- (void)deleteAction:(id)data;
- (void)editeAction:(id)data;

@end

@interface CashCouponTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *couponImg;
@property (weak, nonatomic) IBOutlet UILabel *couponTitle;
@property (weak, nonatomic) IBOutlet UIImageView *couponStateImg;
@property (weak, nonatomic) IBOutlet UILabel *limitLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *rest;
@property (weak, nonatomic) IBOutlet UILabel *receive;
@property (weak, nonatomic) IBOutlet UILabel *used;
@property (weak, nonatomic) IBOutlet UILabel *orderPrice;
@property (weak, nonatomic) IBOutlet UIButton *editeBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;


@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;

@property (weak, nonatomic)id<CashCouponTableViewCellDelegate>delegate;
- (IBAction)edite:(id)sender;
- (IBAction)deleteAction:(id)sender;

- (void)setDataWithModel:(CouponModel *)model;
@end

