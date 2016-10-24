//
//  DemoView2.m
//  FunctionTest
//
//  Created by 勒俊 on 16/9/29.
//  Copyright © 2016年 勒俊. All rights reserved.
//

#import "DemoView2.h"

@interface DemoView2 ()


@property (nonatomic, assign) CGFloat           lastProgress;

@end


@implementation DemoView2



- (void)drawRed
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1.0);//画笔线的颜色
    CGContextSetLineWidth(context, 2.0);//线的宽度
    CGContextAddArc(context, self.frame.size.width * 0.5 - 25, self.frame.size.height * 0.5 - 25, 50, 0, M_PI * 2, 1);
    CGContextDrawPath(context, kCGPathStroke);
}


- (void)drawRect:(CGRect)rect {
    [self drawRed];
    [self drawLine];
}

- (instancetype)init
{
    if ([super init]) {
        self.lastProgress = 0;
    }
    return self;
}


- (void)drawLine
{

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0, 1, 1, 1.0);//画笔线的颜色
    CGContextSetLineWidth(context, 2.0);//线的宽度
    CGContextAddArc(context, self.frame.size.width * 0.5 - 25, self.frame.size.height * 0.5 - 25, 50, 0, -self.progress, 1);
    CGContextDrawPath(context, kCGPathStroke);

}



- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}




@end
