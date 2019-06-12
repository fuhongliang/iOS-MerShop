//
//  AllbillsHeaderView.m
//  MerShop
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AllbillsHeaderView.h"

@implementation AllbillsHeaderView

- (IBAction)chooseDateAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseDate)]){
        [self.delegate performSelector:@selector(chooseDate) withObject:nil];
    }
}
@end
