//
//  AboutView.h
//  MerShop
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AboutViewDelegate <NSObject>

- (void)protocol;

@end

@interface AboutView : UIView

@property (weak ,nonatomic)id<AboutViewDelegate>delegate;
- (IBAction)protocolAction:(id)sender;

@end

