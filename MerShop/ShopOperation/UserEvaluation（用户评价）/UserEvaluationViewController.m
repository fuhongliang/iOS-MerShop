//
//  UserEvaluationViewController.m
//  MerShop
//
//  Created by mac on 2019/3/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UserEvaluationViewController.h"
#import "UserEvaluationTableViewCell.h"
#import "UserEvaluationTableViewCell1.h"
#import "NoImageTableViewCell.h"
#import "NoImageWithReplyTableViewCell.h"
#import "HeaderView1.h"

@interface UserEvaluationViewController ()<UITableViewDelegate,UITableViewDataSource,NoImageTableViewCellDelegate>

@property (nonatomic ,strong)UIView *topBackgroundView;

@property (nonatomic ,strong)UITableView *mainTableview;

@property (nonatomic ,strong)UIView *lineView;

@property (nonatomic ,strong)NSMutableArray *btnArr;

@property (nonatomic ,assign)NSInteger currentIndex;

@property (nonatomic ,strong)UILabel *goodComment;

@property (nonatomic ,strong)NSMutableArray *dataSource;

@property (nonatomic ,copy)NSDictionary *goodCommentsRateDict;
@property (nonatomic ,copy)NSString *allComments;
@property (nonatomic ,copy)NSString *goodComments;
@property (nonatomic ,copy)NSString *normalComments;
@property (nonatomic ,copy)NSString *badComments;

@property (nonatomic ,strong)UIView *replyView;
@property (nonatomic ,strong)UIView *bottomReplyWhiteView;
@property (nonatomic ,strong)UITextField *replyText;
@property (nonatomic ,assign)NSInteger commentId;

@property (nonatomic ,strong)UILabel *goodCommentRate;
@property (nonatomic ,strong)UIButton *btn2;
@property (nonatomic ,strong)UIButton *btn3;
@property (nonatomic ,strong)UIButton *btn4;


@end

@implementation UserEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"用户评价"];
    [self requestData];
    [self setUI];

}

- (void)requestData{
    NSInteger storeId = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"] objectForKey:@"store_id"] integerValue];
    [Http_url POST:@"get_store_com" dict:@{@"store_id":@(storeId)} showHUD:YES WithSuccessBlock:^(id data) {
        NSInteger code = [[data objectForKey:@"code"] integerValue];
        NSDictionary *dict = [data objectForKey:@"data"];
        if (code == 200){
            self.goodCommentsRateDict = [dict objectForKey:@"haoping"];
            [self setDataWithDict:self.goodCommentsRateDict];
            NSArray *arr = [dict objectForKey:@"com_list"];
            if (kISNullArray(arr)){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EmptyDiscountView" owner:self options:nil];
                EmptyDiscountView *emptyView = [nib objectAtIndex:0];
                [emptyView setArray:@[@"pingjia_queshengye",@"暂无评价"]];
                [emptyView setFrame:XFrame(0, 0, Screen_W, Screen_H-ViewStart_Y-IFAutoFitPx(183))];
                [self.mainTableview setTableHeaderView:emptyView];
            }else{
                for (NSDictionary *dict in arr){
                    [self.dataSource addObject:dict];
                }
                [self.mainTableview reloadData];

            }
        }
    } WithFailBlock:^(id data) {
        
    }];
}

- (void)requestNoReplyData{
    NSInteger storeId = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"] objectForKey:@"store_id"] integerValue];
    NSDictionary *dict;
    if (_currentIndex == 0){
        dict =@{@"store_id":@(storeId)};
    }else{
        dict =@{@"store_id":@(storeId),
                @"no_com":@(1)
                };
    }
    
    [Http_url POST:@"get_store_com" dict:dict showHUD:YES WithSuccessBlock:^(id data) {
        NSInteger code = [[data objectForKey:@"code"] integerValue];
        NSDictionary *dict = [data objectForKey:@"data"];
        NSLog(@"%@",dict);
        [self.dataSource removeAllObjects];
        if (code == 200){
            NSArray *arr = [dict objectForKey:@"com_list"];
            if (kISNullArray(arr)){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EmptyDiscountView" owner:self options:nil];
                EmptyDiscountView *emptyView = [nib objectAtIndex:0];
                [emptyView setArray:@[@"pingjia_queshengye",@"暂无评价"]];
                [emptyView setFrame:XFrame(0, 0, Screen_W, Screen_H-ViewStart_Y-IFAutoFitPx(183))];
                [self.mainTableview setTableHeaderView:emptyView];
                [self.mainTableview reloadData];
            }else{
                for (NSDictionary *dict in arr){
                    [self.dataSource addObject:dict];
                }
                [self.mainTableview setTableHeaderView:[[UIView alloc] init]];
                [self.mainTableview reloadData];
            }

        }
    } WithFailBlock:^(id data) {
        
    }];
}

