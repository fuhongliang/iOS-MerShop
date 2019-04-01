//
//  HeaderView.m
//  MerShop
//
//  Created by mac on 2019/3/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        
    }
    return self;
}
//@property (weak, nonatomic) IBOutlet UILabel *todayIncome;
//@property (weak, nonatomic) IBOutlet UILabel *todayOrder;
//@property (weak, nonatomic) IBOutlet UILabel *collectNumber;
//@property (weak, nonatomic) IBOutlet UILabel *totalGoods;
//@property (weak, nonatomic) IBOutlet UILabel *oneMonthOrder;
//@property (weak, nonatomic) IBOutlet UILabel *oneMonthIncome;

- (void)addStoreInfo:(NSDictionary *)data{
    self.todayIncome.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"today_orderamount"]];
    self.todayOrder.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"today_ordernum"]];
    self.collectNumber.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"store_collect"]];
    self.totalGoods.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"goods_num"]];
    self.oneMonthOrder.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"30_ordernum"]];
    self.oneMonthIncome.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"30_orderamount"]];
}

- (IBAction)goodsManageBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(category:)]){
        [self.delegate performSelector:@selector(category:) withObject:nil];
    }
}

- (IBAction)userEvaluationBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(evaluation:)]){
        [self.delegate performSelector:@selector(evaluation:) withObject:nil];
    }
}

- (IBAction)managementDataBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(managementData:)]){
        [self.delegate performSelector:@selector(managementData:) withObject:nil];
    }
}
@end
