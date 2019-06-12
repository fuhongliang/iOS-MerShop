//
//  DiscountPackageTableViewCell.h
//  MerShop
//
//  Created by mac on 2019/4/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscountModel.h"

@protocol DiscountPackageTableViewCellDelegate <NSObject>

- (void)manageAction:(id)data;
- (void)deleteAction:(id)data;

@end

@interface DiscountPackageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *stateImg;
@property (weak, nonatomic) IBOutlet UILabel *discountPrice;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *packageImg;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIButton *manageBtn;
@property (weak, nonatomic)id<DiscountPackageTableViewCellDelegate>delegate;
- (IBAction)manageAction:(id)sender;
- (IBAction)deleteAction:(id)sender;


- (void)setDataWithModel:(DiscountModel *)model;
@end

