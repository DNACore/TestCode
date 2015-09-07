//
//  CGAffineTransformTestViewController.m
//  TestCode
//
//  Created by Encoder on 15/8/26.
//  Copyright (c) 2015年 Encoder. All rights reserved.
//

#import "CGAffineTransformTestViewController.h"

@interface CGAffineTransformTestViewController (){
    __weak IBOutlet UIView *testView;
    __weak IBOutlet UISlider *slider;
}

@end

@implementation CGAffineTransformTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [slider addTarget:self action:@selector(CGAffineTransformAnimation:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//CGAffineTransformIdentity 重置 CGAffineTransform
- (IBAction)CGAffineTransformIdentityAction:(id)sender {
    testView.transform=CGAffineTransformIdentity;
    //或者
    //testView.layer.transform=CATransform3DIdentity;
}

- (IBAction)CGAffineTransformMakeScaleAction:(id)sender {
    NSLog(@"a=%f b=%f c=%f d=%f tx=%f ty=%f",testView.transform.a,testView.transform.b,testView.transform.c,testView.transform.d,testView.transform.tx,testView.transform.ty);
    testView.transform=CGAffineTransformMakeScale(0.7,0.7);//设置transform的值
    NSLog(@"a=%f b=%f c=%f d=%f tx=%f ty=%f",testView.transform.a,testView.transform.b,testView.transform.c,testView.transform.d,testView.transform.tx,testView.transform.ty);
}
- (IBAction)CGAffineTransformScaleAction:(id)sender {
    NSLog(@"a=%f b=%f c=%f d=%f tx=%f ty=%f",testView.transform.a,testView.transform.b,testView.transform.c,testView.transform.d,testView.transform.tx,testView.transform.ty);
    testView.transform=CGAffineTransformScale(testView.transform,0.5,0.5);//设置transform的比率
    NSLog(@"a=%f b=%f c=%f d=%f tx=%f ty=%f",testView.transform.a,testView.transform.b,testView.transform.c,testView.transform.d,testView.transform.tx,testView.transform.ty);
}
- (IBAction)CGAffineTransformMakeRotationAction:(id)sender {
    testView.transform=CGAffineTransformMakeRotation(M_PI_4);
}
- (IBAction)CGAffineTransformRotateAction:(id)sender {
    testView.transform=CGAffineTransformRotate(testView.transform, M_PI_4);//累积旋转
}

-(void)CGAffineTransformAnimation:(UISlider *)currentSlider{
    float value=currentSlider.value;
    testView.transform=CGAffineTransformMakeScale(value,value);
    //testView.transform=CGAffineTransformScale(testView.transform,value,value);
    testView.transform=CGAffineTransformRotate(testView.transform, M_PI_4);
}

//飞入效果
- (IBAction)flyInAction:(id)sender {
    testView.transform =  CGAffineTransformMakeTranslation(320, 0);//设置testView位置
    //然后用动画填补初始位置与最终位置的过渡 有弹簧效果
    [UIView animateWithDuration:.6 delay:0.1 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
        testView.transform = CGAffineTransformIdentity;//最终位置
    } completion:NULL];

}


//下面的和上面的方法效果是不一样的，上面每次设置缩放的值得时候都会设置下transform的旋转位置
//如果改成CGAffineTransformScale试试看，应该缩放和旋转效果都是累加的
//-(void)CGAffineTransformAnimation:(UISlider *)currentSlider{
//    NSLog(@"sliderValue:%f",currentSlider.value);
//    float value=currentSlider.value;
//    testView.transform=CGAffineTransformRotate(testView.transform, M_PI_4);
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
