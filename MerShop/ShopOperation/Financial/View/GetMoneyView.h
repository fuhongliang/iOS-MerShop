//
//  GetMoneyView.h
//  MerShop
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GetMoneyViewDelegate <NSObject>

- (void)allGet;
- (void)ensureGet;
- (void)addBankCard;
@end

@interface GetMoneyView : UIView
@property (weak, nonatomic) IBOutlet UILabel *accountType;
@property (weak, nonatomic) IBOutlet UILabel *lastFourNumber;
@property (weak, nonatomic) IBOutlet UITextField *moneyText;
@property (weak, nonatomic) IBOutlet UILabel *canGetLabel;
@property (weak, nonatomic) IBOutlet UIButton *arrow;

@property (weak, nonatomic)id<GetMoneyViewDelegate>delegate;
- (IBAction)allGetAction:(id)sender;
- (IBAction)ensure:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addCardBtn;
- (IBAction)addAction:(id)sender;

@end

