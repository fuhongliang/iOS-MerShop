//
//  FullReduceTableViewCell.m
//  MerShop
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "FullReduceTableViewCell.h"

@implementation FullReduceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)deleteAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteActivity:)]){
        [self.delegate performSelector:@selector(deleteActivity:) withObject:self];
    }
}

- (void)setDataWithModel:(FullReductionModel *)model{
    [self.line drawDottedLine];
    self.activityName.text = [NSString stringWithFormat:@"%@",model.mansong_name];
    NSString *time1 = [IFTools dateToString:[NSDate dateWithTimeIntervalSince1970:model.start_time] dateFormat:@"yyyy-MM-dd"];
    NSString *time2 = [IFTools dateToString:[NSDate dateWithTimeIntervalSince1970:model.end_time] dateFormat:@"yyyy-MM-dd"];
    self.activityTime.text = [NSString stringWithFormat:@"%@~%@",time1,time2];
    if (model.state == 4){
        [self.activityImg setImage:[UIImage imageNamed:@"yhq_bnt_xszk_mlj1"]];
        [self.stateImg setHidden:NO];
    }else if (model.state == 2){
        [self.activityImg setImage:[UIImage imageNamed:@"yhq_bnt_xszk_mlj"]];
        [self.stateImg setHidden:YES];
    }

    NSArray *a = model.rule;
    UILabel *lab = nil;
    for (NSInteger i =0 ;i<a.count;i++){
        NSDictionary *dict = a[i];
        UILabel *label = [[UILabel alloc]init];
        [label setText:
         [NSString stringWithFormat:@"   满 %@ 减 %@   ",dict[@"price"],dict[@"discount"]]];
        [label setFont:XFont(11)];
        [label setTextColor:toPCcolor(@"#f77a27")];
        XViewLayerCB(label, 1, 0.5, toPCcolor(@"#f77a27"));
        [self.limitBgview addSubview:label];
        if (i == 0){
            [label makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.limitBgview.mas_left).offset(0);
                make.top.equalTo(self.limitBgview.mas_top).offset(0);
                make.bottom.equalTo(self.limitBgview.mas_bottom).offset(0);
            }];
        }else{
            [label makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lab.mas_right).offset(10);
                make.top.equalTo(self.limitBgview.mas_top).offset(0);
                make.bottom.equalTo(self.limitBgview.mas_bottom).offset(0);
            }];
        }
        lab = label;
        
    }
}

@end
