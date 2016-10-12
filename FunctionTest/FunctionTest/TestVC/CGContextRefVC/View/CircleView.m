//
//  CircleView.m
//  FunctionTest
//
//  Created by 勒俊 on 16/9/5.
//  Copyright © 2016年 勒俊. All rights reserved.
//

#import "CircleView.h"
#import "PathFunc.h"

#define CircleR         8

#define Distance        20



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
    }else if (distance > Distance) {
        int count = distance / Distance;
        for (int i = 0; i < count; i++) {
            self.currentPoint = [PathFunc newPointWithLastLocation:self.currentPoint local:location distance:Distance];
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
