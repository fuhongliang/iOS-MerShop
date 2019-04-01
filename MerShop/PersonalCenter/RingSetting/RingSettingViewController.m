//
//  RingSettingViewController.m
//  MerShop
//
//  Created by mac on 2019/3/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RingSettingViewController.h"
#import "NewsSettingview.h"
#import <AudioToolbox/AudioToolbox.h>


@interface RingSettingViewController ()

@end

@implementation RingSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"消息和铃声设置"];
    [self.navigationController.navigationBar setHidden:YES];
    [self.view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [self setUI];

}

- (void)setUI{
    
    NSArray *nibView = [[NSBundle mainBundle]loadNibNamed:@"NewsSettingview" owner:self options:nil];
    NewsSettingview *view = [nibView objectAtIndex:0];
    [view setBackgroundColor:toPCcolor(@"#f5f5f5")];
    [view setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
    [view.switch1 addTarget:self action:@selector(changeShake:) forControlEvents:(UIControlEventTouchUpInside)];
    [view.switch2 addTarget:self action:@selector(changeVoice:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:view];
    
}

- (void)changeShake:(UISwitch *)sender{
    if (sender.isOn){
        NSLog(@"开启状态————震动");
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//系统声音
        [[IFUtils share]showErrorInfo:@"震动已开启"];
    }else{
        NSLog(@"关闭状态————震动");
    }
}

- (void)changeVoice:(UISwitch *)sender{
    if (sender.isOn){
        NSLog(@"开启状态————声音");
        AudioServicesPlaySystemSound(1007);
        [[IFUtils share]showErrorInfo:@"声音已开启"];
    }else{
        NSLog(@"关闭状态————声音");
    }
}

@end
