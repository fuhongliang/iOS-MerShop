//
//  SortTableViewCell.h
//  MerShop
//
//  Created by mac on 2019/3/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SortTableViewCellDelegate <NSObject>

- (void)deleteAction:(id)data;
- (void)topAction:(id)data;

@end

@interface SortTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *className;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *topBtn;
@property (weak, nonatomic)id<SortTableViewCellDelegate>delegate;

- (IBAction)deleteBtn:(id)sender;

- (IBAction)topBtn:(id)sender;

@end

