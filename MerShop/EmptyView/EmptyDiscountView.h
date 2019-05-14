//
//  EmptyDiscountView.h
//  MerShop
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EmptyDiscountView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (nonatomic ,copy)NSArray *array;
@end

