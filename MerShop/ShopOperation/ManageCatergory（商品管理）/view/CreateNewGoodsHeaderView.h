//
//  CreateNewGoodsHeaderView.h
//  MerShop
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CreateNewGoodsHeaderViewDelegate <NSObject>

- (void)goAlbum;

@end

@interface CreateNewGoodsHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UIButton *btnText;
@property (weak, nonatomic) IBOutlet UIButton *btnImg;
@property (weak, nonatomic)id<CreateNewGoodsHeaderViewDelegate>delegate;
- (IBAction)imageTap:(id)sender;
- (IBAction)chooseImg:(id)sender;
- (IBAction)chooseImage:(id)sender;

@end

