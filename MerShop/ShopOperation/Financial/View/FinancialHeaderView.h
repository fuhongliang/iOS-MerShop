//
//  FinancialHeaderView.h
//  MerShop
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FinancialHeaderViewDelegate <NSObject>

- (void)goBankCardView;
- (void)goGetMoneyView;

@end

@interface FinancialHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIView *bankCardView;
@property (weak, nonatomic)id<FinancialHeaderViewDelegate>delegate;
- (IBAction)addBankCardAction:(id)sender;
- (IBAction)getMoneyAction:(id)sender;

@end

