//
//  AnimationVC.m
//  FunctionTest
//
//  Created by 勒俊 on 16/8/27.
//  Copyright © 2016年 勒俊. All rights reserved.
//

#import "AnimationVC.h"

@interface AnimationVC ()


@property (nonatomic, weak) UIView                      *redView;

@end

@implementation AnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [self.view addSubview:redView];
    redView.backgroundColor = [UIColor redColor];
    self.redView = redView;
    
    
    UIView *redView1 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [self.view addSubview:redView1];
    redView1.backgroundColor = [UIColor redColor];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/** 抛物线运动动画 */
- (void)position {
    
    CAKeyframeAnimation *keyframeAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, self.redView.center.x, self.redView.center.y);//移动到起始点
    CGPathAddQuadCurveToPoint(path, NULL, 200, 200, self.redView.center.x, 400);
    keyframeAnimation.path = path;
    CGPathRelease(path);
    keyframeAnimation.duration = 3;
    [self.redView.layer addAnimation:keyframeAnimation forKey:@"KCKeyframeAnimation_Position"];
}



/** 抛物线运动、旋转、放缩动画组合*/
- (void)positionWithView:(UIView *)view height:(CGFloat)height {
    
    CAKeyframeAnimation *keyframeAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, view.center.x, view.center.y);//移动到起始点
    CGPathAddQuadCurveToPoint(path, NULL, 100, 150, 47.5, height);
    keyframeAnimation.path = path;
    CGPathRelease(path);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:0.5]; // 结束时的倍率
    
    
    // 对Y轴进行旋转
    CABasicAnimation *rotationAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // 设定旋转角度
    rotationAni.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
    rotationAni.toValue = [NSNumber numberWithFloat:2 * M_PI]; // 终止角度
    
    
    /* 动画组 */
    CAAnimationGroup *group = [CAAnimationGroup animation];
    // 动画选项设定
    group.duration = 0.45;
    group.repeatCount = 1;
    group.autoreverses = NO;
    group.animations = [NSArray arrayWithObjects:keyframeAnimation, animation, rotationAni, nil];
    
    [view.layer addAnimation:group forKey:@"KCKeyframeAnimation_Position"];
    
}





- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self position];
}





@end
