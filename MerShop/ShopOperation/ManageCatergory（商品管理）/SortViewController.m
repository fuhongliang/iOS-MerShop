//
//  SortViewController.m
//  MerShop
//
//  Created by mac on 2019/3/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SortViewController.h"
#import "SortTableViewCell.h"
#import "JXMovableCellTableView.h"
#import "PhoneNumberView.h"

@interface SortViewController ()<UITableViewDelegate,UITableViewDataSource,JXMovableCellTableViewDelegate,JXMovableCellTableViewDataSource,SortTableViewCellDelegate,PhoneNumberViewDelegate>
@property (nonatomic ,strong)JXMovableCellTableView *mainTableview;
@property (nonatomic ,strong)NSMutableArray *dataSource;
@property (nonatomic ,copy)NSDictionary *removeCurrentDict;
@property (nonatomic ,assign)NSInteger currentIndex;
@property (nonatomic ,assign)NSInteger storeID;
@property (nonatomic ,strong)UIView *clearView;
@property (nonatomic ,strong)PhoneNumberView *upView;
@property (nonatomic ,assign)NSInteger deleteIndex;
@property (nonatomic ,strong)NSMutableArray *classIdArr;
@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"管理分类"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSArray *arr = [user objectForKey:@"classArray"];
    _storeID = [[[user objectForKey:@"userInfo"] objectForKey:@"store_id"] integerValue];
    [self.dataSource addObjectsFromArray:arr];
    //刚开始进来把分类ID 添加到数组里边
    for (NSDictionary *dict in self.dataSource){
        [self.classIdArr addObject:[dict objectForKey:@"stc_id"]];//替换后的分类ID顺序
    }
    NSLog(@"%@",self.dataSource);
    [self.mainTableview reloadData];
    [self setUI];
}

- (void)setUI{
    _mainTableview = [[JXMovableCellTableView alloc]init];
    [_mainTableview setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [_mainTableview setBackgroundColor:LineColor];
    _mainTableview.delegate = self;
    _mainTableview.dataSource = self;
    _mainTableview.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_mainTableview];
    _mainTableview.longPressGesture.minimumPressDuration = 1.0;
    
    _clearView = [[UIView alloc]initWithFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [_clearView setBackgroundColor:BlackColor];
    [_clearView setAlpha:0.5];
    [_clearView setHidden:YES];
    [self.view addSubview:_clearView];
    
    _upView = [[PhoneNumberView alloc]init];
    [_upView setFrame:XFrame(IFAutoFitPx(96), IFAutoFitPx(456)+ViewStart_Y, IFAutoFitPx(560), IFAutoFitPx(292))];
    _upView.layer.cornerRadius = IFAutoFitPx(8);
    [_upView setViewTitle:@"是否删除此分类" subTitle:@"该分类所有商品将会被删除" cancel:@"取消" ensure:@"确定"];
    _upView.layer.masksToBounds = YES;
    _upView.delegate = self;
    [_upView setBackgroundColor:[UIColor whiteColor]];
    [_upView setHidden:YES];
    [self.view addSubview:_upView];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"保存" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(saveSort) forControlEvents:(UIControlEventTouchUpInside)];
    [btn.titleLabel setFont:XFont(18)];
    [btn setBackgroundColor:IFThemeBlueColor];
    [btn setTitleColor:WhiteColor forState:(UIControlStateNormal)];
    [self.navigationView addSubview:btn];
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.top).offset(StatusBar_H);
        make.right.equalTo(self.navigationView.right).offset(-15);
        make.bottom.equalTo(self.navigationView.bottom).offset(0);
    }];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
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
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"classArray"];
    NSString *className = [arr[indexPath.row] objectForKey:@"stc_name"];
    cell.className.text = className;
    cell.delegate = self;
    cell.tag = indexPath.row;
    return cell;
    
}

#pragma mark - SortTableViewCellDelegate
- (void)deleteAction:(id)data{
    [_clearView setHidden:NO];
    [_upView setHidden:NO];
    SortTableViewCell *cell = (SortTableViewCell *)data;
    _deleteIndex = cell.tag;
}

- (void)cancelCall:(UIButton *)sender{
    [_clearView setHidden:YES];
    [_upView setHidden:YES];
}

