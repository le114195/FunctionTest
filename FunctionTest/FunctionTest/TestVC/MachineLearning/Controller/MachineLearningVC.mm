//
//  MachineLearningVC.m
//  FunctionTest
//
//  Created by 勒俊 on 2016/11/22.
//  Copyright © 2016年 勒俊. All rights reserved.
//

#import "MachineLearningVC.h"
#import "SVMAPI.hpp"

@interface MachineLearningVC ()

@end

@implementation MachineLearningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    api_test();
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
