//
//  DrawRectTestView.m
//  TestCode
//
//  Created by Encoder on 15/9/18.
//  Copyright (c) 2015年 Encoder. All rights reserved.
//

#import "DrawRectTestView.h"

@implementation DrawRectTestView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    //画正方形
    CGContextSetRGBFillColor(context, 0, 0.25, 0, 0.5);
    CGContextFillRect(context, CGRectMake(2, 2, 270, 270));
    CGContextStrokePath(context);//划路径
    
    // 画一条线
    CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 0.5);//线条颜色
    CGContextMoveToPoint(context, 20, 20);
    CGContextAddLineToPoint(context, 200,200);
    CGContextSetLineWidth(context, 20.0);
    CGContextStrokePath(context);
    
    // 画正方形边框
    CGContextSetRGBStrokeColor(context, 1, 0, 1.0, 1.0);
    CGContextSetLineWidth(context, 2.0);
    CGContextAddRect(context, CGRectMake(2, 2, 270, 270));
    CGContextStrokePath(context);
    
    //CGContextRelease(context); 这句不要加，因为我们没有retain context。加了反而会出问题。
}

-(void)dealloc{
    LogFuncPrint;
}

@end
