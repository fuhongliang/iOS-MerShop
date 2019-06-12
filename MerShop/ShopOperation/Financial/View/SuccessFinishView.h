//
//  SuccessFinishView.h
//  MerShop
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SuccessFinishViewDelegate <NSObject>

- (void)back;

@end

@interface SuccessFinishView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic ,copy)NSDictionary *titleDict;
@property (weak, nonatomic)id<SuccessFinishViewDelegate>delegate;
- (IBAction)backAction:(id)sender;

@end

