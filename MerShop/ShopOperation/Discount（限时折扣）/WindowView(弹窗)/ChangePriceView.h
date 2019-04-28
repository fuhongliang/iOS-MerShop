//
//  ChangePriceView.h
//  MerShop
//
//  Created by mac on 2019/4/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangePriceViewDelegate <NSObject>

- (void)submitData;

@end

@interface ChangePriceView : UIView
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UITextField *discountPrice;
@property (weak, nonatomic)id<ChangePriceViewDelegate>delegate;
- (IBAction)submitAction:(id)sender;

@end

