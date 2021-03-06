//
//  ViewController.m
//  FunctionTest
//
//  Created by 勒俊 on 16/8/10.
//  Copyright © 2016年 勒俊. All rights reserved.
//

#import "ViewController.h"
#import "TestCell.h"
#import "GestureVC.h"
#import "AnimationVC.h"
#import "ContextRefVC.h"
#import "ImagePicker.h"
#import "SocketClientController.h"
#import "SocketServerController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView         *tableView;

@property (nonatomic, strong) NSArray           *dataArray;


@property (nonatomic, strong) ImagePicker       *imgPicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.dataArray = @[@"gestureVC", @"动画效果", @"画布", @"Socket"];
    
    [self tableViewConfigure];
    
    
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 子控件初始化
- (void)tableViewConfigure
{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerClass:[TestCell class] forCellReuseIdentifier:@"TestCell"];
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






#pragma mark - 代理方法


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.dataArray) {
        return 0;
    }else {
        return self.dataArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell" forIndexPath:indexPath];
    
    cell.nameLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:{//手势
            GestureVC *gestureVC = [[GestureVC alloc] init];
            [self.navigationController pushViewController:gestureVC animated:YES];
            break;
        }
        case 1:{//动画
            AnimationVC *animationVC = [[AnimationVC alloc] init];
            [self.navigationController pushViewController:animationVC animated:YES];
            break;
        }
        case 2:{//画布
            [self.imgPicker getOriginImage:self completion:^(id responseObject) {
               
                
            }];
            break;
        }
            
        case 3:{
            SocketClientController *socketVC = [[SocketClientController alloc] init];
            [self.navigationController pushViewController:socketVC animated:YES];
            
            break;
        };
            
        default:
            break;
    }
    
}



#pragma mark - 私有方法







@end
