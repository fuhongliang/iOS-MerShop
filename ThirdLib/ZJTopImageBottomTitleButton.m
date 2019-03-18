//
//  ZJTopImageBottomTitleButton.m
//  mobiportal
//
//  Created by luozhijun on 14-11-13.
//  Copyright (c) 2014年 bgyun. All rights reserved.
//

#import "ZJTopImageBottomTitleButton.h"

@implementation ZJTopImageBottomTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseSetting];
    }
    return self;
}

- (instancetype)initWithImageHeightRatio:(CGFloat)imageHeightRatio imageRound:(BOOL)imageRound
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self baseSetting];
        
        _imageHeightRatio = imageHeightRatio;
        _imageRound = imageRound;
        self.imageView.clipsToBounds = imageRound;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self baseSetting];
}

- (void)baseSetting
{
    // 0.
    _imageHeightRatio = 0.6;
    
    // 1.设置图片默认模式
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    // 2.设置文字属性
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (void)setImageHeightRatio:(CGFloat)imageHeightRatio
{
    _imageHeightRatio = imageHeightRatio;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setImageRound:(BOOL)imageRound
{
    _imageRound = imageRound;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize  titleLabelNeedSize = [self.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat titleH = 0;
    CGFloat titleW = titleLabelNeedSize.width;
    CGFloat imageH = 0;
    
    if (self.imageHeightRatio > 0.01 && self.imageHeightRatio <= 1) {
        titleH = self.frame.size.height * (1 - self.imageHeightRatio);
        imageH = self.frame.size.height * self.imageHeightRatio;
    } else {
        titleH = titleLabelNeedSize.height;
        imageH = self.frame.size.height - titleH;
    }
    
    CGFloat imageW = self.imageView.frame.size.width;
    CGFloat imageX = (self.frame.size.width - imageW) / 2.f;
    CGFloat imageY = 0;
    self.imageView.frame = CGRectMake(imageX, imageY, self.imageView.frame.size.width, imageH);
    if (_imageRound) {
        self.imageView.layer.cornerRadius = imageW / 2;
    }
    
    CGFloat titleX = (self.frame.size.width - titleW) / 2.f;;
    CGFloat titleY = self.frame.size.height - titleH;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
}

@end
