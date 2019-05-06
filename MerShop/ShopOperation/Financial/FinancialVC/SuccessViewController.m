//
//  SuccessViewController.m
//  MerShop
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SuccessViewController.h"
#import "SuccessFinishView.h"
#import "BankCardViewController.h"
#import "FinanceViewController.h"

@interface SuccessViewController ()<SuccessFinishViewDelegate>
@property (nonatomic ,strong)SuccessFinishView *scsView;
@end

@implementation SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"绑定成功"];
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SuccessFinishView" owner:self options:nil];
    _scsView = [nib objectAtIndex:0];
    _scsView.delegate = self;
    [_scsView setTitleDict:self.titleDict];
    [_scsView setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [self.view addSubview:_scsView];
    
    [self createTimer];
}

- (void)back{
    [self toChooseVC];
}

//导航条返回按钮方法
- (void)popViewController{
    [self toChooseVC];
}

/**
 跳转指定页面
 */
- (void)toChooseVC{
    for (BasicViewController *controller in self.navigationController.viewControllers){
        if ([controller isKindOfClass:[FinanceViewController class]]){
            FinanceViewController *financevVC = (FinanceViewController *)controller;
            [self.navigationController popToViewController:financevVC animated:YES];
        }
    }
}

#pragma mark - 定时器 (GCD)
- (void)createTimer {
    
    //设置倒计时时间
    //__block 如果修饰指针时，指针相当于弱引用，指针对指向的对象不产生引用计数的影响
    __block int timeout = 4;
    
    //获取全局队列
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //创建一个定时器，并将定时器的任务交给全局队列执行(并行，不会造成主线程阻塞)
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, global);
    
    // 设置触发的间隔时间
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //1.0 * NSEC_PER_SEC  代表设置定时器触发的时间间隔为1s
    //0 * NSEC_PER_SEC    代表时间允许的误差是 0s
    
    //block内部 如果对当前对象的强引用属性修改 应该使用__weak typeof(self)weakSelf 修饰  避免循环调用
    __weak typeof(self)weakSelf = self;
    //设置定时器的触发事件
    dispatch_source_set_event_handler(timer, ^{
        
        //倒计时  刷新button上的title ，当倒计时时间为0时，结束倒计时
        
        //1. 每调用一次 时间-1s
        timeout --;
        
        //2.对timeout进行判断时间是停止倒计时，还是修改button的title
        if (timeout <= 0) {
            
            //停止倒计时，button打开交互，背景颜色还原，title还原
            
            //关闭定时器
            dispatch_source_cancel(timer);
            
            //MRC下需要释放，这里不需要
            //            dispatch_realse(timer);
            
            //button上的相关设置
            //注意: button是属于UI，在iOS中多线程处理时，UI控件的操作必须是交给主线程(主队列)
            //在主线程中对button进行修改操作
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf toChooseVC];
                
            });
        }else {
            
            //处于正在倒计时，在主线程中刷新button上的title，时间-1秒
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString * title = [NSString stringWithFormat:@"返回(%d)",timeout];
                
                [weakSelf.scsView.backBtn setTitle:title forState:UIControlStateNormal];
            });
        }
    });
    
    dispatch_resume(timer);
}

@end
