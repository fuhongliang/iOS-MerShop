//
//  FullReductionCell.h
//  MerShop
//
//  Created by mac on 2019/4/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FullReductionCellDelegate <NSObject>

- (void)deleteData:(id)data;

@end

@interface FullReductionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fullStr;
@property (weak, nonatomic) IBOutlet UILabel *reduceStr;
@property (weak, nonatomic)id<FullReductionCellDelegate>delegate;
- (IBAction)deleteAction:(id)sender;

@end

