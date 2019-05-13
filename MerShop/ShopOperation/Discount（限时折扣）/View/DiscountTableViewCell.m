//
//  DiscountTableViewCell.m
//  MerShop
//
//  Created by mac on 2019/4/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DiscountTableViewCell.h"

@implementation DiscountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setDataWithModel:(LimitDiscountModel *)model{
    [self.line drawDottedLine];
    NSString *time1 = [IFTools dateToString:[NSDate dateWithTimeIntervalSince1970:model.start_time] dateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *time2 = [IFTools dateToString:[NSDate dateWithTimeIntervalSince1970:model.end_time] dateFormat:@"yyyy-MM-dd HH:mm"];
    self.title.text = [NSString stringWithFormat:@"%@",model.xianshi_name];
    self.time.text = [NSString stringWithFormat:@"%@~%@",time1,time2];
    self.limitNumber.text = [NSString stringWithFormat:@"购买下限：%ld",(long)model.lower_limit];
    if (model.state == 0){
        self.limitImg.image = [UIImage imageNamed:@"yhq_bnt_xszk01"];
        [self.stateImg setHidden:NO];
        [self.editeBtn setHidden:YES];
    }else{
        self.limitImg.image = [UIImage imageNamed:@"yhq_bnt_xszk"];
        [self.stateImg setHidden:YES];
        [self.editeBtn setHidden:NO];
    }
}

- (IBAction)edite:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(editeAction:)]){
        [self.delegate performSelector:@selector(editeAction:) withObject:self];
    }
}

- (IBAction)deleteBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteAction:)]){
        [self.delegate performSelector:@selector(deleteAction:) withObject:self];
    }
}

@end
