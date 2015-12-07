//
//  IDsViewController.m
//  TestCode
//
//  Created by Encoder on 15/9/14.
//  Copyright (c) 2015年 Encoder. All rights reserved.
//

#import "IDsViewController.h"

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

-(NSString *)getUUID{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
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

@end
