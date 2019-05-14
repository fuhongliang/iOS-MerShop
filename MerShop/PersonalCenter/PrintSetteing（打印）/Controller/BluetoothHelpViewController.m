//
//  BluetoothHelpViewController.m
//  MerShop
//
//  Created by mac on 2019/4/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BluetoothHelpViewController.h"

@interface BluetoothHelpViewController ()
@property (nonatomic ,strong)WKWebView *webview;
@end

@implementation BluetoothHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNaviTitle:@"用户协议"];
    [self.view addSubview:self.webview];
}

- (WKWebView *)webview{
    if (!_webview){
        _webview = [[WKWebView alloc]init];
        [_webview setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
        NSString* htmlPath = [[NSBundle mainBundle] pathForResource:self.htmlName ofType:@"html"];
        NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
        NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
        [_webview loadHTMLString:appHtml baseURL:baseURL];
    }
    return _webview;
}

@end
