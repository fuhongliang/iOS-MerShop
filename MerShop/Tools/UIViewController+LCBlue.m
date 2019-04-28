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
        [ProgressShow alertView:self.view Message:@"打印机正在准备中..." cb:nil];
        return;
    }
    JWPrinter *printer = [[JWPrinter alloc] init];
    NSString *str1 = @"------------前海一户------------";
    [printer appendText:str1 alignment:HLTextAlignmentCenter];
    [printer appendText:@"今日单号#88" alignment:(HLTextAlignmentCenter) fontSize:14];
    [printer appendText:@"奈雪の茶" alignment:(HLTextAlignmentCenter)];
    [printer appendText:@"在线支付（已支付）" alignment:(HLTextAlignmentCenter)];
    NSString *str2 = @"--------------------------------";
    [printer appendText:str2 alignment:HLTextAlignmentCenter];
    [printer appendText:@"骑手电话：188****8936" alignment:HLTextAlignmentLeft];
    [printer appendText:@"期望送达时间：立即送达" alignment:HLTextAlignmentLeft];
    [printer appendText:@"下单时间：2019-4-25 12:00" alignment:HLTextAlignmentLeft];
    [printer appendText:@"订单号：88888888888" alignment:HLTextAlignmentLeft];
    NSString *str3 = @"--------------------------------";
    [printer appendText:str3 alignment:HLTextAlignmentCenter];
    [printer appendText:@"菜单信息" alignment:HLTextAlignmentCenter fontSize:10];
    [printer appendLeftText:@"菜名" middleText:@"数量" rightText:@"单价" isTitle:YES];
    [printer appendLeftText:@"香辣汉堡" middleText:@"x1" rightText:@"20元" isTitle:YES];
    [printer appendLeftText:@"肥肠大热狗" middleText:@"x3" rightText:@"20元" isTitle:YES];
    [printer appendLeftText:@"张家界米粉" middleText:@"x10" rightText:@"30元" isTitle:YES];
    NSString *str4 = @"--------------------------------";
    [printer appendText:str4 alignment:HLTextAlignmentCenter];
    [printer appendText:@"其他" alignment:(HLTextAlignmentCenter) fontSize:10];
    [printer appendText:@"配送费：5.00" alignment:(HLTextAlignmentLeft)];
    [printer appendText:@"包装费：2.00" alignment:(HLTextAlignmentLeft)];
    NSString *str5 = @"--------------------------------";
    [printer appendText:str5 alignment:HLTextAlignmentCenter];
    [printer appendText:@"合计：140元" alignment:(HLTextAlignmentRight)];
    NSString *str6 = @"--------------------------------";
    [printer appendText:str6 alignment:HLTextAlignmentCenter];

    [printer appendText:@"山东省大屁股村002号" alignment:(HLTextAlignmentLeft)];
    [printer appendText:@"188****8971" alignment:(HLTextAlignmentLeft)];
    [printer appendText:@"猪伟炒" alignment:(HLTextAlignmentLeft)];
    
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

@end
