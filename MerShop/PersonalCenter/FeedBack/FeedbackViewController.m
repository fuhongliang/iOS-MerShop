//
//  FeedbackViewController.m
//  MerShop
//
//  Created by mac on 2019/3/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()<UITextViewDelegate>
@property (nonatomic ,strong)UITextView *text1;
//@property (nonatomic ,strong)UITextView *text2;
@property (nonatomic ,strong)UIButton *feedBack;
@property (nonatomic ,strong)UILabel *placeHolder1;
@property (nonatomic ,strong)NSString *content;
//@property (nonatomic ,strong)UILabel *placeHolder2;
@end

@implementation FeedbackViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
    [self.view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [self setNaviTitle:@"意见反馈"];
    [self setUI];
    [self setupPlaceHolder];
    
}

- (void)setUI{
    _text1 = [[UITextView alloc]init];
    [_text1 setFrame:XFrame(0,ViewStart_Y+IFAutoFitPx(22), Screen_W, IFAutoFitPx(320))];
    [_text1 setFont:XFont(15)];
    [_text1 setTextColor:toPCcolor(@"#333333")];
    [_text1 setBackgroundColor:[UIColor whiteColor]];
    [_text1 setDelegate:self];
    [self.view addSubview:_text1];

    _feedBack = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_feedBack setFrame:XFrame(IFAutoFitPx(30), CGRectGetMaxY(_text1.frame)+IFAutoFitPx(62), Screen_W-IFAutoFitPx(60), IFAutoFitPx(88))];
    [_feedBack setBackgroundColor:IFThemeBlueColor];
    [_feedBack setTitle:@"提交" forState:(UIControlStateNormal)];
    [_feedBack.titleLabel setFont:XFont(17)];
    [_feedBack addTarget:self action:@selector(submit) forControlEvents:(UIControlEventTouchUpInside)];
    [_feedBack.layer setCornerRadius:3];
    [_feedBack.layer setMasksToBounds:YES];
    [self.view addSubview:_feedBack];
    
}

- (void)submit{
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userinfo objectForKey:@"userInfo"];
    NSInteger store_id = [[dict objectForKey:@"store_id"] integerValue];
    _content = self.text1.text;
    if (kISNullString(_content)){
        [[IFUtils share]showErrorInfo:@"请输入您将反馈的内容!"];
        return;
    }
    NSDictionary *requestDict = @{@"store_id":@(store_id),
                                  @"content":_content,
                                  @"type":@(2)
                                  };
    [Http_url POST:@"store_msg_feedback" dict:requestDict showHUD:YES WithSuccessBlock:^(id data) {
        NSInteger code = [[data objectForKey:@"code"] integerValue];
        if (code == 200){
            [[IFUtils share]showErrorInfo:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } WithFailBlock:^(id data) {
        
    }];
    
}

// 给textView添加一个UILabel子控件
- (void)setupPlaceHolder
{
    UILabel *placeHolder1 = [[UILabel alloc] initWithFrame:XFrame(IFAutoFitPx(15), IFAutoFitPx(13), Screen_W-IFAutoFitPx(60), IFAutoFitPx(36))];
    placeHolder1.text = @"请留下您的宝贵意见或建议，我们将努力改进";
    placeHolder1.textColor = toPCcolor(@"#999999");
    self.placeHolder1 = placeHolder1;
    placeHolder1.font = XFont(15);
    placeHolder1.numberOfLines = 0;
    placeHolder1.contentMode = UIViewContentModeTop;
    [self.text1 addSubview:placeHolder1];
    
}

- (void)textViewDidChange:(UITextView *)textView{
    if (!textView.text.length){
        self.placeHolder1.alpha = 1;
    }else{
        self.placeHolder1.alpha = 0;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
