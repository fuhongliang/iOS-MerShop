//
//  Registview.h
//  MerShop
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol RegistviewDelegate <NSObject>

- (void)getCode;
- (void)protocol;
- (void)registUser;
- (void)goBack;

@end

@interface Registview : UIView
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UITextField *verificationCode;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic)id<RegistviewDelegate>delegate;
- (IBAction)getCodeAction:(id)sender;
- (IBAction)protocolAction:(id)sender;
- (IBAction)registerAction:(id)sender;
- (IBAction)backAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
