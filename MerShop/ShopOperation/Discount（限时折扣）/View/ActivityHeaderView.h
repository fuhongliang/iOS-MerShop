//
//  ActivityHeaderView.h
//  MerShop
//
//  Created by mac on 2019/4/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActivityHeaderViewDelegate <NSObject>

- (void)addNumber;
- (void)reduceNumber;
- (void)showPickerView:(NSString *)data;
@end

@interface ActivityHeaderView : UIView
@property (weak, nonatomic) IBOutlet UITextField *markText;
@property (weak, nonatomic) IBOutlet UITextField *activityNameText;
@property (weak, nonatomic) IBOutlet UITextField *descText;
@property (weak, nonatomic) IBOutlet UIButton *startTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *endTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;
@property (weak, nonatomic)id<ActivityHeaderViewDelegate>delegate;
- (IBAction)reduce:(id)sender;
- (IBAction)add:(id)sender;
- (IBAction)startAction:(id)sender;
- (IBAction)endAction:(id)sender;

@end

