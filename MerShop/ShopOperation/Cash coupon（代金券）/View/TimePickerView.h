//
//  TimePickerView.h
//  MerShop
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimePickerViewDelegate <NSObject>

- (void)cancel;
- (void)ensure:(id)data;

@end

@interface TimePickerView : UIView
@property (weak, nonatomic) IBOutlet UILabel *title;
- (IBAction)cancelAction:(id)sender;
- (IBAction)ensureAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic)id<TimePickerViewDelegate>delegate;
@property (copy, nonatomic) NSArray *data;
@property (nonatomic ,copy)NSString *titleStr;

@end

