//
//  BlueSettingView.m
//  MerShop
//
//  Created by mac on 2019/4/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BlueSettingView.h"

@implementation BlueSettingView



- (IBAction)printNumberBtn:(id)sender {
}

- (IBAction)printDistanceBtn:(id)sender {
}

- (IBAction)printTest:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(print)]){
        [self.delegate performSelector:@selector(print) withObject:nil];
    }
}
@end
