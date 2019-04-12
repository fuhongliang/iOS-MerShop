//
//  CashCouponTableViewCell.h
//  MerShop
//
//  Created by mac on 2019/4/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CashCouponTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;

- (void)setDataWithModel;
@end

