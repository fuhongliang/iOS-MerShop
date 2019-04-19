//
//  FullReductionFootView.h
//  MerShop
//
//  Created by mac on 2019/4/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FullReductionFootViewDelegate <NSObject>

- (void)addFullReduction;
- (void)submit;

@end

@interface FullReductionFootView : UIView
@property (weak, nonatomic) IBOutlet UITextField *priceText1;
@property (weak, nonatomic) IBOutlet UITextField *priceText2;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UITextField *remarkText;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic)id<FullReductionFootViewDelegate>delegate;
- (IBAction)addAction:(id)sender;
- (IBAction)submitAction:(id)sender;

@end

