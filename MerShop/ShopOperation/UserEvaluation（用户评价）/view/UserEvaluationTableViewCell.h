//
//  UserEvaluationTableViewCell.h
//  MerShop
//
//  Created by mac on 2019/3/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UserEvaluationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *taste;
@property (weak, nonatomic) IBOutlet UILabel *packing;
@property (weak, nonatomic) IBOutlet UILabel *delivery;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UIImageView *star5;

- (IBAction)replyBtn:(id)sender;

- (void)addCommentData:(NSDictionary *)data Index:(NSString *)index;

@end

