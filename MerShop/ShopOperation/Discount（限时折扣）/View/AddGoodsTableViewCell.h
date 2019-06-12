//
//  AddGoodsTableViewCell.h
//  MerShop
//
//  Created by mac on 2019/4/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddGoodsTableViewCellDelegate <NSObject>

- (void)seletItem:(id)data;

@end

@interface AddGoodsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *discountImg;
@property (weak, nonatomic) IBOutlet UILabel *DiscountRate;
@property (weak, nonatomic) IBOutlet UILabel *nowPrice;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic)id<AddGoodsTableViewCellDelegate>delegate;
- (IBAction)chooseAction:(id)sender;

- (void)setDataWithDict:(NSDictionary *)dict;

@end

