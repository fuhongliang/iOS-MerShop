//
//  TimePickerView.m
//  MerShop
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TimePickerView.h"

@interface TimePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic ,strong)NSMutableArray *dataSource;
@property (nonatomic ,copy)NSString *selectTitle;

@end
@implementation TimePickerView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
   self = [super initWithCoder:aDecoder];
    if (self){
        
    }
    return self;
}

- (IBAction)cancelAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancel)]){
        [self.delegate performSelector:@selector(cancel) withObject:nil];
    }
}

- (IBAction)ensureAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(ensure:)]){
        [self.delegate performSelector:@selector(ensure:) withObject:_selectTitle];
    }
}

- (void)setTitleStr:(NSString *)titleStr{
    self.title.text = titleStr;
}

- (void)setData:(NSArray *)data{
    [self.dataSource addObjectsFromArray:data];
    _selectTitle = [NSString stringWithFormat:@"%@",[self.dataSource[0] objectForKey:@"voucher_price"]];
}

#pragma mark - UIPickerViewDelegate and UIPickerViewDataSource
/// UIPickerView返回多少组
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

/// UIPickerView返回每组多少条数据
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return  self.dataSource.count;
}
/// UIPickerView每一行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = [NSString stringWithFormat:@"%@",[[self.dataSource objectAtIndex:row] objectForKey:@"voucher_price"]];
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selectTitle = [NSString stringWithFormat:@"%@",[[self.dataSource objectAtIndex:row] objectForKey:@"voucher_price"]];
}


- (NSMutableArray *)dataSource{
    if (!_dataSource){
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

@end
