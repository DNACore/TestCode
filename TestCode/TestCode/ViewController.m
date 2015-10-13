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
#import "CGAffineTransformTestViewController.h"
#import "BlockTest.h"
#import "WKWebViewTestViewController.h"
#import "iTunesBackupHandlerViewController.h"
#import "LayerMaskTestViewController.h"
#import "ParentViewController.h"
#import "IDsViewController.h"
#import "DrawRectTestViewController.h"
#import "BluetoothViewController.h"
#import "ScrollViewTestViewController.h"
#import "AnimationViewController.h"
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
                       @"动画演示 CGAffineTransform",
                       @"Block的使用",
                       @"WKWebViewTest",
                       @"iTunes备份处理",
                       @"LayerMastTest",
                       @"AddChildVCTest",
                       @"IDs",
                       @"- (void)drawRect:(CGRect)rect",
                       @"蓝牙测试",
                       @"ScrollViewTestViewController",
                       @"Animation动画",
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
            break;
        case 2:{
            CGAffineTransformTestViewController *vc=[[CGAffineTransformTestViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{
            BlockTest *test=[[BlockTest alloc]init];
            [test blockTest];
        }
            break;
        case 4:{
            WKWebViewTestViewController *vc=[[WKWebViewTestViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:{
            iTunesBackupHandlerViewController *vc=[[iTunesBackupHandlerViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:{
            LayerMaskTestViewController *vc=[[LayerMaskTestViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 7:{
            ParentViewController *vc=[[ParentViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 8:{
            IDsViewController *vc=[[IDsViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 9:{
            DrawRectTestViewController *vc=[[DrawRectTestViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10:{
            BluetoothViewController *vc=[[BluetoothViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 11:{
            ScrollViewTestViewController *vc=[[ScrollViewTestViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 12:{
            UIStoryboard *animationStoryBoard=[UIStoryboard storyboardWithName:@"AnimationStoryboard" bundle:nil];
            UIViewController *vc = [animationStoryBoard instantiateViewControllerWithIdentifier:@"AnimationViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;

    CGFloat alpha = fabs(yOffset)/88.f;
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor orangeColor]colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}


@end
