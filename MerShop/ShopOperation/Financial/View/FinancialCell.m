//
//  FinancialCell.m
//  MerShop
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "FinancialCell.h"

@implementation FinancialCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillCellWithDict:(NSDictionary *)dict{
    NSString *timestr = [NSString stringWithFormat:@"%@",dict[@"os_month"]];
    NSString *year = [timestr substringToIndex:4];
    NSString *month = [timestr substringFromIndex:timestr.length-2];
    self.timeLabel.text = [NSString stringWithFormat:@"%@年%@月份",year,month];
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",dict[@"amount"]];
    self.cardLabel.text = [NSString stringWithFormat:@"结算尾号：%@",dict[@"ob_no"]];
    if ([dict[@"state"] isEqualToString:@"1"]){
        self.state.text = @"已出账";
    }else if ([dict[@"state"] isEqualToString:@"2"]){
        self.state.text = @"店家已确认";
    }else if ([dict[@"state"] isEqualToString:@"3"]){
        self.state.text = @"平台已审核";
    }else if ([dict[@"state"] isEqualToString:@"4"]){
        self.state.text = @"结算完成";
    }
}
@end
