//
//  FullReduceTableViewCell.h
//  MerShop
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FullReduceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *line;

- (void)setDataWithModel;
@end

