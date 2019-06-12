//
//  AddBankCardView.h
//  MerShop
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddBankCardViewDelegate <NSObject>

- (void)addCard;

@end

@interface AddBankCardView : UIView
@property (weak, nonatomic)id<AddBankCardViewDelegate>delegate;
- (IBAction)addBankCardAction:(id)sender;

@end

