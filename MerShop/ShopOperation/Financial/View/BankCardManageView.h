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
- (void)deleteAction;

@end

@interface BankCardManageView : UIView
@property (weak, nonatomic) IBOutlet UILabel *bankType;
@property (weak, nonatomic) IBOutlet UILabel *topFour;
@property (weak, nonatomic) IBOutlet UILabel *lastFour;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic)id<BankCardManageViewDelegate>delegate;
- (IBAction)clickAccountInfo:(id)sender;

- (IBAction)deleteCard:(id)sender;
@end

