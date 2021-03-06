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

/**
 *  移动动画
 */
- (void)positionAni
{
    /* 移动 */
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    // 动画选项的设定
    animation.duration = 1.0; // 持续时间
    animation.repeatCount = 5; // 重复次数
    animation.autoreverses = YES;
    // 起始帧和终了帧的设定
    animation.fromValue = [NSValue valueWithCGPoint:self.redView.layer.position]; // 起始帧
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.redView.layer.position.x, self.redView.layer.position.y + 20)]; // 终了帧
    
    // 添加动画
    [self.redView.layer addAnimation:animation forKey:@"move-layer"];
    
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
    
    
    CATransform3D rotate = CATransform3DMakeRotation(M_PI/6, 0, 1, 0);
    self.redView.layer.transform = CATransform3DPerspect(rotate, CGPointMake(0, 0), 200);

}




CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}




@end
