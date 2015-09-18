//
//  BlockTest.m
//  TestCode
//
//  Created by Encoder on 15/8/26.
//  Copyright (c) 2015年 Encoder. All rights reserved.
//

#import "BlockTest.h"

@implementation BlockTest

-(void)blockTest{
//    [self type1];
//    [self type2];
    [self type3];
    [self type4];
    [self aBlock:^(int param) {
        NSLog(@"block的参数值：%i",param);
    }];
    [self bBlock:^int(int param) {
        NSLog(@"block的参数值：%i",param);
        return param;
    }];
}

//^(传入参数列){行为主体};
-(void)type1{
    ^(int a){return a*a;};//这只是一个定义 声明看type2
    int result=^(int a){return a*a;}(5);
    NSLog(@"%d", result);
}

//回传值(^名字)(参数列);
-(void)type2{
    //声明一个名为square的Block Pointer，其所指向的Block有一个int输入和int输出：这里的square是个被声明的变量，如果没有这一句，会提示square未被声明
    int (^square)(int);
    //将Block实体指定给square
    square = ^(int a){ return a*a ; };
    //调用方法，感觉是是不是很像function的用法？
    int result = square(5);
    NSLog(@"%d", result);
}

-(void)type3{
        int outA = 8;
        int (^myPtr)(int) = ^(int a){ return outA + a;};//声明和定义写在了一起
        //block里面可以读取同一类型的outA的值
        int result = myPtr(3);  // result is 11
        NSLog(@"result=%d", result);
}

-(void)type4{
    int outA = 8;
    int (^myPtr)(int) = ^(int a){ return outA + a;}; //block里面可以读取同一类型的outA的值
    
    outA = 5;  //在调用myPtr之前改变outA的值
    int result = myPtr(3);  // result的值仍然是11，并不是8
    NSLog(@"result=%d", result);
}

-(void)aBlock:(void(^)(int param))block{
    block(5*5);
}

-(void)bBlock:(int(^)(int param))block{
   int blockResult = block(6*5);
    NSLog(@"blockResult = %i",blockResult);
}

@end
