//
//  UserEvaluationTableViewCell.m
//  MerShop
//
//  Created by mac on 2019/3/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UserEvaluationTableViewCell.h"

@implementation UserEvaluationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)replyBtn:(id)sender {
}

- (void)addCommentData:(NSDictionary *)data Index:(NSString *)index{
    self.name.text = [data objectForKey:@"member_name"];
    self.date.text = [data objectForKey:@"add_time"];
    self.taste.text = [NSString stringWithFormat:@"口味 %@ 星",[data objectForKey:@"kouwei"]];
    self.packing.text = [NSString stringWithFormat:@"包装 %@ 星",[data objectForKey:@"baozhuang"]];
    self.delivery.text = [NSString stringWithFormat:@"配送 %@ 星",[data objectForKey:@"peisong"]];
    self.comment.text = [data objectForKey:@"content"];
}
@end
