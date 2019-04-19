//
//  NewGoodsTableViewCell3.m
//  MerShop
//
//  Created by mac on 2019/3/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "NewGoodsTableViewCell3.h"

@implementation NewGoodsTableViewCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)openOrclose:(id)sender {
    if (self.kaiguan.isOn){
        if (self.delegate && [self.delegate respondsToSelector:@selector(open:)]){
            [self.delegate performSelector:@selector(open:) withObject:@"999999999"];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(open:)]){
            [self.delegate performSelector:@selector(open:) withObject:@"0"];
        }
    }
}
@end
