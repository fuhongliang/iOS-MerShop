//
//  BankCardManageView.h
//  MerShop
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BankCardManageViewDelegate <NSObject>

- (void)checkAccountInfo;

@end

@interface BankCardManageView : UIView
@property (weak, nonatomic)id<BankCardManageViewDelegate>delegate;
- (IBAction)clickAccountInfo:(id)sender;

@end

