//
//  SortTableViewCell.m
//  MerShop
//
//  Created by mac on 2019/3/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SortTableViewCell.h"

@implementation SortTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)deleteBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteAction:)]){
        [self.delegate performSelector:@selector(deleteAction:) withObject:self];
    }
}

- (IBAction)topBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(topAction:)]){
        [self.delegate performSelector:@selector(topAction:) withObject:self];
    }
    
}
@end
