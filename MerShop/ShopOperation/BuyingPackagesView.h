//
//  BuyingPackagesView.h
//  MerShop
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BuyingPackagesViewDelegate <NSObject>

- (void)cancel;
- (void)ensure;

@end

@interface BuyingPackagesView : UIView
@property (weak, nonatomic) IBOutlet UITextField *numberText;
@property (weak, nonatomic)id<BuyingPackagesViewDelegate>delegate;
- (IBAction)cancelAction:(id)sender;
- (IBAction)ensureAction:(id)sender;

@end

