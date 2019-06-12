//
//  AllbillsHeaderView.h
//  MerShop
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AllbillsHeaderViewDelegate <NSObject>

- (void)chooseDate;

@end

@interface AllbillsHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *getMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *restMoneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
@property (weak, nonatomic)id<AllbillsHeaderViewDelegate>delegate;
- (IBAction)chooseDateAction:(id)sender;

@end

