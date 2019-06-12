//
//  FooterView.h
//  MerShop
//
//  Created by mac on 2019/4/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FooterViewDelegate <NSObject>

- (void)addActivityGoods;
- (void)open:(id)data;
@end

@interface FooterView : UIView
@property (weak, nonatomic) IBOutlet UILabel *discountAllPrice;
@property (weak, nonatomic) IBOutlet UISwitch *stateSwitch;
@property (weak, nonatomic)id<FooterViewDelegate>delegate;
- (IBAction)addAction:(id)sender;
- (IBAction)openSwitch:(id)sender;

@end

