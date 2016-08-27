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




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self position];
}





@end
