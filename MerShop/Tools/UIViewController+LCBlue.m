//
//  UIViewController+LCBlue.m
//  MerShop
//
//  Created by mac on 2019/4/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UIViewController+LCBlue.h"


@implementation UIViewController (LCBlue)

- (void)printOrderWithDict:(NSDictionary *)dict{
    JWBluetoothManage *manage = [JWBluetoothManage sharedInstance];
    if (manage.stage != JWScanStageCharacteristics) {
        [ProgressShow alertView:self.view Message:@"请连接蓝牙打印机..." cb:nil];
        return;
    }
    JWPrinter *printer = [[JWPrinter alloc] init];
    [printer appendText:dict[@"add_time"] alignment:(HLTextAlignmentCenter)];
    NSString *str1 = @"--------------------------------";
    [printer appendText:str1 alignment:HLTextAlignmentCenter];
    NSString *orderNum = [NSString stringWithFormat:@"今日单号#%@",dict[@"order_id"]];
    [printer appendText:orderNum alignment:(HLTextAlignmentCenter)];
    NSString *storeName = [UserInfoDict objectForKey:@"store_name"];
    [printer appendText:storeName alignment:(HLTextAlignmentCenter)];
    [printer appendText:@"在线支付（已支付）" alignment:(HLTextAlignmentCenter)];
    NSString *str2 = @"--------------------------------";
    [printer appendText:str2 alignment:HLTextAlignmentCenter];
    [printer appendText:@"骑手电话：188****8936" alignment:HLTextAlignmentLeft];
    [printer appendText:@"期望送达时间：立即送达" alignment:HLTextAlignmentLeft];
    NSString *orderTime = [NSString stringWithFormat:@"下单时间：%@",dict[@"add_time"]];
    [printer appendText:orderTime alignment:HLTextAlignmentLeft];
    [printer appendText:[NSString stringWithFormat:@"订单号：%@",dict[@"order_sn"]] alignment:HLTextAlignmentLeft];
    NSString *str3 = @"--------------------------------";
    [printer appendText:str3 alignment:HLTextAlignmentCenter];
    [printer appendText:@"菜单信息" alignment:HLTextAlignmentCenter fontSize:10];
    [printer appendLeftText:@"菜名" middleText:@"数量" rightText:@"单价" isTitle:YES];
    NSArray *arr = [dict[@"extend_order_goods"] copy];
    for (NSInteger i=0;i<arr.count;i++){
        NSDictionary *d = arr[i];
        NSString *name = [NSString stringWithFormat:@"%@",d[@"goods_name"]];
        NSString *number = [NSString stringWithFormat:@"x%@",d[@"goods_num"]];
        NSString *price = [NSString stringWithFormat:@"¥%@",d[@"goods_price"]];
        [printer appendLeftText:name middleText:number rightText:price isTitle:YES];
    }
//    [printer appendLeftText:@"香辣汉堡" middleText:@"x1" rightText:@"20元" isTitle:YES];
//    [printer appendLeftText:@"肥肠大热狗" middleText:@"x3" rightText:@"20元" isTitle:YES];
//    [printer appendLeftText:@"张家界米粉" middleText:@"x10" rightText:@"30元" isTitle:YES];
    NSString *str4 = @"--------------------------------";
    [printer appendText:str4 alignment:HLTextAlignmentCenter];
    [printer appendText:@"其他" alignment:(HLTextAlignmentCenter) fontSize:10];
    [printer appendText:@"配送费：5.00" alignment:(HLTextAlignmentLeft)];
    [printer appendText:@"包装费：2.00" alignment:(HLTextAlignmentLeft)];
    NSString *str5 = @"--------------------------------";
    [printer appendText:str5 alignment:HLTextAlignmentCenter];
    [printer appendText:[NSString stringWithFormat:@"合计：%@",dict[@"total_price"]] alignment:(HLTextAlignmentRight)];
    NSString *str6 = @"--------------------------------";
    [printer appendText:str6 alignment:HLTextAlignmentCenter];

    [printer appendText:dict[@"extend_order_common"][@"address"] alignment:(HLTextAlignmentLeft)];
    [printer appendText:dict[@"extend_order_common"][@"phone"] alignment:(HLTextAlignmentLeft)];
    [printer appendText:dict[@"extend_order_common"][@"reciver_name"] alignment:(HLTextAlignmentLeft)];
    
    NSString *str7 = @"--------------------------------";
    [printer appendText:str7 alignment:HLTextAlignmentCenter];
    
    [printer appendText:@"LINLINFA" alignment:(HLTextAlignmentCenter)];
    
    [printer appendNewLine];
    NSData *mainData = [printer getFinalData];
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            NSLog(@"打印成功");
        }else{
            NSLog(@"写入错误---:%@",error);
        }
    }];
    
}

- (void)playCellPhoneWithData:(id)data{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否拨打客户的联系电话" preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",data];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}
@end
