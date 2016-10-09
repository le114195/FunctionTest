//
//  DemoView2.m
//  FunctionTest
//
//  Created by 勒俊 on 16/9/29.
//  Copyright © 2016年 勒俊. All rights reserved.
//

#import "DemoView2.h"

@implementation DemoView2




- (void)drawRect:(CGRect)rect {
    [self drawLine];
}


- (void)drawLine
{
    //提示 使用ref的对象不用使用*
    //1.获取上下文.-UIView对应的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //2.创建可变路径并设置路径
    //当我们开发动画的时候，通常制定对象运动的路线，然后由动画负责动画效果
    CGMutablePathRef path = CGPathCreateMutable();
    //2-1.设置起始点
    CGPathMoveToPoint(path, NULL, 50, 50);
    //2-2.设置目标点
    CGPathAddLineToPoint(path, NULL, 50, 200);
    
    CGPathAddLineToPoint(path, NULL, 200, 200);

    
    CGPathAddLineToPoint(path, NULL, 200, 50);
    
    CGPathCloseSubpath(path);
    
    //3.将路径添加到上下文
    CGContextAddPath(context, path);
    
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 0, 1.0);

    //4.2 设置线条宽度
    CGContextSetLineWidth(context, 3.0f);
    
    
    //设置线条顶点样式
    CGContextSetLineCap(context, kCGLineCapRound);
    
    //设置连接点的样式
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    //6.释放路径
    CGPathRelease(path);
}



@end
