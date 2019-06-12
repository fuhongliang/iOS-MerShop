//
//  FullReductionTableViewCell.h
//  MerShop
//
//  Created by mac on 2019/4/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FullReductionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *line;

- (void)setDataWithModel;
@end

