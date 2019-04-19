//
//  FullReduceTableViewCell.h
//  MerShop
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FullReductionModel.h"

@protocol FullReduceTableViewCellDelegate <NSObject>

- (void)deleteActivity:(id)data;

@end

@interface FullReduceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UILabel *activityName;
@property (weak, nonatomic) IBOutlet UILabel *activityTime;
@property (weak, nonatomic) IBOutlet UIImageView *stateImg;
@property (weak, nonatomic) IBOutlet UIImageView *activityImg;
@property (weak, nonatomic) IBOutlet UIView *limitBgview;
@property (weak, nonatomic)id<FullReduceTableViewCellDelegate>delegate;
- (IBAction)deleteAction:(id)sender;

- (void)setDataWithModel:(FullReductionModel *)model;
@end

