//
//  ZJTopImageBottomTitleButton.h
//  mobiportal
//
//  Created by luozhijun on 14-11-13.
//  Copyright (c) 2014年 bgyun. All rights reserved.
//  上部分是图片, 下部分是标题的按钮, 默认的图片模式是UIViewContentModeScaleAspectFit, 标题默认居中

#import <UIKit/UIKit.h>

/** 上部分是图片, 下部分是标题的按钮, 默认的图片模式是UIViewContentModeScaleAspectFit, 标题默认居中 */
@interface ZJTopImageBottomTitleButton : UIButton
/** 
 *  内部图片占整个button的高度比例
 *  @note 如果<0.01 或者 >1 则忽略此值, 改用titleLabel所需具体高度确定image和Label的高度
 */
@property (nonatomic, assign) CGFloat imageHeightRatio;
@property (nonatomic, assign, getter=isImageRound) BOOL imageRound;

- (instancetype)initWithImageHeightRatio:(CGFloat)imageHeightRatio imageRound:(BOOL)imageRound;
- (void)setImageHeightRatio:(CGFloat)imageHeightRatio;

@end
