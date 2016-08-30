//
//  AlumTestVC.m
//  FunctionTest
//
//  Created by 勒俊 on 16/8/30.
//  Copyright © 2016年 勒俊. All rights reserved.
//

#import "AlumTestVC.h"
#import "Masonry.h"
#import "SelectImageController.h"

@interface AlumTestVC ()

@property (nonatomic, strong) UIImageView         *imgView;

@end

@implementation AlumTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imgView = [[UIImageView alloc] init];
    [self.view addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.top.offset(64);
        make.width.mas_equalTo(Screen_Width);
    }];
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    UIButton *button = [[UIButton alloc] init];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(45);
        make.bottom.offset(-10);
    }];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)clickBtn {
    
    SelectImageController *selectVC = [SelectImageController selectImageWithCompletion:^(id responseObject, int status) {
        
        UIImage *image = responseObject;
        
        self.imgView.image = image;
        
    }];
    
    [self presentViewController:selectVC animated:YES completion:nil];
    
}





@end
