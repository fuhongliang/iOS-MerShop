//
//  EditeActivityTableViewCell.h
//  MerShop
//
//  Created by mac on 2019/4/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditeActivityTableViewCellDelegate <NSObject>

- (void)deleteGoods:(id)data;

@end

@interface EditeActivityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImg;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *discountRate;
@property (weak, nonatomic) IBOutlet UILabel *nowPrice;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;
@property (weak, nonatomic)id<EditeActivityTableViewCellDelegate>delegate;
- (IBAction)deleteAction:(id)sender;
- (void)setDataWithDict:(NSDictionary *)dict;
@end

