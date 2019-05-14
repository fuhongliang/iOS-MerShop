//
//  NotificationService.m
//  MSNotificationService
//
//  Created by mac on 2019/5/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import "NotificationService.h"
#import <AVFoundation/AVFAudio.h>

@interface NotificationService ()<AVAudioPlayerDelegate>

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    
    self.contentHandler(self.bestAttemptContent);
    dispatch_queue_t dispatchQueue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(dispatchQueue, ^(void)
                   
                   {
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

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