- (void)setUI{
    UIView *topView = [self setHeaderview:self.goodCommentsRateDict];
    [topView setFrame:XFrame(0, ViewStart_Y, Screen_W, IFAutoFitPx(183))];
    [self.view addSubview:topView];
    
    _mainTableview = [[UITableView alloc]init];
    [_mainTableview setFrame:XFrame(0, ViewStart_Y+IFAutoFitPx(183), Screen_W, Screen_H-ViewStart_Y-IFAutoFitPx(183))];
    [_mainTableview setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [_mainTableview setBackgroundColor:LineColor];
    [_mainTableview setRowHeight:UITableViewAutomaticDimension];
    _mainTableview.delegate = self;
    _mainTableview.dataSource = self;
    [self.view addSubview:_mainTableview];
    
    _replyView = [[UIView alloc]init];
    [_replyView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [_replyView setBackgroundColor:BlackColor];
    [_replyView setAlpha:0.3];
    [_replyView setHidden:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(hide)];
    [_replyView addGestureRecognizer:tap];
    [self.view addSubview:_replyView];
    
    _bottomReplyWhiteView = [[UIView alloc]init];
    [_bottomReplyWhiteView setBackgroundColor:[UIColor whiteColor]];
    [_bottomReplyWhiteView setFrame:XFrame(0, Screen_H-IFAutoFitPx(120)+Screen_H, Screen_W, IFAutoFitPx(120))];
    [self.view addSubview:_bottomReplyWhiteView];
    
    _replyText = [[UITextField alloc]init];
    [_replyText setFrame:XFrame(IFAutoFitPx(20), IFAutoFitPx(15), Screen_W-IFAutoFitPx(180), IFAutoFitPx(90))];
    [_replyText setPlaceholder:@"回复评论"];
    [_bottomReplyWhiteView addSubview:_replyText];
    
    UIButton *sendBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [sendBtn setFrame:XFrame(CGRectGetMaxX(_replyText.frame)+IFAutoFitPx(20), IFAutoFitPx(15), IFAutoFitPx(120), IFAutoFitPx(90))];
    [sendBtn setTitle:@"发送" forState:(UIControlStateNormal)];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [sendBtn setBackgroundColor:IFThemeBlueColor];
    [sendBtn addTarget:self action:@selector(sendComment) forControlEvents:(UIControlEventTouchUpInside)];
    sendBtn.layer.cornerRadius = 3;
    sendBtn.layer.masksToBounds = YES;
    [_bottomReplyWhiteView addSubview:sendBtn];
    
}

- (UIView *)setHeaderview:(NSDictionary *)dataDict{
    UIView *view = [[UIView alloc]init];
    [view setFrame:XFrame(0, 0, Screen_W, IFAutoFitPx(183))];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    _goodCommentRate = [[UILabel alloc]init];
    [_goodCommentRate setFrame:XFrame(IFAutoFitPx(20), 0, IFAutoFitPx(250), IFAutoFitPx(95))];
    [_goodCommentRate setText:[NSString stringWithFormat:@"好评率：100 %%"]];
    [_goodCommentRate setFont:XFont(14)];
    [view addSubview:_goodCommentRate];
    
    _btn2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_btn2 setFrame:XFrame(CGRectGetMaxX(_goodCommentRate.frame), 0, (Screen_W-IFAutoFitPx(330))/3, IFAutoFitPx(95))];
    [_btn2 setTitle:[NSString stringWithFormat:@"好评(99)"] forState:(UIControlStateNormal)];
    [_btn2 setTitleColor:BlackColor forState:(UIControlStateNormal)];
    [_btn2.titleLabel setFont:XFont(14)];
//    XViewLayerCB(btn2, IFAutoFitPx(25), 0.5, BlackColor);
    [view addSubview:_btn2];
    
    _btn3 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_btn3 setFrame:XFrame(IFAutoFitPx(20)+CGRectGetMaxX(_btn2.frame), 0, (Screen_W-IFAutoFitPx(330))/3, IFAutoFitPx(95))];
    [_btn3 setTitle:[NSString stringWithFormat:@"中评(1)"] forState:(UIControlStateNormal)];
    [_btn3 setTitleColor:BlackColor forState:(UIControlStateNormal)];
    [_btn3.titleLabel setFont:XFont(14)];
//    XViewLayerCB(btn3, IFAutoFitPx(25), 0.5, BlackColor);
    [view addSubview:_btn3];
    
    _btn4 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_btn4 setFrame:XFrame(IFAutoFitPx(20)+CGRectGetMaxX(_btn3.frame), 0, (Screen_W-IFAutoFitPx(330))/3, IFAutoFitPx(95))];
    [_btn4 setTitle:[NSString stringWithFormat:@"差评(0)"] forState:(UIControlStateNormal)];
    [_btn4.titleLabel setFont:XFont(14)];
