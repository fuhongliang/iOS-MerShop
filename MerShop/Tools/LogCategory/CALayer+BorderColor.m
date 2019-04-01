//
//  CALayer+BorderColor.m
//  MerShop
//
//  Created by mac on 2019/4/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CALayer+BorderColor.h"

@implementation CALayer (BorderColor)
- (void)setBorderColorFromUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}
@end
