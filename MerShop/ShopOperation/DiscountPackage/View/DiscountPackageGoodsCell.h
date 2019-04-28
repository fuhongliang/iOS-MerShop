//
//  DiscountPackageGoodsCell.h
//  MerShop
//
//  Created by mac on 2019/4/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DiscountPackageGoodsCellDelegate <NSObject>

- (void)deleteGoods:(id)data;

@end

@interface DiscountPackageGoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;
@property (weak, nonatomic) IBOutlet UILabel *discountPrice;
@property (weak, nonatomic)id<DiscountPackageGoodsCellDelegate>delegate;
- (IBAction)deleteAction:(id)sender;
- (void)setDataWithDict:(NSDictionary *)dict;
@end

