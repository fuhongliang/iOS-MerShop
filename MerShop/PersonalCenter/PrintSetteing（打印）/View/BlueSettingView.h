//
//  BlueSettingView.h
//  MerShop
//
//  Created by mac on 2019/4/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BlueSettingViewDelegate <NSObject>

- (void)print;

@end

@interface BlueSettingView : UIView
@property (nonatomic ,weak)id<BlueSettingViewDelegate>delegate;
- (IBAction)printNumberBtn:(id)sender;
- (IBAction)printDistanceBtn:(id)sender;
- (IBAction)printTest:(id)sender;


@end

