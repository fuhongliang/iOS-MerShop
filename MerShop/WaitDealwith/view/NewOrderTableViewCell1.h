//
//  NewOrderTableViewCell1.h
//  MerShop
//
//  Created by mac on 2019/3/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@protocol NewOrderTableViewCell1Delegate <NSObject>
- (void)refuseOrder:(id)cell;
- (void)receiveOrder:(id)cell;
- (void)explandOrder:(id)data;
@end

@interface NewOrderTableViewCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *contentBgView;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *rightNowLab;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *customerPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *allPrice;
@property (weak, nonatomic) IBOutlet UILabel *servicePrice;
@property (weak, nonatomic) IBOutlet UILabel *income;
@property (weak, nonatomic) IBOutlet UILabel *makeOrderTime;
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UIButton *explandTextBtn;
@property (weak, nonatomic) IBOutlet UIButton *explandImgBtn;
@property (copy, nonatomic)NSString *expland;
@property (weak,nonatomic)id <NewOrderTableViewCell1Delegate>delegate;
- (IBAction)refuse:(id)sender;

- (IBAction)receive:(id)sender;

- (IBAction)explandAction:(id)sender;

- (void)addProduct:(OrderModel *)model withExplandState:(NSString *)state;
@end

