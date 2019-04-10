//
//  Http_url.m
//  MerShop
//
//  Created by mac on 2019/3/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "Http_url.h"
#import "AFNetworking.h"


@implementation Http_url

+(AFHTTPSessionManager *)getManager{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html",nil];
    [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSString *token = [dict objectForKey:@"token"];
    if (token.length){
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    return manager;
}

+ (void)POST:(NSString *)httpUrl dict:(NSDictionary *)dict showHUD:(BOOL)show WithSuccessBlock:(void (^)(id))successBlock WithFailBlock:(void (^)(id))FailBlock{
    if (show){
        [[IFUtils share]showLoadingView];
    }
    AFHTTPSessionManager *manager = [self getManager];
    NSString *url = [NSString stringWithFormat:@"%@%@",http_urlString,httpUrl];
    [manager POST:url parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSInteger code = [dic[@"code"] integerValue];
        if (code == 200){
            if (show){
                [SVProgressHUD dismiss];
            }
            successBlock(dic);
        }else{
            if (show){
                [SVProgressHUD dismiss];
            }
            [[IFUtils share]showErrorInfo:[NSString stringWithFormat:@"%@",dic[@"msg"]]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[IFUtils share]showErrorInfo:@"发送失败,请稍后再试!"];
        [SVProgressHUD dismiss];
        FailBlock(error);
    }];
    
    
}


@end
