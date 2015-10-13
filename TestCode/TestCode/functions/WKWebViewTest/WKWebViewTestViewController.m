//
//  WKWebViewTestViewController.m
//  TestCode
//
//  Created by Encoder on 15/8/27.
//  Copyright (c) 2015年 Encoder. All rights reserved.
//


#import "WKWebViewTestViewController.h"
#import <WebKit/WebKit.h>
@implementation WKBackForwardListItem (WKBackForwardListItemDiscription)
-(NSString *)description{
    return [NSString stringWithFormat:@"URL:%@ \ntitle:%@ \ninitialURL:%@}",self.URL,self.title,self.initialURL];
}
@end

@implementation WKBackForwardList (WKBackForwardListDiscription)
-(NSString *)description{
    NSString *discriptionString=[NSString stringWithFormat:@"backList:%@",self.backList];
    return discriptionString;
}
@end

@interface WKWebViewTestViewController ()<WKNavigationDelegate,WKUIDelegate>{
    WKWebView *webViewTest;
    NSTimer *getProgressTimer;
    UIProgressView *loadProgress;
    
}

@end

@implementation WKWebViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    loadProgress =[[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    loadProgress.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+64, self.view.frame.size.width, 2);
    loadProgress.trackTintColor=[UIColor orangeColor];
    loadProgress.progressTintColor=[UIColor blueColor];
    
    webViewTest=[[WKWebView alloc]initWithFrame:CGRectMake(0, 0, 375, 667)];
    webViewTest.navigationDelegate=self;
    [webViewTest loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    [self.view addSubview:webViewTest];
    
//
}

-(void)viewWillDisappear:(BOOL)animated{
    [webViewTest stopLoading];
    [getProgressTimer invalidate];
    
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    webViewTest=nil;
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    NSLog(@"%s",__func__);
}

//获取页面加载进度
-(void)getLoadProgress{
    loadProgress.progress=[webViewTest estimatedProgress];
}



#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [webViewTest addSubview:loadProgress];
    getProgressTimer=[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(getLoadProgress) userInfo:nil repeats:YES];
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [loadProgress removeFromSuperview];
    loadProgress.progress=0.f;
    
    [getProgressTimer invalidate];
    getProgressTimer=nil;

    self.title=webView.title;
    
    NSLog(@"返回列表：%@",[webView backForwardList]);
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [loadProgress removeFromSuperview];
    loadProgress.progress=0.f;
    
    [getProgressTimer invalidate];
    getProgressTimer=nil;
}

//// 接收到服务器跳转请求之后调用
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
//    
//}
//
//// 在收到响应后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//    
//}
//
//// 在发送请求之前，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//    
//}

#pragma mark - WKUIDelegate

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
