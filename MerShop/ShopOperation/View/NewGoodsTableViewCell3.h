//
//  NewGoodsTableViewCell3.h
//  MerShop
//
//  Created by mac on 2019/3/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewGoodsTableViewCell3Delegate <NSObject>

- (void)open:(NSString *)data;

@end

@interface NewGoodsTableViewCell3 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UISwitch *kaiguan;
@property (weak, nonatomic)id<NewGoodsTableViewCell3Delegate>delegate;
- (IBAction)openOrclose:(id)sender;

@end

