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
- (void)chooseCard;
- (void)protocol;

@end

@interface FinishBankCardInfo : UIView
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *bankCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *bankAddress;
@property (weak, nonatomic) IBOutlet UIButton *cardType;
@property (weak, nonatomic) IBOutlet UIButton *arrowBtn;

@property (weak, nonatomic)id<FinishBankCardInfoDelegate>delegate;
- (IBAction)finishAction:(id)sender;
- (IBAction)chooseCardAction:(id)sender;
- (IBAction)protocolAction:(id)sender;

@end

