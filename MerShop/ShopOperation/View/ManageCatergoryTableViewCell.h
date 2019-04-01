//
//  ManageCatergoryTableViewCell.h
//  MerShop
//
//  Created by mac on 2019/3/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ManageCatergoryTableViewCellDelegate <NSObject>

- (void)edite:(id)sender;
- (void)createNewGoods;

@end


@interface ManageCatergoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *catergoryLab;
@property (weak, nonatomic)id<ManageCatergoryTableViewCellDelegate>delegate;
- (IBAction)editBtn:(id)sender;
- (IBAction)addGoodsBtn:(id)sender;

@end

