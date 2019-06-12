//
//  NoticeDetailViewController.m
//  MerShop
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "NoticeDetailViewController.h"


@interface NoticeDetailViewController ()
@property (nonatomic ,strong)UILabel *mainTitle;
@property (nonatomic ,strong)UILabel *time;
@property (nonatomic ,strong)UILabel *content;
@end

@implementation NoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"新订单提醒"];
    [self.view setBackgroundColor:WhiteColor];
    [self setUI];
    [self requestData];
    
}

- (void)requestData{
    NSDictionary *dict;
    if (self.noticeId != 0){
        dict = @{@"store_id":@(StoreId),
                 @"sm_id":@(self.noticeId)
                 };
    }
    [Http_url POST:@"msg_info" dict:dict showHUD:NO WithSuccessBlock:^(id data) {
        NSDictionary *d = data[@"data"];
        if ([[data objectForKey:@"code"] integerValue] == 200){
            [self.mainTitle setText:d[@"sm_title"]];
            [self.time setText:d[@"sm_addtime"]];
            [self.content setText:d[@"sm_content"]];
        }
    } WithFailBlock:^(id data) {

    }];
    
}

- (void)setUI{

    [self.view addSubview:self.mainTitle];
    [self.view addSubview:self.time];
    [self.view addSubview:self.content];
    
    [self.mainTitle makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(ViewStart_Y+10);
        make.left.equalTo(self.view.left).offset(15);
        make.right.equalTo(self.view.right).offset(15);
        make.height.equalTo(33);
    }];
    
    [self.time makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainTitle.bottom).offset(0);
        make.left.equalTo(self.view.left).offset(15);
        make.right.equalTo(self.view.right).offset(15);
        make.height.equalTo(30);
    }];
    
    [self.content makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.time.bottom).offset(10);
        make.left.equalTo(self.view.left).offset(15);
        make.right.equalTo(self.view.right).offset(15);
    }];
}

- (UILabel *)mainTitle{
    if (!_mainTitle){
        _mainTitle = [[UILabel alloc]init];
        [_mainTitle setFont:XFont(22)];
        [_mainTitle setNumberOfLines:1];
        [_mainTitle setTextColor:toPCcolor(@"#000000")];
    }
    return _mainTitle;
}
- (UILabel *)time{
    if (!_time){
        _time = [[UILabel alloc]init];
        [_time setFont:XFont(16)];
        [_time setNumberOfLines:1];
        [_time setTextColor:toPCcolor(@"#999999")];
    }
    return _time;
}
- (UILabel *)content{
    if (!_content){
        _content = [[UILabel alloc]init];
        [_content setFont:XFont(18)];
        [_content setNumberOfLines:0];
        [_content setTextColor:toPCcolor(@"#999999")];
    }
    return _content;
}


@end
