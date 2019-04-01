//
//  ManageCatergoryTableViewCell.m
//  MerShop
//
//  Created by mac on 2019/3/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ManageCatergoryTableViewCell.h"

@implementation ManageCatergoryTableViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)editBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(edite:)]){
        [self.delegate performSelector:@selector(edite:) withObject:self];
    }
}

- (IBAction)addGoodsBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(createNewGoods)]){
        [self.delegate performSelector:@selector(createNewGoods) withObject:nil];
    }
}
@end
