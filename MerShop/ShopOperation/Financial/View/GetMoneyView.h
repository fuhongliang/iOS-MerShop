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

@end

@interface GetMoneyView : UIView
@property (weak, nonatomic) IBOutlet UILabel *accountType;
@property (weak, nonatomic) IBOutlet UILabel *lastFourNumber;
@property (weak, nonatomic) IBOutlet UITextField *moneyText;
@property (weak, nonatomic) IBOutlet UILabel *canGetLabel;
@property (weak, nonatomic)id<GetMoneyViewDelegate>delegate;
- (IBAction)allGetAction:(id)sender;
- (IBAction)ensure:(id)sender;

@end

