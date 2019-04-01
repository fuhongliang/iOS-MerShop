//
//  refuseView.h
//  MerShop
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol refuseViewDelegate <NSObject>

- (void)refuseMethod:(UIButton *)sender;

@end

@interface refuseView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

- (IBAction)refuseBtn1:(id)sender;
- (IBAction)refusuBtn2:(id)sender;
- (IBAction)refuseBtn3:(id)sender;
- (IBAction)cancelBtn:(id)sender;
@property (weak ,nonatomic)id<refuseViewDelegate>delegate;

@end


