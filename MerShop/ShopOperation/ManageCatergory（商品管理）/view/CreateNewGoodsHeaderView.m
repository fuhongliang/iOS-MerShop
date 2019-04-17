//
//  CreateNewGoodsHeaderView.m
//  MerShop
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CreateNewGoodsHeaderView.h"

@implementation CreateNewGoodsHeaderView


- (IBAction)imageTap:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(goAlbum)]){
        [self.delegate performSelector:@selector(goAlbum) withObject:nil];
    }
}

- (IBAction)chooseImg:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(goAlbum)]){
        [self.delegate performSelector:@selector(goAlbum) withObject:nil];
    }
}

- (IBAction)chooseImage:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(goAlbum)]){
        [self.delegate performSelector:@selector(goAlbum) withObject:nil];
    }
}
@end
