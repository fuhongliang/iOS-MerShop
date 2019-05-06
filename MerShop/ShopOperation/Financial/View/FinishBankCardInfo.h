//
//  FinishBankCardInfo.h
//  MerShop
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FinishBankCardInfoDelegate <NSObject>

- (void)finish;

@end

@interface FinishBankCardInfo : UIView
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *bankCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *bankAddress;
@property (weak, nonatomic) IBOutlet UITextField *bankType;

@property (weak, nonatomic)id<FinishBankCardInfoDelegate>delegate;
- (IBAction)finishAction:(id)sender;

@end

