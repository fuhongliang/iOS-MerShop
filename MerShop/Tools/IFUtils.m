//
//  IFUtils.m
//  MerShop
//
//  Created by mac on 2019/3/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "IFUtils.h"

static IFUtils *tool;

@implementation IFUtils
+(instancetype)share{
    if (!tool){
        tool = [[self alloc]init];
    }
    return tool;
}

- (void)showLoadingView{
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
//    [SVProgressHUD setForegroundColor:RGB(203, 162, 114)];
    [SVProgressHUD setForegroundColor:GrayColor];
    [SVProgressHUD showWithStatus:@"加载中..."];
}

- (void)showErrorInfo:(NSString *)info{
    [SVProgressHUD setBackgroundColor:BlackColor];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:14]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:info];
}
@end
