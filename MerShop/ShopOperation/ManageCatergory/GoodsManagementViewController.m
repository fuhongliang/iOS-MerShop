//
//  GoodsManagementViewController.m
//  MerShop
//
//  Created by mac on 2019/3/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "GoodsManagementViewController.h"
#import "GoodsTableViewCell.h"
#import "ManageCatergoryViewController.h"
#import "CreateNewGoodsViewController.h"
#import "GoodsModel.h"


#define ButtonWidth     IFAutoFitPx(194)

@interface GoodsManagementViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UIScrollView *leftScrollView;
@property (nonatomic ,strong)UITableView *mainTable;
@property (nonatomic ,strong)UIView *leftView;
@property (nonatomic ,strong)NSMutableArray *btnArr;
@property (nonatomic ,strong)NSArray *titleArr;
@property (nonatomic ,assign)NSInteger index;
@property (nonatomic ,strong)UIButton *bottomBtn1;
@property (nonatomic ,strong)UIButton *bottomBtn2;
@property (nonatomic ,assign)NSInteger storeId;
@property (nonatomic ,strong)NSMutableArray *leftDataSource;
@property (nonatomic ,strong)NSMutableArray *rightDataSource;

@end

@implementation GoodsManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"商品管理"];
    self.titleArr = @[@"热销",@"特色套餐",@"单人套餐",@"米饭",@"主食类",@"精美小吃",@"汤类",@"饮料",@"其他"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [userDefaults objectForKey:@"userInfo"];
    _storeId = [[userInfo objectForKey:@"store_id"] integerValue];
    [self setRightUI];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestCatergory];
    [self requestGoods:0];
}

- (void)requestCatergory{
    [self.leftDataSource removeAllObjects];
    [Http_url POST:@"goods_class_list" dict:@{@"store_id":@(_storeId)} showHUD:YES WithSuccessBlock:^(id data) {
        NSLog(@"获取成功");
        NSArray *arr = [data objectForKey:@"data"];
        [self.leftDataSource addObjectsFromArray:arr];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:arr forKey:@"classArray"];
        [user synchronize];
        [self setLeftUI];
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

- (void)setRightUI{
    _mainTable = [[UITableView alloc]init];
    [_mainTable setFrame:XFrame(IFAutoFitPx(200), ViewStart_Y, Screen_W-IFAutoFitPx(200), Screen_H-ViewStart_Y-IFAutoFitPx(108))];
    [_mainTable setBackgroundColor:[UIColor whiteColor]];
    [_mainTable setTableFooterView:[[UIView alloc]init]];
    [_mainTable setDelegate:self];
    [_mainTable setDataSource:self];
    [self.view addSubview:_mainTable];
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:XFrame(0, CGRectGetMaxY(_mainTable.frame), Screen_W, IFAutoFitPx(108))];
    [backgroundView setBackgroundColor:[UIColor whiteColor]];
    XViewLayerCB(backgroundView, 0, 0.5, LineColor);
    [self.view addSubview:backgroundView];
    
    
    _bottomBtn1  = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_bottomBtn1 setFrame:XFrame(IFAutoFitPx(30), IFAutoFitPx(14), (Screen_W-IFAutoFitPx(90))/2, IFAutoFitPx(80))];
    [_bottomBtn1 setTitle:@"管理分类" forState:(UIControlStateNormal)];
    [_bottomBtn1 setImage:[UIImage imageNamed:@"editmenu_glfl"] forState:(UIControlStateNormal)];
    [_bottomBtn1.titleLabel setFont:XFont(17)];
    [_bottomBtn1 setTitleColor:BlackColor forState:(UIControlStateNormal)];
    [_bottomBtn1 addTarget:self action:@selector(goManage) forControlEvents:(UIControlEventTouchUpInside)];
    XViewLayerCB(_bottomBtn1, 3, 0.5, LineColor);
    [backgroundView addSubview:_bottomBtn1];
    
    _bottomBtn2  = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_bottomBtn2 setFrame:XFrame(IFAutoFitPx(30)+CGRectGetMaxX(_bottomBtn1.frame), IFAutoFitPx(14), (Screen_W-IFAutoFitPx(90))/2, IFAutoFitPx(80))];
    [_bottomBtn2 setTitle:@"新建商品" forState:(UIControlStateNormal)];
    [_bottomBtn2 setImage:[UIImage imageNamed:@"editmenu_add"] forState:(UIControlStateNormal)];
    [_bottomBtn2.titleLabel setFont:XFont(17)];
    [_bottomBtn2 setTitleColor:BlackColor forState:(UIControlStateNormal)];
    XViewLayerCB(_bottomBtn2, 3, 0.5, LineColor);
    [_bottomBtn2 addTarget:self action:@selector(goCreateNewGoodsVC) forControlEvents:(UIControlEventTouchUpInside)];
    [backgroundView addSubview:_bottomBtn2];
    
}

- (void)setLeftUI{
    _btnArr = [NSMutableArray arrayWithCapacity:0];
    
    _leftScrollView = [[UIScrollView alloc]init];
    [_leftScrollView setFrame:XFrame(0, ViewStart_Y, IFAutoFitPx(200), Screen_H-ViewStart_Y-IFAutoFitPx(108))];
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

- (void)goManage{
    ManageCatergoryViewController *vc = [[ManageCatergoryViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goCreateNewGoodsVC{
    CreateNewGoodsViewController *VC = [[CreateNewGoodsViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rightDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 106;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsTableViewCell *cell = (GoodsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"GoodsTableViewCell"];
    if (!cell){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"GoodsTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    GoodsModel *model = self.rightDataSource[indexPath.row];
    [cell setDataWithModel:model];
    return cell;
}

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
