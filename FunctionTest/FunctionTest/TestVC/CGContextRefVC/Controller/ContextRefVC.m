//
//  ContextRefVC.m
//  FunctionTest
//
//  Created by 勒俊 on 16/9/3.
//  Copyright © 2016年 勒俊. All rights reserved.
//

#import "ContextRefVC.h"
#import "DemoView1.h"
#import "ImgViewDraw.h"
#import "ImagePicker.h"
#import "CircleView.h"
#import "DemoView2.h"



@interface ContextRefVC ()


@property (nonatomic, strong) ImgViewDraw           *imgView;

@property (nonatomic, strong) ImagePicker           *imgPicker;

@property (nonatomic, weak) DemoView2               *demo2;

@property (nonatomic, assign) CGFloat               angle;

@end

@implementation ContextRefVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    DemoView2 *view2 = [[DemoView2 alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height - 64)];
    self.demo2 = view2;
    view2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view2];
    
    
    

//    DemoView1 *demo1 = [[DemoView1 alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height - 64)];
//    demo1.backgroundColor = [UIColor redColor];
//    [self.view addSubview:demo1];
    
    
//    self.imgView = [[ImgViewDraw alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height - 64)];
//    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
//    
//    self.imgView.backgroundColor = [UIColor grayColor];
//    
//    [self.view addSubview:self.imgView];
//    
//    
//    
//    
//    
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, Screen_Height - 44, 60, 44)];
//    [self.view addSubview:button];
//    button.backgroundColor = [UIColor redColor];
//    [button setTitle:@"换图" forState:UIControlStateNormal];
//    
//    [button addTarget:self action:@selector(changImg) forControlEvents:UIControlEventTouchUpInside];
//    DemoView1 *demo1 = [[DemoView1 alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height - 64)];
//    demo1.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:demo1];
    
    
//    [self circleTest];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 子控件初始化




- (void)circleTest {

    CircleView *circle = [[CircleView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height - 64)];
    [self.view addSubview:circle];
    circle.backgroundColor = [UIColor whiteColor];
    
}







#pragma mark - 数据初始化




#pragma mark - set/get


- (ImagePicker *)imgPicker
{
    if (!_imgPicker) {
        _imgPicker = [[ImagePicker alloc] init];
    }
    return _imgPicker;
}



#pragma mark - 点击事件

- (void)changImg {
    
    [self.imgPicker getOriginImage:self completion:^(id responseObject) {
        UIImage *image = (UIImage *)responseObject;
        self.imgView.image = image;
    }];
}


#pragma mark - 代理方法



#pragma mark - 私有方法




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.angle += M_PI_4;
    
    self.demo2.progress = self.angle;
    
}



@end
