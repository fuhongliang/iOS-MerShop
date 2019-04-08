//
//  NoImageTableViewCell.h
//  MerShop
//
//  Created by mac on 2019/3/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NoImageTableViewCellDelegate <NSObject>

- (void)replyComment:(NSString *)index;

@end

@interface NoImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *comment;
- (IBAction)replyBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UIImageView *star5;
@property (weak, nonatomic) IBOutlet UILabel *taste;
@property (weak, nonatomic) IBOutlet UILabel *packing;
@property (weak, nonatomic) IBOutlet UILabel *delivery;

@property (weak, nonatomic)id<NoImageTableViewCellDelegate>delegate;
@property (nonatomic ,copy)NSString *indexPathRow;
- (void)addCommentData:(NSDictionary *)dict Index:(NSString *)index;

@end

