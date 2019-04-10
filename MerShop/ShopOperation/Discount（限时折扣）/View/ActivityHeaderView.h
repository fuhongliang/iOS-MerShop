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

@end

@interface ActivityHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;
@property (weak, nonatomic)id<ActivityHeaderViewDelegate>delegate;
- (IBAction)reduce:(id)sender;
- (IBAction)add:(id)sender;

@end

