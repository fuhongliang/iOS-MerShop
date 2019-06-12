//
//  AboutView.m
//  MerShop
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AboutView.h"

@implementation AboutView



- (IBAction)protocolAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(protocol)]){
        [self.delegate performSelector:@selector(protocol) withObject:nil];
    }
}
@end
