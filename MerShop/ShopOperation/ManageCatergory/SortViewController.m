//
//  SortViewController.m
//  MerShop
//
//  Created by mac on 2019/3/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SortViewController.h"
#import "SortTableViewCell.h"

@interface SortViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *mainTableview;
@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"管理分类"];
    [self setUI];
}

- (void)setUI{
    _mainTableview = [[UITableView alloc]init];
    [_mainTableview setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [_mainTableview setBackgroundColor:LineColor];
    _mainTableview.delegate = self;
    _mainTableview.dataSource = self;
    _mainTableview.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_mainTableview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SortTableViewCell *cell = (SortTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SortTableViewCell"];
    if (!cell){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SortTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    return cell;
    
}
@end
