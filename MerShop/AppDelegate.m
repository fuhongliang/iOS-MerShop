//
//  AppDelegate.m
//  MerShop
//
//  Created by mac on 2019/3/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginInViewController.h"
#import "TabBarController.h"
#import "NavigationViewController.h"
#import <Bugtags/Bugtags.h>
#import <UMCommon/UMCommon.h>
#import <UMPush/UMessage.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<AVAudioPlayerDelegate>
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setUMessageRegisterEntity:launchOptions];
    
    
    [self setLoop];
    //集成bugtags
//    [Bugtags startWithAppKey:@"a9f3371df352d637e15d5cd13955a61c" invocationEvent:BTGInvocationEventBubble];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    NSString *token = [UserInfoDict objectForKey:@"token"];
    if (kISNullString(token)){
        LoginInViewController *login = [[LoginInViewController alloc]init];
        NavigationViewController *navi = [[NavigationViewController alloc]initWithRootViewController:login];
        [navi.navigationBar setHidden:YES];
        [self.window setRootViewController:navi];
    }else{
        TabBarController *startVc = [TabBarController share];
        NavigationViewController *navi = [[NavigationViewController alloc]initWithRootViewController:startVc];
        [navi.navigationBar setHidden:YES];
        [self.window setRootViewController:navi];
    }
    
    return YES;
}

- (void)setUMessageRegisterEntity:(NSDictionary *)launchOptions{
    [UMConfigure setLogEnabled:YES];
    
    [UMConfigure initWithAppkey:@"5cc7bee60cafb2129200044d" channel:@"App Store"];
    
    // Push功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert|UMessageAuthorizationOptionSound;
    //如果你期望使用交互式(只有iOS 8.0及以上有)的通知，请参考下面注释部分的初始化代码
    if (([[[UIDevice currentDevice] systemVersion]intValue]>=8)&&([[[UIDevice currentDevice] systemVersion]intValue]<10)) {
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"打开应用";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"忽略";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        UIMutableUserNotificationCategory *actionCategory1 = [[UIMutableUserNotificationCategory alloc] init];
        actionCategory1.identifier = @"category1";//这组动作的唯一标示
        [actionCategory1 setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        NSSet *categories = [NSSet setWithObjects:actionCategory1, nil];
        entity.categories=categories;
    }
    //如果要在iOS10显示交互式的通知，必须注意实现以下代码
    if ([[[UIDevice currentDevice] systemVersion]intValue]>=10) {
        UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
        UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
        
        //UNNotificationCategoryOptionNone
        //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
        //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
        UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category1" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        NSSet *categories = [NSSet setWithObjects:category1_ios10, nil];
        entity.categories=categories;
    }
    [UNUserNotificationCenter currentNotificationCenter].delegate=self;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            
        }else{
            
        }
    }];
}

- (void)setLoop{
    
    
}

- (void)playAudio{
    dispatch_queue_t dispatchQueue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(dispatchQueue, ^(void)
                   
    {
        [self setLoop];
        NSBundle *mainBundle = [NSBundle mainBundle];
        
        NSString *filePath = [mainBundle pathForResource:@"ring"ofType:@"mp3"];//获取音频文件
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        
        NSError *error = nil;
        
        self.audioPlayer = [[AVAudioPlayer alloc] initWithData:fileData error:&error];
        
        
        if (self.audioPlayer != nil)
            
        {
            
            self.audioPlayer.delegate = self;
            
            if ([self.audioPlayer prepareToPlay] &&[self.audioPlayer play])
                
            {
                //成功播放音乐
            } else {
                
                //播放失败
                
            }
        } else {
            /*
             
             无法实例AVAudioPlayer
             
             */
        }
    });
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [UMessage setAutoAlert:NO];
            //应用处于前台时的远程推送接受
            //必须加这句代码
            [self playAudio];
            [UMessage didReceiveRemoteNotification:userInfo];
        }else{
            //应用处于前台时的本地推送接受
        }
    } else {
        // Fallback on earlier versions
    }
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}
//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            //应用处于后台时的远程推送接受
            //必须加这句代码
            [self playAudio];
            [UMessage didReceiveRemoteNotification:userInfo];
        }else{
            //应用处于后台时的本地推送接受
        }
    } else {
        // Fallback on earlier versions
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSLog(@"设备token=%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
    stringByReplacingOccurrencesOfString: @">" withString: @""]
    stringByReplacingOccurrencesOfString: @" " withString: @""]);
    
    NSString *Token = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""] stringByReplacingOccurrencesOfString: @">" withString: @""] stringByReplacingOccurrencesOfString: @" " withString: @""];
    self.token = Token;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"deviceToken" object:Token];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
