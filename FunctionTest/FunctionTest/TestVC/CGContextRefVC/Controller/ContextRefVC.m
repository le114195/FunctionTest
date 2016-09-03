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

@interface ContextRefVC ()


@property (nonatomic, strong) ImgViewDraw           *imgView;

@property (nonatomic, strong) ImagePicker           *imgPicker;


@end

@implementation ContextRefVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
//    DemoView1 *demo1 = [[DemoView1 alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height - 64)];
//    demo1.backgroundColor = [UIColor redColor];
//    [self.view addSubview:demo1];
    
    
    self.imgView = [[ImgViewDraw alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height - 64)];
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.imgView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.imgView];
    
    
    
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, Screen_Height - 44, 60, 44)];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"换图" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(changImg) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 子控件初始化



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





@end
