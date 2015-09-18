//
//  LayerMaskTestViewController.m
//  TestCode
//
//  Created by Encoder on 15/9/2.
//  Copyright (c) 2015年 Encoder. All rights reserved.
//
#import "DragView.h"
#import "LayerMaskTestViewController.h"

@interface LayerMaskTestViewController (){
    
    __weak IBOutlet UIView *viewOrange;
    __weak IBOutlet UIView *viewGreen;
    __weak IBOutlet UIView *viewYellow;
    __weak IBOutlet UILabel *label;
    __weak IBOutlet DragView *viewBase;
    __weak IBOutlet DragView *viewBasebeyond;
}
@property (nonatomic,retain) CAGradientLayer *gradientLayer;//颜色渐变图层

@end

@implementation LayerMaskTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    viewYellow.layer.mask=label.layer;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self colorChange];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//渐变效果
-(void)colorChange{
    _gradientLayer=[CAGradientLayer layer];
    _gradientLayer.frame=CGRectMake(0, 0, viewBase.frame.size.width, viewBase.frame.size.height);
    _gradientLayer.colors = @[(id)[self randomColor].CGColor, (id)[self randomColor].CGColor,(id)[self randomColor].CGColor];
    [viewBase.layer addSublayer:_gradientLayer];
    _gradientLayer.mask=viewBasebeyond.layer;
    
    // 利用定时器，快速的切换渐变颜色，就有颜色变化效果
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(textColorChange)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// 随机颜色方法
-(UIColor *)randomColor{
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

// 定时器触发方法
-(void)textColorChange {
    _gradientLayer.colors = @[(id)[self randomColor].CGColor,
                              (id)[self randomColor].CGColor,
                              (id)[self randomColor].CGColor,
                              (id)[self randomColor].CGColor,
                              (id)[self randomColor].CGColor];
}

@end
