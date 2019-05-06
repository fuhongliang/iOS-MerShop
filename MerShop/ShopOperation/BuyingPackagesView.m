//
//  BuyingPackagesView.m
//  MerShop
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BuyingPackagesView.h"

@implementation BuyingPackagesView

- (IBAction)cancelAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancel)]){
        [self.delegate performSelector:@selector(cancel) withObject:nil];
    }
}

- (IBAction)ensureAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(ensure)]){
        [self.delegate performSelector:@selector(ensure) withObject:nil];
    }
}
@end
