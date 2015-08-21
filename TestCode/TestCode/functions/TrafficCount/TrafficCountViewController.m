//
//  TrafficCountViewController.m
//  TestCode
//
//  Created by Encoder on 15/8/21.
//  Copyright (c) 2015年 Encoder. All rights reserved.
//
#import <ifaddrs.h>
#import <sys/socket.h>
#import <net/if.h>
#import "TrafficCountViewController.h"

@interface TrafficCountViewController ()

@end

@implementation TrafficCountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"移动数据流量：%i",getGprs3GFlowIOBytes());
    NSLog(@"WiFi数据流量：%lli",[self getInterfaceBytes]);
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
//移动数据流量
int getGprs3GFlowIOBytes() {//C函数命名方式
    
    struct ifaddrs *ifa_list= 0, *ifa;
    
    if (getifaddrs(&ifa_list)== -1) {
        return 0;
        
    }
    
    uint32_t iBytes =0;
    uint32_t oBytes =0;
    
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next)
    {
        
        if (AF_LINK!= ifa->ifa_addr->sa_family)
            continue;
        
        if (!(ifa->ifa_flags& IFF_UP) &&!(ifa->ifa_flags& IFF_RUNNING))
            continue;
        
        if (ifa->ifa_data== 0)
            continue;
        
        if (!strcmp(ifa->ifa_name,"pdp_ip0")) {
            
            struct if_data *if_data = (struct if_data*)ifa->ifa_data;
            
            iBytes += if_data->ifi_ibytes;
            oBytes += if_data->ifi_obytes;
            
            NSLog(@"%s :iBytes is %d, oBytes is %d",ifa->ifa_name, iBytes, oBytes);
            
        }
        
    }
    
    freeifaddrs(ifa_list);
    
    return iBytes + oBytes;
    
}

//WiFi流量
- (long long int)getInterfaceBytes {//OC方法命名方式
    
    struct ifaddrs *ifa_list = 0, *ifa;
    
    if (getifaddrs(&ifa_list) == -1) {
        return 0;
        
    }
    
    uint32_t iBytes = 0;
    uint32_t oBytes = 0;
    
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next) {
        
        if (AF_LINK != ifa->ifa_addr->sa_family)
            continue;
        
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            continue;
        
        if (ifa->ifa_data == 0)
            continue;
        
        /* Not a loopback device. */
        
        if (strncmp(ifa->ifa_name, "lo", 2))
            
        {
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            iBytes += if_data->ifi_ibytes;
            oBytes += if_data->ifi_obytes;
            //            NSLog(@"%s :iBytes is %d, oBytes is %d",
            //                  ifa->ifa_name, iBytes, oBytes);
            
        }
        
    }
    
    freeifaddrs(ifa_list);
    
    return iBytes+oBytes;
    
}

//单位换算
NSString* bytesToAvaiUnit(int bytes) {//C语言命名方式
    if(bytes < 1024)  // B
    {
        return [NSString stringWithFormat:@"%dB", bytes];
    }
    
    else if(bytes >= 1024 && bytes < 1024 * 1024) // KB
    {
        return [NSString stringWithFormat:@"%.1fKB", (double)bytes / 1024];
    }
    
    else if(bytes >= 1024 * 1024 && bytes < 1024 * 1024 * 1024) // MB
    {
        return [NSString stringWithFormat:@"%.2fMB", (double)bytes / (1024 * 1024)];
    }
    
    else // GB
    {
        return [NSString stringWithFormat:@"%.3fGB", (double)bytes / (1024 * 1024 * 1024)];
    }
}

@end