//    XViewLayerCB(btn4, IFAutoFitPx(25), 0.5, BlackColor);
    [_btn4 setTitleColor:BlackColor forState:(UIControlStateNormal)];
    [view addSubview:_btn4];
    
    UIView *grayView = [[UIView alloc]initWithFrame:XFrame(0, IFAutoFitPx(94), Screen_W, IFAutoFitPx(1))];
    [grayView setBackgroundColor:LineColor];
    [view addSubview:grayView];
    
    _topBackgroundView = [[UIView alloc]init];
    [_topBackgroundView setFrame:XFrame(0, IFAutoFitPx(95), Screen_W, IFAutoFitPx(88))];
    XViewLayerCB(_topBackgroundView, 0, 0.5, LineColor);
    [view addSubview:_topBackgroundView];
    
    UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn1 setFrame:XFrame(0, IFAutoFitPx(10), Screen_W/2, IFAutoFitPx(68))];
    [btn1 setTitle:@"全部评价" forState:(UIControlStateNormal)];
    [btn1 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [btn1.titleLabel setFont:XFont(16)];
    btn1.tag = 0;
    [btn1 addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [_topBackgroundView addSubview:btn1];
    [self.btnArr addObject:btn1];
    
    UIButton *noReply = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [noReply setFrame:XFrame(Screen_W/2, IFAutoFitPx(10), Screen_W/2, IFAutoFitPx(68))];
    [noReply setTitle:@"未回复" forState:(UIControlStateNormal)];
    [noReply setTitleColor:GrayColor forState:(UIControlStateNormal)];
    [noReply.titleLabel setFont:XFont(16)];
    noReply.tag = 1;
    [noReply addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [_topBackgroundView addSubview:noReply];
    [self.btnArr addObject:noReply];
    
    _lineView = [[UIView alloc]init];
    [_lineView setFrame:XFrame(0, IFAutoFitPx(88-4), Screen_W/2, IFAutoFitPx(4))];
    [_lineView setBackgroundColor:IFThemeBlueColor];
    [_topBackgroundView addSubview:_lineView];
    
    return view;
}

- (void)setDataWithDict:(NSDictionary *)dict{
    [_goodCommentRate setText:[NSString stringWithFormat:@"好评率：%ld %%",[[dict objectForKey:@"rate"] integerValue]*100]];
    [_btn2 setTitle:[NSString stringWithFormat:@"好评(%@)",[dict objectForKey:@"haoping"]] forState:(UIControlStateNormal)];
    [_btn3 setTitle:[NSString stringWithFormat:@"中评(%@)",[dict objectForKey:@"zhongping"]] forState:(UIControlStateNormal)];
    [_btn4 setTitle:[NSString stringWithFormat:@"差评(%@)",[dict objectForKey:@"chaping"]] forState:(UIControlStateNormal)];
}

- (void)sendComment{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger storeId = [[[userDefaults objectForKey:@"userInfo"] objectForKey:@"store_id"] integerValue];
    NSDictionary *dict = @{@"store_id":@(storeId),
                           @"content":_replyText.text,
                           @"parent_id":@(_commentId)
                           };
    [Http_url POST:@"store_feedback" dict:dict showHUD:YES WithSuccessBlock:^(id data) {
        if ([[data objectForKey:@"code"] integerValue] == 200){
            [[IFUtils share]showErrorInfo:@"已发送"];
            [self.replyView setHidden:YES];
            [self.bottomReplyWhiteView setFrame:XFrame(0, Screen_H-IFAutoFitPx(120)+Screen_H, Screen_W, IFAutoFitPx(120))];
            [self requestNoReplyData];
        }
    } WithFailBlock:^(id data) {
        
    }];
}

- (void)hide{
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.2 animations:^{
        [weakself.replyView setHidden:YES];
        [weakself.bottomReplyWhiteView setFrame:XFrame(0, Screen_H-IFAutoFitPx(120)+Screen_H, Screen_W, IFAutoFitPx(120))];
    }];

}

#pragma mark - NoImageTableViewCellDlegate
- (void)replyComment:(NSString *)index{
    _commentId = [[[self.dataSource objectAtIndex:[index integerValue]] objectForKey:@"com_id"] integerValue];//获取评论id
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.2 animations:^{
        [weakself.replyView setHidden:NO];
        [weakself.bottomReplyWhiteView setFrame:XFrame(0, Screen_H-IFAutoFitPx(120), Screen_W, IFAutoFitPx(120))];
    }];
}

