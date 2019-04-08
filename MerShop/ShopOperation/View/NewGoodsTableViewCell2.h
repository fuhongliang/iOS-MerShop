//
//  NewGoodsTableViewCell2.h
//  MerShop
//
//  Created by mac on 2019/3/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewGoodsTableViewCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
- (void)setAttributeText:(NSString *)string;
@end

