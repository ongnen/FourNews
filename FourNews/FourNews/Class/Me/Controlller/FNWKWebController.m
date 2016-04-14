//
//  FNWKWebController.m
//  FourNews
//
//  Created by admin on 16/4/14.
//  Copyright © 2016年 天涯海北. All rights reserved.
//

#import "FNWKWebController.h"
#import <WebKit/WebKit.h>

@interface FNWKWebController ()

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (nonatomic, weak) WKWebView *webView;

@end

@implementation FNWKWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupWebView];
}

- (void)setupWebView
{
    // 1.用webView实现
    //    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    //    [webView loadRequest:request];
    //    [self.view addSubview:webView];
    
    // 2.用WKWebView  iOS8 以前不可用
    // 注意 WKWebView中的属性都是用KVO监听的
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    [self.view bringSubviewToFront:self.progressView];
    self.webView = webView;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.progressView.progress = self.webView.estimatedProgress;
    if (self.webView.estimatedProgress>=1.0) {
        self.progressView.hidden = YES;
    }
}
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
@end
