//
//  FullReductionHeadView.h
//  MerShop
//
//  Created by mac on 2019/4/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FullReductionHeadViewDelegate <NSObject>

- (void)showDatePickerView:(NSString *)data;

@end

@interface FullReductionHeadView : UIView
@property (weak, nonatomic) IBOutlet UITextField *activityText;
@property (weak, nonatomic) IBOutlet UIButton *startTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *endTimeBtn;
@property (weak, nonatomic)id<FullReductionHeadViewDelegate>delegate;
- (IBAction)startClick:(id)sender;
- (IBAction)endClick:(id)sender;

@end

