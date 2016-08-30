//
//  AnimationVC.m
//  FunctionTest
//
//  Created by 勒俊 on 16/8/19.
//  Copyright © 2016年 勒俊. All rights reserved.
//

#import "AnimationVC.h"

@interface AnimationVC ()

@property(nonatomic,strong) UIView              *myView;


@end

@implementation AnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    
    [self.view addSubview:self.myView];
    
    self.myView.backgroundColor = [UIColor redColor];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* 放大缩小 */
    
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 动画选项设定
    animation.duration = 0.25; // 动画持续时间
    animation.repeatCount = 1; // 重复次数
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:2.0]; // 结束时的倍率
    
    // 添加动画
    [self.myView.layer addAnimation:animation forKey:@"scale-layer"];
}



@end
