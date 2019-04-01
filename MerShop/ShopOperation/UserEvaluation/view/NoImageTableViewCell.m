//
//  NoImageTableViewCell.m
//  MerShop
//
//  Created by mac on 2019/3/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "NoImageTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation NoImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

- (IBAction)replyBtn:(NSString *)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(replyComment:)]){
        [self.delegate performSelector:@selector(replyComment:) withObject:_indexPathRow];
    }
}

- (void)addCommentData:(NSDictionary *)dict Index:(NSString *)index{
    self.indexPathRow = index;
    if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"haoping"]] isEqualToString:@"1"]){
        [self.star1 setImage:[UIImage imageNamed:@"pingjia_ic_xing"]];
        [self.star2 setImage:[UIImage imageNamed:@"pingjia_ic_xinghui"]];
        [self.star3 setImage:[UIImage imageNamed:@"pingjia_ic_xinghui"]];
        [self.star4 setImage:[UIImage imageNamed:@"pingjia_ic_xinghui"]];
        [self.star5 setImage:[UIImage imageNamed:@"pingjia_ic_xinghui"]];
    }else if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"haoping"]] isEqualToString:@"2"]){
        [self.star1 setImage:[UIImage imageNamed:@"pingjia_ic_xing"]];
        [self.star2 setImage:[UIImage imageNamed:@"pingjia_ic_xing"]];
        [self.star3 setImage:[UIImage imageNamed:@"pingjia_ic_xinghui"]];
        [self.star4 setImage:[UIImage imageNamed:@"pingjia_ic_xinghui"]];
        [self.star5 setImage:[UIImage imageNamed:@"pingjia_ic_xinghui"]];
    }else if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"haoping"]] isEqualToString:@"3"]){
        [self.star1 setImage:[UIImage imageNamed:@"pingjia_ic_xing"]];
        [self.star2 setImage:[UIImage imageNamed:@"pingjia_ic_xing"]];
        [self.star3 setImage:[UIImage imageNamed:@"pingjia_ic_xing"]];
        [self.star4 setImage:[UIImage imageNamed:@"pingjia_ic_xinghui"]];
        [self.star5 setImage:[UIImage imageNamed:@"pingjia_ic_xinghui"]];
    }else if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"haoping"]] isEqualToString:@"4"]){
        [self.star1 setImage:[UIImage imageNamed:@"pingjia_ic_xing"]];
        [self.star2 setImage:[UIImage imageNamed:@"pingjia_ic_xing"]];
        [self.star3 setImage:[UIImage imageNamed:@"pingjia_ic_xing"]];
        [self.star4 setImage:[UIImage imageNamed:@"pingjia_ic_xing"]];
        [self.star5 setImage:[UIImage imageNamed:@"pingjia_ic_xinghui"]];
    }else if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"haoping"]] isEqualToString:@"5"]){
        [self.star1 setImage:[UIImage imageNamed:@"pingjia_ic_xing"]];
        [self.star2 setImage:[UIImage imageNamed:@"pingjia_ic_xing"]];
        [self.star3 setImage:[UIImage imageNamed:@"pingjia_ic_xing"]];
        [self.star4 setImage:[UIImage imageNamed:@"pingjia_ic_xing"]];
        [self.star5 setImage:[UIImage imageNamed:@"pingjia_ic_xing"]];
    }else if ([[dict objectForKey:@"haoping"] isKindOfClass:[NSNull class]]){
        [self.star1 setImage:[UIImage imageNamed:@"pingjia_ic_xing"]];
        [self.star2 setImage:[UIImage imageNamed:@"pingjia_ic_xing"]];
        [self.star3 setImage:[UIImage imageNamed:@"pingjia_ic_xing"]];
        [self.star4 setImage:[UIImage imageNamed:@"pingjia_ic_xing"]];
        [self.star5 setImage:[UIImage imageNamed:@"pingjia_ic_xing"]];
    }
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"member_avatar"]]] placeholderImage:[UIImage imageNamed:@"comment_icon"]];
    
    if ([[dict objectForKey:@"member_name"] isEqual:[NSNull null]]){
        self.name.text = @"新用户999";
    }else{
        self.name.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"member_name"]];
    }
    if ([[dict objectForKey:@"kouwei"] isEqual:[NSNull null]]){
        self.taste.text = @"口味 5 星";
    }else{
        self.taste.text = [NSString stringWithFormat:@"口味 %@ 星",[dict objectForKey:@"kouwei"]];
    }
    if ([[dict objectForKey:@"baozhuang"] isEqual:[NSNull null]]){
        self.packing.text = @"包装 5 星";
    }else{
        self.packing.text = [NSString stringWithFormat:@"包装 %@ 星",[dict objectForKey:@"baozhuang"]];
    }
    if ([[dict objectForKey:@"peisong"] isEqual:[NSNull null]]){
        self.delivery.text = @"配送 5 星";
    }else{
        self.delivery.text = [NSString stringWithFormat:@"配送 %@ 星",[dict objectForKey:@"peisong"]];
    }
    
    self.date.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"add_time"]];

    self.comment.text = [dict objectForKey:@"content"];

    
}

@end
