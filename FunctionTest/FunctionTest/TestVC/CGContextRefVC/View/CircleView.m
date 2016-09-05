//
//  CircleView.m
//  FunctionTest
//
//  Created by 勒俊 on 16/9/5.
//  Copyright © 2016年 勒俊. All rights reserved.
//

#import "CircleView.h"

#define CircleR         30


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
    NSValue *value = [NSValue valueWithCGPoint:location];
    
    self.currentPoint = location;
    
    [self.pointArrM addObject:value];
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    NSValue *value = [NSValue valueWithCGPoint:location];
    
    
//    [self distance:location];
    
    double angle = atan((location.y - self.currentPoint.y) / (location.x - self.currentPoint.x));
    CGFloat distance = hypot(fabs(location.y - self.currentPoint.y), fabs(location.x - self.currentPoint.x));
    if (fabs(self.angle - angle) < 0.5 && distance < CircleR) {
        return;
    }
    self.angle = angle;
    self.currentPoint = location;
    
    
    [self.pointArrM addObject:value];
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
    
    [[UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.2] set];
    
    CGContextFillPath(context);
    
}


- (CGRect)circleWithPoint:(CGPoint)point speed:(CGFloat)speed
{
    CGFloat r = 1 / speed;
    CGRect rect = CGRectMake(point.x - r, point.y - r, r, r);
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
