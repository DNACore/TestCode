//
//  MusicPlayViewController.m
//  TestCode
//
//  Created by Encoder on 15/12/7.
//  Copyright © 2015年 Encoder. All rights reserved.
//

#import "MusicPlayViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Waver.h"
@interface MusicPlayViewController (){
    AVAudioPlayer *player;
    __weak IBOutlet Waver *wave;
    __weak IBOutlet UIProgressView *playProgressView;
}

@end

@implementation MusicPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
- (IBAction)playAndPauseButtonAction:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"播放"]) {
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        [self playMusic:@"Liekkas - Sofia Jannok.mp3"];
    }
    else{
        [sender setTitle:@"播放" forState:UIControlStateNormal];
        [self pauseMusic:@""];
    }
}

-(BOOL)playMusic:(NSString *)musicName{
    if (!musicName) {
        return NO;
    }
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0],musicName];
    NSError *err;
    NSData *musicData=[NSData dataWithContentsOfFile:filePath];
    player=[[AVAudioPlayer alloc]initWithData:musicData error:&err];
    player.meteringEnabled=YES;
    player.volume = 0.5 ;
    if (![player isPlaying]) {
        [player play];
        __block AVAudioPlayer *weakPlayer = player;
        wave.waverLevelCallback = ^(Waver *waver){
            [weakPlayer updateMeters];
            CGFloat normalizedValue = pow (10, [weakPlayer averagePowerForChannel:0]/20);
            
            waver.level = normalizedValue;
        };
    }
    
    return YES;
}

-(void)pauseMusic:(NSString *)musicName{
    [player pause];
}

@end