- (void)playCall:(UIButton *)sender{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSInteger classID = [[[self.dataSource objectAtIndex:_deleteIndex] objectForKey:@"stc_id"] integerValue];
    NSInteger storeID = [[[user objectForKey:@"userInfo"] objectForKey:@"store_id"] integerValue];;

    __weak typeof(self) weakself = self;
    [Http_url POST:@"del_goods_class" dict:@{@"class_id":@(classID),@"store_id":@(storeID)} showHUD:YES WithSuccessBlock:^(id data) {
        if ([[data objectForKey:@"code"] integerValue] == 200){
            [weakself.classIdArr removeAllObjects];//删除原来的ID ，防止重复添加
            [weakself.dataSource removeObjectAtIndex:weakself.deleteIndex];
            [user setObject:weakself.dataSource forKey:@"classArray"];
            for (NSDictionary *dict in self.dataSource){
                [weakself.classIdArr addObject:[dict objectForKey:@"stc_id"]];
            }
            [weakself.mainTableview reloadData];
            [weakself.clearView setHidden:YES];
            [weakself.upView setHidden:YES];
        }
    } WithFailBlock:^(id data) {
        
    }];

}


- (void)topAction:(id)data{
    [self.classIdArr removeAllObjects];
    SortTableViewCell *cell = (SortTableViewCell *)data;
    NSDictionary *dict = [self.dataSource objectAtIndex:cell.tag];
    [self.dataSource removeObjectAtIndex:cell.tag];
    [self.dataSource insertObject:dict atIndex:0];
    for (NSDictionary *dict in self.dataSource){
        [self.classIdArr addObject:[dict objectForKey:@"stc_id"]];//替换后的分类ID顺序
    }
    NSDictionary *prama = @{@"class_ids":[self objectToJson:self.classIdArr],
                            @"store_id":@(_storeID)
                            };
    [Http_url POST:@"sort_goods_class" dict:prama showHUD:NO WithSuccessBlock:^(id data) {
        if ([[data objectForKey:@"code"] integerValue] == 200){
            [[NSUserDefaults standardUserDefaults] setObject:self.dataSource forKey:@"classArray"];
            [self.mainTableview reloadData];
        }
    } WithFailBlock:^(id data) {
        
    }];
}

- (void)requestSort:(NSDictionary *)prama{
    [Http_url POST:@"sort_goods_class" dict:prama showHUD:NO WithSuccessBlock:^(id data) {
        if ([[data objectForKey:@"code"] integerValue] == 200){
            [[NSUserDefaults standardUserDefaults] setObject:self.dataSource forKey:@"classArray"];
            [[IFUtils share]showErrorInfo:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } WithFailBlock:^(id data) {
        
    }];

}

-(NSString *)objectToJson:(id)obj{
    if (obj == nil) {
        return nil;
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                       options:0
                                                         error:&error];
    
    if ([jsonData length] && error == nil){
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else{
        return nil;
    }
}

#pragma mark - JXMovableCellTableViewDelegate

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(JXMovableCellTableView *)tableView endMoveCellAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    [self.classIdArr removeAllObjects];
    [self.dataSource removeObjectAtIndex:self.currentIndex];
    [self.dataSource insertObject:self.removeCurrentDict atIndex:indexPath.row];
    NSLog(@"%@",self.dataSource);
    for (NSDictionary *dict in self.dataSource){
        [self.classIdArr addObject:[dict objectForKey:@"stc_id"]];//替换后的分类ID顺序
    }

}

- (void)tableView:(JXMovableCellTableView *)tableView willMoveCellAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    self.currentIndex = indexPath.row;
    self.removeCurrentDict = [self.dataSource objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)tableView:(JXMovableCellTableView *)tableView customizeMovalbeCell:(UIImageView *)movableCellsnapshot {
    movableCellsnapshot.layer.shadowColor = [UIColor redColor].CGColor;
    movableCellsnapshot.layer.masksToBounds = NO;
    movableCellsnapshot.layer.cornerRadius = 0;
    movableCellsnapshot.layer.shadowOffset = CGSizeMake(0, 0);
    movableCellsnapshot.layer.shadowOpacity = 0.4;
    movableCellsnapshot.layer.shadowRadius = 10;
}

- (void)tableView:(JXMovableCellTableView *)tableView customizeStartMovingAnimation:(UIImageView *)movableCellsnapshot fingerPoint:(CGPoint)fingerPoint {
    //move to finger
    [UIView animateWithDuration:0.25 animations:^{
        movableCellsnapshot.center = CGPointMake(movableCellsnapshot.center.x, fingerPoint.y);
    }];
    
}

/**
    保存排序方法
 */
- (void)saveSort{
    NSDictionary *prama = @{@"class_ids":[self objectToJson:self.classIdArr],
                            @"store_id":@(_storeID)
                            };
    [self requestSort:prama];
}

- (NSMutableArray *)dataSource{
    if (!_dataSource){
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
- (NSMutableArray *)classIdArr{
    if (!_classIdArr){
        _classIdArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _classIdArr;
}
@end
