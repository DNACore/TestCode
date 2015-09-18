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
    CAGradientLayer *clayer;
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
    [webViewTest loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    [self.view addSubview:webViewTest];
    
    [self progressLayer];
}

-(void)viewWillDisappear:(BOOL)animated{
    [webViewTest stopLoading];
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

#pragma mark - 加载进度条
-(void)progressLayer{
    // Use a horizontal gradient
    CAGradientLayer *layer = [CAGradientLayer layer];
    clayer=layer;
    layer.frame=CGRectMake(0, 80, 320, 40);
    [layer setStartPoint:CGPointMake(0.0, 0.5)];
    [layer setEndPoint:CGPointMake(1.0, 0.5)];
    
    // Create colors using hues in +5 increments
    NSMutableArray *colors = [NSMutableArray array];
    for (NSInteger hue = 0; hue <= 360; hue += 5) {
        
        UIColor *color;
        color = [UIColor colorWithHue:1.0 * hue / 360.0
                           saturation:1.0
                           brightness:1.0
                                alpha:1.0];
        [colors addObject:(id)[color CGColor]];
    }
    [layer setColors:[NSArray arrayWithArray:colors]];
    [self.view.layer addSublayer:layer];
    [self performAnimation:clayer];
}

- (void)performAnimation:(CAGradientLayer *)layer {
    // Move the last color in the array to the front
    // shifting all the other colors.
    NSMutableArray *mutable = [[layer colors] mutableCopy];
    [mutable insertObject:[mutable lastObject] atIndex:0];
    [mutable removeLastObject];
    
    // Update the colors on the model layer
    [layer setColors:mutable];
    
    // Create an animation to slowly move the gradient left to right.
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    [animation setToValue:mutable];
    [animation setDuration:0.01];
    [animation setRemovedOnCompletion:YES];
    [animation setFillMode:kCAFillModeForwards];
    [animation setDelegate:self];
    [layer addAnimation:animation forKey:@"animateGradient"];
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    [self performAnimation:clayer];
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
