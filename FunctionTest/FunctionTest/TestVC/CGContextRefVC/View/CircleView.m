//
//  CircleView.m
//  FunctionTest
//
//  Created by 勒俊 on 16/9/5.
//  Copyright © 2016年 勒俊. All rights reserved.
//

#import "CircleView.h"

#define CircleR         10

#define Distance        30



@interface CircleView ()

@property (nonatomic, strong) NSMutableArray        *pointArrM;
@property (nonatomic, strong) NSMutableArray        *speedArrM;

@property (nonatomic, assign) CGPoint               currentPoint;


/** 角度 */
@property (nonatomic, assign) float                 angle;


@end



@implementation CircleView



- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
    
    [self circleTest];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location =[touch locationInView:self];

    self.currentPoint = location;
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    
    double angle = atan((location.y - self.currentPoint.y) / (location.x - self.currentPoint.x));
    CGFloat distance = hypot(fabs(location.y - self.currentPoint.y), fabs(location.x - self.currentPoint.x));
    
    if (distance < 2 * CircleR) {
        return;
    }
    if (fabs(self.angle - angle) < M_PI_4 && distance < Distance) {
        return;
    }else if (fabs(self.angle - angle) < M_PI_4 && distance > Distance) {
        
        int count = distance / Distance;
        for (int i = 0; i < count; i++) {
            self.currentPoint = [self newPointWithLastLocation:self.currentPoint local:location distance:Distance];
            NSValue *value = [NSValue valueWithCGPoint:self.currentPoint];
            [self.pointArrM addObject:value];
        }
    }else {
        self.currentPoint = location;
        NSValue *value = [NSValue valueWithCGPoint:self.currentPoint];
        [self.pointArrM addObject:value];
    }
    self.angle = angle;

    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    
    
}


/**
 *  利用两点式得到一个一次函数，然后求出距离第一个点距离为distance 的点
 *
 *  @param lastLocation 第一个点
 *  @param location     第二个点
 *  @param distance     待求的点到第一个点的距离
 *
 *  @return 返回待求的点
 */
- (CGPoint)newPointWithLastLocation:(CGPoint)lastLocation local:(CGPoint)location distance:(float)distance
{
    float x0, y0, a, b, c, c0;
    float slope; //斜率
    
    double angle = atan((location.y - lastLocation.y) / (location.x - lastLocation.x));
    slope = tan(angle);
    
    c0 = location.y - tan(angle) * location.x;
    
    a = slope * slope + 1;
    b = 2 * slope * (c0 - lastLocation.y) - 2 * lastLocation.x;
    c = lastLocation.x * lastLocation.x + (c0 - lastLocation.y) * (c0 - lastLocation.y) - distance * distance;
    
    if (lastLocation.x < location.x) {
        x0 = (-b + sqrt(b * b - 4 * a * c)) / (2 * a);
    }else {
        x0 = (-b - sqrt(b * b - 4 * a * c)) / (2 * a);
    }
    y0 = slope * x0 + c0;
    
    return CGPointMake(x0, y0);
}



#pragma mark - speed
- (void)circleTest {
    
    
    //1.获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //2.绘制图形
    
    for (NSValue *value in self.pointArrM) {
        CGPoint point = [value CGPointValue];
        CGRect rect = [self circleWithPoint:point speed:0.05];
        CGContextAddEllipseInRect(context, rect);
    }
    
    CGContextFillPath(context);
    
}


- (CGRect)circleWithPoint:(CGPoint)point speed:(CGFloat)speed
{
    CGRect rect = CGRectMake(point.x - CircleR, point.y - CircleR, CircleR * 2, CircleR * 2);
    return rect;
}


#pragma mark - 等距
- (CGRect)distance:(CGPoint)point {

    CGRect rect;
    double angle = atan((point.y - self.currentPoint.y) / (point.x - self.currentPoint.x));
    CGFloat distance = hypot(fabs(point.y - self.currentPoint.y), fabs(point.x - self.currentPoint.x));
    if (fabs(self.angle - angle) < 0.5 && distance < CircleR) {
        
    }
    self.angle = angle;
    
    return rect;
}



#pragma mark -- set/get
- (NSMutableArray *)pointArrM
{
    if (!_pointArrM) {
        _pointArrM = [NSMutableArray array];
    }
    return _pointArrM;
}

- (NSMutableArray *)speedArrM
{
    if (!_speedArrM) {
        _speedArrM = [NSMutableArray array];
    }
    return _speedArrM;
}





@end
