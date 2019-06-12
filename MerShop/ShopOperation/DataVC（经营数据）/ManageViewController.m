//
//  ManageViewController.m
//  MerShop
//
//  Created by mac on 2019/3/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ManageViewController.h"

@interface ManageViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic ,strong)UIProgressView *progressView;
@property (nonatomic ,strong)WKWebView *webview;
@end

@implementation ManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:self.navTitle];
    [self setUI];
    
}

- (void)setUI{
    
    [self.view addSubview:self.webview];
    [self.view addSubview:self.progressView];
    //添加监测网页加载进度的观察者
    [self.webview addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:0
                      context:nil];
    
}

//移除观察者
- (void)dealloc{
    [_webview removeObserver:self
                  forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

- (WKWebView *)webview{
    if (!_webview){
        _webview = [[WKWebView alloc]init];
        [_webview setFrame:XFrame(0, ViewStart_Y, Screen_W, Screen_H-ViewStart_Y)];
        [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    }
    return _webview;
}

- (UIProgressView *)progressView{
    if (!_progressView){
        _progressView = [[UIProgressView alloc]init];
        [_progressView setFrame:XFrame(0, ViewStart_Y, Screen_W, IFAutoFitPx(4))];
        [_progressView setProgress:0];
        _progressView.tintColor = [UIColor greenColor];
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == _webview){
        NSLog(@"网页加载进度 = %f",_webview.estimatedProgress);
        self.progressView.progress = _webview.estimatedProgress;
        if (_webview.estimatedProgress >= 1.0f) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.progress = 1;
                [self.progressView setHidden:YES];
            });
        }
        
    }
    
}

@end
