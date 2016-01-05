//
//  IDsViewController.m
//  TestCode
//
//  Created by Encoder on 15/9/14.
//  Copyright (c) 2015年 Encoder. All rights reserved.
//

#import "IDsViewController.h"

//for mac
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

//for idfa
#import <AdSupport/AdSupport.h>

@interface IDsViewController (){
    __weak IBOutlet NSLayoutConstraint *textFieldBottonC;
    __weak IBOutlet UITextField *textField;
    CAGradientLayer *clayer;
}

@end

@implementation IDsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"UUID:%@",[self getUUID]);
    NSLog(@"MAC 地址：%@",[self macString]);
    NSLog(@"IDFA :%@",[self idfaString]);
    NSLog(@"IDFV :%@",[self idfvString]);
    
    NSLog(@"NSUserName()：%@",NSUserName());
    NSLog(@"NSFullUserName()：%@",NSFullUserName());
    NSLog(@"NSHomeDirectory()：%@",NSHomeDirectory());
    NSLog(@"[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]:%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]);
    
    //获取手机名字
    NSLog(@"手机名字：%@",[[UIDevice currentDevice] name]);
    
    [self addTextView];
    
    [self progressLayer];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboardInfo:) name:UIKeyboardAnimationCurveUserInfoKey object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboardInfo:) name:UIKeyboardAnimationDurationUserInfoKey object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboardInfo:) name:UIKeyboardDidChangeFrameNotification object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboardInfo:) name:UIKeyboardDidHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboardInfo:) name:UIKeyboardDidShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboardInfo:) name:UIKeyboardFrameBeginUserInfoKey object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboardInfo:) name:UIKeyboardFrameEndUserInfoKey object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboardInfo:) name:UIKeyboardIsLocalUserInfoKey object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboardInfo:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboardInfo:) name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboardInfo:) name:UIKeyboardWillShowNotification object:nil];
}
- (IBAction)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [clayer removeAllAnimations];
    clayer=nil;
    [super viewWillDisappear:animated];
}

-(void)dealloc{
    LogFuncPrint;
}

-(void)addTextView{
    NSLog(@"%f",self.view.frame.size.width);
    textField.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:textField];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)showKeyboardInfo:(NSNotification *)notifiction{
    NSLog(@"%@",notifiction);
    if ([notifiction.name isEqualToString:@"UIKeyboardWillChangeFrameNotification"]) {
//        CGRect keyboardBeginFrame=[[notifiction.userInfo objectForKey:@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
        CGRect keyboardEndFrame=[[notifiction.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
//        float keyboardBeginOriginY=keyboardBeginFrame.origin.y;
//        float keyBoardBeginHeight=keyboardBeginFrame.size.height;
        float keyboardEndOriginY=keyboardEndFrame.origin.y;
//        float keyBoardEndHeight=keyboardEndFrame.size.height;
        [UIView animateWithDuration:0.25 animations:^{
            textFieldBottonC.constant=667.0-keyboardEndOriginY;
//            textField.frame=CGRectMake(0, textFieldBottonC.constant+textField.frame.size.height, textField.frame.size.width, textField.frame.size.height);
        }];
    }
}

//UUID生成方法很多种，这里只写出一种。
//每次生成均不一样，所以第一次生成后需要保存到钥匙串，这样即使应用删除再重装仍然可以从钥匙串得到它。
-(NSString *)getUUID{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

#pragma mark - 加载进度条
-(void)progressLayer{
    // Use a horizontal gradient
    CAGradientLayer *layer = [CAGradientLayer layer];
    clayer=layer;
    layer.frame=CGRectMake(0, 80, 320, 20);
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

- (NSString * )macString{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return macString;
}

/*
 
 idfa（Advertising Identifier）:可以理解为广告id，apple公司提供的用于追踪用户的广告标识符。
 
 缺点：用户可通过设置-隐私-广告-还原广告标识符 还原，之后会得新的到标识符；
 
 要求iOS>=6.0。
 */

- (NSString *)idfaString {
    
    NSBundle *adSupportBundle = [NSBundle bundleWithPath:@"/System/Library/Frameworks/AdSupport.framework"];
    [adSupportBundle load];
    
    if (adSupportBundle == nil) {
        return @"";
    }
    else{
        
        Class asIdentifierMClass = NSClassFromString(@"ASIdentifierManager");
        
        if(asIdentifierMClass == nil){
            return @"";
        }
        else{
            
            //for no arc
            //ASIdentifierManager *asIM = [[[asIdentifierMClass alloc] init] autorelease];
            //for arc
            ASIdentifierManager *asIM = [[asIdentifierMClass alloc] init];
            
            if (asIM == nil) {
                return @"";
            }
            else{
                
                if(asIM.advertisingTrackingEnabled){
                    return [asIM.advertisingIdentifier UUIDString];
                }
                else{
                    return [asIM.advertisingIdentifier UUIDString];
                }
            }
        }
    }
}

/*
 idfv （identifierForVendor）:apple提供给Vendor的唯一标识符，Vendor代表了应用开发商，实际使用时，一个Vendor是CFBundleIdentifier（反转DNS格式）的前两部分。例如，com.baidu.tieba 和 com.baidu.image 得到的idfv是相同的，因为它们的CFBundleIdentifier 前两部分是相同的。
 缺点：把同一个开发商的所有应用卸载后，再次安装取到的idfv会不同。假设手机上装有公司的两款app:贴吧、
 要求：iOS>=6.0
 */
- (NSString *)idfvString
{
    if([[UIDevice currentDevice] respondsToSelector:@selector( identifierForVendor)]) {
        return [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    return @"";
}


@end
