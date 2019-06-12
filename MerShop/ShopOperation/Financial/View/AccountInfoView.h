//
//  AccountInfoView.h
//  MerShop
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AccountInfoView : UIView
@property (weak, nonatomic) IBOutlet UILabel *accountNumber;
@property (weak, nonatomic) IBOutlet UILabel *accountName;
@property (weak, nonatomic) IBOutlet UILabel *accountType;
@property (weak, nonatomic) IBOutlet UILabel *bankBranch;

@end

