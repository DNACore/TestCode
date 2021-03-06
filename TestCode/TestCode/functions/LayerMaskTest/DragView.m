//
//  DragView.m
//  TestCode
//
//  Created by Encoder on 15/9/2.
//  Copyright (c) 2015年 Encoder. All rights reserved.
//

#import "DragView.h"

@implementation DragView
{
    CGPoint startPoint;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //保存触摸起始点位置
    CGPoint point = [[touches anyObject] locationInView:self];
    startPoint = point;
    //[self.superview bringSubviewToFront:self];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //计算位移=当前位置-起始位置
    CGPoint point = [[touches anyObject] locationInView:self];
    float dx = point.x - startPoint.x;
    float dy = point.y - startPoint.y;
    
    //计算移动后的view中心点
    CGPoint newcenter = CGPointMake(self.center.x + dx, self.center.y + dy);
    
    
    /* 限制用户不可将视图托出屏幕 */
    float halfx = CGRectGetMidX(self.bounds);
    //x坐标左边界
    newcenter.x = MAX(halfx, newcenter.x);
    //x坐标右边界
    newcenter.x = MIN(self.superview.bounds.size.width - halfx, newcenter.x);
    
    //y坐标同理
    float halfy = CGRectGetMidY(self.bounds);
    newcenter.y = MAX(halfy, newcenter.y);
    newcenter.y = MIN(self.superview.bounds.size.height - halfy, newcenter.y);
    
    //移动view
    self.center = newcenter;
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0?true:false;
}

//- (void)drawRect:(CGRect)rect {
//    [super drawRect:rect];
//    UIBezierPath *p = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(_bottomLeftRadius?UIRectCornerBottomLeft:0)|(_bottomRightRadius?UIRectCornerBottomRight:0)|(_topLeftRadius?UIRectCornerTopLeft:0)|(_topRightRadius?UIRectCornerTopRight:0) cornerRadii:CGSizeMake(_cornerRadius, 0.f)];
//    CGContextRef c = UIGraphicsGetCurrentContext();
//    CGContextAddPath(c, p.CGPath);
//    CGContextClosePath(c);
//    CGContextClip(c);
//    CGContextAddRect(c, rect);
//    //CGContextSetFillColorWithColor(c, _bgColor.CGColor);
//    CGContextFillPath(c);
//}

//替换系统默认layer这个方法由系统自动调用来创建layer
+ (Class)layerClass {
    return [CAGradientLayer class];
}

@end
