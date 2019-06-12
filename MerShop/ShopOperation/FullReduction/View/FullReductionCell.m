//
//  FullReductionCell.m
//  MerShop
//
//  Created by mac on 2019/4/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "FullReductionCell.h"

@implementation FullReductionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (IBAction)deleteAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteData:)]){
        [self.delegate performSelector:@selector(deleteData:) withObject:self];
    }
}
@end
