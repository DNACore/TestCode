//
//  iTunesBackupHandlerViewController.m
//  TestCode
//
//  Created by Encoder on 15/9/1.
//  Copyright (c) 2015年 Encoder. All rights reserved.
//

#import "iTunesBackupHandlerViewController.h"

@interface iTunesBackupHandlerViewController (){
    NSFileManager *fileManager;
    NSString *documentsDir;
    NSData *ManifestmbdbData;
}

@end

@implementation iTunesBackupHandlerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    fileManager=[NSFileManager defaultManager];
//    documentsDir=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    ManifestmbdbData=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/Manifest.mbdb",documentsDir]];
//    [self subData];
//    [self getDomain];
//    NSLog(@"%@",[self getDomain]);
    [self asyncInSync];
}

//同步套异步 为什么先打印主线程再打印主线程的耗时操作
-(void)asyncInSync{
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            //主线程更新界面
            for (int i = 0; i<100; i++) {
                NSLog(@"🌲主线程耗时操作：%i",i);
            }
        });
        for (int i = 0; i<100; i++) {
            NSLog(@"❤️副线程耗时操作：%i",i);
        }
    });
    for (int i = 0; i<100; i++) {
        NSLog(@"😄主线程耗时操作：%i",i);
    }
}

-(void)subData{
    NSData *subData=[ManifestmbdbData subdataWithRange:NSMakeRange(0, 6)];
    NSString *str=[[NSString alloc]initWithData:subData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
}

-(NSString *)getDomain{
    Byte* numArray1=(Byte *)[[ManifestmbdbData subdataWithRange:NSMakeRange(6, 1)] bytes];
    Byte* numArray2=(Byte *)[[ManifestmbdbData subdataWithRange:NSMakeRange(7, 1)] bytes];
    Byte num1=numArray1[0];
    Byte num2=numArray2[0];
    if ((num1==0xff)&&(num2==0xff)) {
        return @"";
    }
    int num3=(num1*0x100)+num2;
    return [[NSString alloc]initWithData:[ManifestmbdbData subdataWithRange:NSMakeRange(8, num3)] encoding:NSUTF8StringEncoding];
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

@end
