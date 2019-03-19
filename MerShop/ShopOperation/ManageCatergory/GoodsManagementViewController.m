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

@end

@implementation GoodsManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"商品管理"];
    self.titleArr = @[@"热销",@"特色套餐",@"单人套餐",@"米饭",@"主食类",@"精美小吃",@"汤类",@"饮料",@"其他"];
    [self setUI];
    
}

- (void)setUI{
    _btnArr = [NSMutableArray arrayWithCapacity:0];
    
    _leftScrollView = [[UIScrollView alloc]init];
    [_leftScrollView setFrame:XFrame(0, ViewStart_Y, IFAutoFitPx(200), Screen_H-ViewStart_Y-IFAutoFitPx(108))];
    [_leftScrollView setContentSize:CGSizeMake(IFAutoFitPx(200), IFAutoFitPx(96)*_titleArr.count)];
    [_leftScrollView setBackgroundColor:LineColor];
    [_leftScrollView setDelegate:self];
    [_leftScrollView setScrollEnabled:YES];
    [self.view addSubview:_leftScrollView];
    
    _mainTable = [[UITableView alloc]init];
    [_mainTable setFrame:XFrame(CGRectGetMaxX(_leftScrollView.frame), ViewStart_Y, Screen_W-IFAutoFitPx(200), Screen_H-ViewStart_Y-IFAutoFitPx(108))];
    [_mainTable setBackgroundColor:[UIColor whiteColor]];
    [_mainTable setTableFooterView:[[UIView alloc]init]];
    [_mainTable setDelegate:self];
    [_mainTable setDataSource:self];
    [self.view addSubview:_mainTable];
    
    for (NSInteger i = 0;i <_titleArr.count; i++){
        UIButton *leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [leftBtn setTag:i];
        [leftBtn.titleLabel setFont:XFont(16)];
        [leftBtn setFrame:XFrame(IFAutoFitPx(6), i*IFAutoFitPx(96), ButtonWidth, IFAutoFitPx(96))];
        [leftBtn setTitle:[_titleArr objectAtIndex:i] forState:(UIControlStateNormal)];
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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
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
    return cell;
}

@end
