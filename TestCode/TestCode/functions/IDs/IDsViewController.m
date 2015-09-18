//
//  IDsViewController.m
//  TestCode
//
//  Created by Encoder on 15/9/14.
//  Copyright (c) 2015年 Encoder. All rights reserved.
//

#import "IDsViewController.h"

@interface IDsViewController ()

@end

@implementation IDsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"UUID:%@",[self getUUID]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSString *)getUUID{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

@end
