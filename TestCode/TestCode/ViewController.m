//
//  ViewController.m
//  TestCode
//
//  Created by Encoder on 15/8/21.
//  Copyright (c) 2015年 Encoder. All rights reserved.
//

#import "ViewController.h"
#import "TrafficCountViewController.h"
#import "MemoryTool.h"
@interface ViewController (){
    NSArray *functionNameArray;
}
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    functionNameArray=[NSArray arrayWithObjects:
                       @"流量统计",
                       @"内存占用",
                   nil];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseCellIdn"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"reuseCellIdn"];
    cell.textLabel.text=[functionNameArray objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return functionNameArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:{
            TrafficCountViewController *vc=[[TrafficCountViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"信息"
                                                                                   message:[NSString stringWithFormat:@"设备可用内存：%f\n当前程序占用内存：%f",[MemoryTool availableMemory],[MemoryTool usedMemory]]
                                                                            preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction=[UIAlertAction actionWithTitle:@"确定"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                              }];
            [alertController addAction:alertAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        default:
            break;
    }
}


@end
