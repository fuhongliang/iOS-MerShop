//
//  DiscountTableViewCell.h
//  MerShop
//
//  Created by mac on 2019/4/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LimitDiscountModel.h"

@protocol DiscountTableViewCellDelegate <NSObject>

- (void)editeAction:(id)data;
- (void)deleteAction:(id)data;

@end

@interface DiscountTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *limitImg;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *limitNumber;
@property (weak, nonatomic) IBOutlet UIImageView *stateImg;

@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIButton *editeBtn;
@property (weak, nonatomic)id<DiscountTableViewCellDelegate>delegate;
- (void)setDataWithModel:(LimitDiscountModel *)model;
- (IBAction)edite:(id)sender;

- (IBAction)deleteBtn:(id)sender;

@end

