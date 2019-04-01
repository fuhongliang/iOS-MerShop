//
//  HeaderView.h
//  MerShop
//
//  Created by mac on 2019/3/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJTopImageBottomTitleButton.h"

@protocol HeaderViewDelegate <NSObject>

- (void)category:(UIButton *)sender;
- (void)evaluation:(UIButton *)sender;
- (void)managementData:(UIButton *)sender;
@end

@interface HeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *todayIncome;
@property (weak, nonatomic) IBOutlet UILabel *todayOrder;
@property (weak, nonatomic) IBOutlet UILabel *collectNumber;
@property (weak, nonatomic) IBOutlet UILabel *totalGoods;
@property (weak, nonatomic) IBOutlet UILabel *oneMonthOrder;
@property (weak, nonatomic) IBOutlet UILabel *oneMonthIncome;
@property (weak, nonatomic) id<HeaderViewDelegate>delegate;

- (IBAction)goodsManageBtn:(id)sender;

- (IBAction)userEvaluationBtn:(id)sender;

- (IBAction)managementDataBtn:(id)sender;

- (void)addStoreInfo:(NSDictionary *)data;
@end

