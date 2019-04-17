//
//  GoodsTableViewCell.h
//  MerShop
//
//  Created by mac on 2019/3/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"

@protocol GoodsTableViewCellDelegate <NSObject>

- (void)upShelfAction:(id)data;
- (void)edite:(id)data;
- (void)deleteGoods:(id)data;
@end

@interface GoodsTableViewCell : UITableViewCell
@property (nonatomic ,copy)NSString *state;

@property (weak, nonatomic) IBOutlet UIImageView *goodsIcon;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitle;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsStorage;
@property (weak, nonatomic) IBOutlet UIView *orangeView;
@property (weak, nonatomic) IBOutlet UILabel *goodsState;
@property (weak, nonatomic) IBOutlet UIButton *upShelf;
@property (weak, nonatomic)id<GoodsTableViewCellDelegate>delegate;
- (IBAction)upBtnAction:(id)sender;
- (IBAction)deleteAction:(id)sender;
- (IBAction)editeAction:(id)sender;

- (void)setDataWithModel:(GoodsModel *)model;
@end

