//
//  ImgViewDraw.m
//  FunctionTest
//
//  Created by 勒俊 on 16/9/3.
//  Copyright © 2016年 勒俊. All rights reserved.
//

#import "ImgViewDraw.h"


@interface ImgViewDraw ()

@property (nonatomic, assign) CGMutablePathRef      path;
@property (strong, nonatomic) NSMutableArray        *pathArray;
@property (nonatomic, assign) BOOL                  isHavePath;

@end


@implementation ImgViewDraw


- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIBezierPath *path in self.pathArray) {
        CGContextAddPath(context, path.CGPath);
        
        //设置线条的宽度
        CGContextSetLineWidth(context, 10);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    
    if (_isHavePath) {
        CGContextAddPath(context, _path);
        
        //设置线条的宽度
        CGContextSetLineWidth(context, 10);
        
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextDrawPath(context, kCGPathStroke);
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location =[touch locationInView:self];
    _path = CGPathCreateMutable();
    CGPathMoveToPoint(_path, NULL, location.x, location.y);
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    CGPathAddLineToPoint(_path, NULL, location.x, location.y);
    _isHavePath = YES;
    
    
    
    
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_pathArray == nil) {
        _pathArray = [NSMutableArray array];
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:_path];
    [_pathArray addObject:path];
    CGPathRelease(_path);
    
    _isHavePath = NO;
    
}


@end
