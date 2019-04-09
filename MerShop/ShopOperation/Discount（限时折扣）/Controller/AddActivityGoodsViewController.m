//
//  AddActivityGoodsViewController.m
//  MerShop
//
//  Created by mac on 2019/4/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AddActivityGoodsViewController.h"
#import "GoodsModel.h"
#import "AddGoodsTableViewCell.h"

#define ButtonWidth     IFAutoFitPx(194)

@interface AddActivityGoodsViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)NSMutableArray *btnArr;
@property (nonatomic ,strong)UIScrollView *leftScrollView;
@property (nonatomic ,strong)NSMutableArray *leftDataSource;
@property (nonatomic ,strong)NSMutableArray *rightDataSource;
@property (nonatomic ,strong)UITableView *mainTable;
@property (nonatomic ,strong)UIView *leftView;
@property (nonatomic ,assign)NSInteger storeId;
@property (nonatomic ,assign)NSInteger index;


@end

@implementation AddActivityGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"添加商品"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [userDefaults objectForKey:@"userInfo"];
    _storeId = [[userInfo objectForKey:@"store_id"] integerValue];
    [self requestCatergory];
    [self requestGoods:0];
    [self setRightUI];
    
}

- (void)setRightUI{
    _mainTable = [[UITableView alloc]init];
    [_mainTable setFrame:XFrame(IFAutoFitPx(200), ViewStart_Y, Screen_W-IFAutoFitPx(200), Screen_H-ViewStart_Y-IFAutoFitPx(88))];
    [_mainTable setBackgroundColor:[UIColor whiteColor]];
    [_mainTable setTableFooterView:[[UIView alloc]init]];
    [_mainTable setDelegate:self];
    [_mainTable setDataSource:self];
    [_mainTable setRowHeight:UITableViewAutomaticDimension];
    
    UIView *view = [[UIView alloc]init];
    [view setFrame:XFrame(0, 0, Screen_W-IFAutoFitPx(200), IFAutoFitPx(88))];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *headerTitle = [[UILabel alloc]init];
    [headerTitle setFrame:XFrame(IFAutoFitPx(30), IFAutoFitPx(10), Screen_W-IFAutoFitPx(200), IFAutoFitPx(68))];
    [headerTitle setText:@"选择商品/修改折扣价"];
    [headerTitle setTextColor:toPCcolor(@"#808080")];
    [headerTitle setFont:XFont(14)];
    [view addSubview:headerTitle];
    [_mainTable setTableHeaderView:view];
    [self.view addSubview:self.mainTable];
    
    UIButton *finishBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [finishBtn setFrame:XFrame(0, CGRectGetMaxY(_mainTable.frame), Screen_W, IFAutoFitPx(88))];
    [finishBtn setBackgroundColor:toPCcolor(@"#1C98F6")];
    [finishBtn setTitle:@"完成" forState:(UIControlStateNormal)];
    [self.view addSubview:finishBtn];
    
}
- (void)setLeftUI{
    _btnArr = [NSMutableArray arrayWithCapacity:0];
    
    _leftScrollView = [[UIScrollView alloc]init];
    [_leftScrollView setFrame:XFrame(0, ViewStart_Y, IFAutoFitPx(200), Screen_H-ViewStart_Y-IFAutoFitPx(88))];
    [_leftScrollView setContentSize:CGSizeMake(IFAutoFitPx(200), IFAutoFitPx(96)*_leftDataSource.count)];
    [_leftScrollView setBackgroundColor:LineColor];
    [_leftScrollView setDelegate:self];
    [_leftScrollView setScrollEnabled:YES];
    [self.view addSubview:_leftScrollView];
    
    
    for (NSInteger i = 0;i <_leftDataSource.count; i++){
        UIButton *leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [leftBtn setTag:i];
        [leftBtn.titleLabel setFont:XFont(16)];
        [leftBtn setFrame:XFrame(IFAutoFitPx(6), i*IFAutoFitPx(96), ButtonWidth, IFAutoFitPx(96))];
        NSString *title = [[_leftDataSource objectAtIndex:i] objectForKey:@"stc_name"];
        [leftBtn setTitle:title forState:(UIControlStateNormal)];
        [leftBtn setTitleColor:GrayColor forState:(UIControlStateNormal)];
        [leftBtn.titleLabel setTextAlignment:(NSTextAlignmentCenter)];
        [leftBtn addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        if(i == 0){
            [leftBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [leftBtn setBackgroundColor:[UIColor whiteColor]];
            _leftView = [[UIView alloc]init];
            [_leftView setFrame:XFrame(0, 0, IFAutoFitPx(6), IFAutoFitPx(96))];
            [_leftView setBackgroundColor:IFThemeBlueColor];
            [_leftScrollView addSubview:_leftView];
            
        }
        [_btnArr addObject:leftBtn];
        [_leftScrollView addSubview:leftBtn];
    }
}

- (void)requestCatergory{
    [self.leftDataSource removeAllObjects];
    [Http_url POST:@"goods_class_list" dict:@{@"store_id":@(_storeId)} showHUD:YES WithSuccessBlock:^(id data) {
        NSLog(@"获取成功");
        NSArray *arr = [data objectForKey:@"data"];
        if (arr.count == 0){
            [self.leftScrollView setHidden:YES];
        }else{
            [self.leftScrollView setHidden:NO];
            [self.leftDataSource addObjectsFromArray:arr];
            [self setLeftUI];
        }
        
    } WithFailBlock:^(id data) {
        
    }];
}

- (void)requestGoods:(NSInteger )classId{
    [self.rightDataSource removeAllObjects];
    [Http_url POST:@"goods_list" dict:@{@"store_id":@(_storeId),@"class_id":@(classId)} showHUD:YES WithSuccessBlock:^(id data) {
        NSLog(@"获取成功");
        NSArray *arr = [[data objectForKey:@"data"] objectForKey:@"goods_list"];
        if (![arr isKindOfClass:[NSNull class]]){
            for (NSDictionary *dict in arr){
                GoodsModel *model = [[GoodsModel alloc]initWithDictionary:dict error:nil];
                [self.rightDataSource addObject:model];
            }
            [self.mainTable reloadData];
        }else{
            
        }
        
    } WithFailBlock:^(id data) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rightDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddGoodsTableViewCell *cell = (AddGoodsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AddGoodsTableViewCell"];
    if (!cell){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AddGoodsTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell setDataWithModel];
    return cell;
}

- (void)clickBtn:(UIButton *)sender{
    _index = sender.tag;
    for (UIButton *btn in _btnArr){
        if (btn.tag == _index){
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [btn setBackgroundColor:[UIColor whiteColor]];
            [_leftView setFrame:XFrame(0, IFAutoFitPx(96)*_index, IFAutoFitPx(6), IFAutoFitPx(96))];
        }else{
            [btn setTitleColor:GrayColor forState:(UIControlStateNormal)];
            [btn setBackgroundColor:LineColor];
        }
    }
    NSDictionary *classDict = self.leftDataSource[_index];
    if(classDict != nil){
        NSInteger classID = [[classDict objectForKey:@"stc_id"] integerValue];
        [self requestGoods:classID];
    }

}

#define mark - 懒加载
- (NSMutableArray *)leftDataSource{
    if (!_leftDataSource){
        _leftDataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _leftDataSource;
}

- (NSMutableArray *)rightDataSource{
    if (!_rightDataSource){
        _rightDataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _rightDataSource;
}

@end
