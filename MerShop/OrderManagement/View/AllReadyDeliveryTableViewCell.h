//
//  AllReadyDeliveryTableViewCell.h
//  MerShop
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewOrderModel.h"

@protocol AllReadyDeliveryTableViewCellDelegate <NSObject>

- (void)printfOrder:(id)data;
- (void)finishedExplandOrder:(id)data;
- (void)playCallAction1:(id)data;

@end

@interface AllReadyDeliveryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *rightNow;
@property (weak, nonatomic) IBOutlet UILabel *customerName;
@property (weak, nonatomic) IBOutlet UILabel *customerPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *orderState;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIView *contentBgView;
@property (weak, nonatomic) IBOutlet UILabel *allPrice;
@property (weak, nonatomic) IBOutlet UILabel *serviceFee;
@property (weak, nonatomic) IBOutlet UILabel *incomeFee;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UIButton *printfBtn;
@property (weak, nonatomic) IBOutlet UIButton *explandTextBtn;
@property (weak, nonatomic) IBOutlet UIButton *explandImgBtn;
@property (copy, nonatomic)NSString *expland;
@property (copy, nonatomic)NSString *PhoneNumber;
@property (weak, nonatomic)id<AllReadyDeliveryTableViewCellDelegate>delegate;
- (void)addProduct:(NewOrderModel *)model withExplandState:(NSString *)state;
- (IBAction)printf:(id)sender;
- (IBAction)playCall:(id)sender;
- (IBAction)explandAction:(id)sender;
@end

