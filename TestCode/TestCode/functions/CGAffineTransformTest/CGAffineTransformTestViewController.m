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
}

@end

@implementation CGAffineTransformTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)CGAffineTransformMakeScaleAction:(id)sender {
    testView.transform=CGAffineTransformMakeScale(0.7,0.7);
}
- (IBAction)CGAffineTransformScaleAction:(id)sender {
    testView.transform=CGAffineTransformScale(testView.transform,0.5,0.5);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