#pragma mark - tableview代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UserEvaluationTableViewCell1 *cell = (UserEvaluationTableViewCell1 *)[tableView dequeueReusableCellWithIdentifier:@"UserEvaluationTableViewCell1"];
//    UserEvaluationTableViewCell *cell1 = (UserEvaluationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"UserEvaluationTableViewCell"];
    NoImageTableViewCell *cell2 = (NoImageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"NoImageTableViewCell"];
    NoImageWithReplyTableViewCell *cell3 = (NoImageWithReplyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"NoImageWithReplyTableViewCell"];
    NSDictionary *commentData;
    if (kISNullArray(self.dataSource)){
        
    }else{
        commentData = [self.dataSource objectAtIndex:indexPath.row];
    }
    NSString *replayStr = [commentData objectForKey:@"replay"];
    if ([replayStr isKindOfClass:[NSNull class]]){
        if (!cell2){
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NoImageTableViewCell" owner:self options:nil];
            cell2 = [nib objectAtIndex:0];
        }
        [cell2 addCommentData:commentData Index:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        cell2.delegate = self;
        cell2.tag = indexPath.row;
        return cell2;
    }else{
        if (!cell3){
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NoImageWithReplyTableViewCell" owner:self options:nil];
            cell3 = [nib objectAtIndex:0];
        }
        [cell3 addCommentData:commentData];
        cell3.tag = indexPath.row;
        return cell3;
    }
    return nil;
}

#pragma mark - 顶部按钮点击方法
- (void)clickBtn:(UIButton *)sender{
    _currentIndex = sender.tag;
    [self requestNoReplyData];
    [_lineView setFrame:XFrame(Screen_W/2*_currentIndex, IFAutoFitPx(88-4), Screen_W/2, IFAutoFitPx(4))];
    for (UIButton *btn in _btnArr){
        if (btn.tag == _currentIndex){
            [btn setTitleColor:BlackColor forState:(UIControlStateNormal)];
        }else{
            [btn setTitleColor:GrayColor forState:(UIControlStateNormal)];
            
        }
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)btnArr{
    if (!_btnArr){
        _btnArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _btnArr;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource){
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

@end
