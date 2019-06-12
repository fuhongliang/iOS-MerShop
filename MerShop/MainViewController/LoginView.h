//
//  LoginView.h
//  MerShop
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoginViewDelegate <NSObject>

- (void)login;
- (void)protocol;
- (void)registerUser;

@end

@interface LoginView : UIView
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *passWordText;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic)id<LoginViewDelegate>delegate;
- (IBAction)protocolAction:(id)sender;
- (IBAction)loginAction:(id)sender;
- (IBAction)registerAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
