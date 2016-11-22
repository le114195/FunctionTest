//
//  GestureVC.m
//  FunctionTest
//
//  Created by 勒俊 on 16/8/10.
//  Copyright © 2016年 勒俊. All rights reserved.
//

#import "GestureVC.h"


typedef NS_ENUM(NSInteger, DirectionOption){
    DirectionOptionNon,
    DirectionOptionVertical,
    DirectionOptionHorizonal,
    DirectionOptionStatic,
};


@interface GestureVC ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) DirectionOption   panDirection;

@end

@implementation GestureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];
    

    
    // Do any additional setup after loading the view, typically from a nib.
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)panAction:(UIGestureRecognizer *)gesture
{
    CGPoint location = [gesture locationInView:self.view];
    static CGPoint startPoint;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        startPoint = location;
        self.panDirection = DirectionOptionNon;
        
    }else if (gesture.state == UIGestureRecognizerStateChanged) {
        
        switch (self.panDirection) {
            case DirectionOptionNon:{
                NSLog(@"DirectionOptionNon");
                
                if (fabs(location.y - startPoint.y) > 20) {
                    self.panDirection = DirectionOptionVertical;
                }
                if (fabs(location.x - startPoint.x) > 20) {
                    self.panDirection = DirectionOptionHorizonal;
                }
                break;
            }
                
            case DirectionOptionVertical:{
                NSLog(@"DirectionOptionVertical");
                
                
                break;
            }
                
            case DirectionOptionHorizonal:{
                NSLog(@"DirectionOptionHorizonal");
                
                
                break;
            }
            case DirectionOptionStatic:{
                NSLog(@"DirectionOptionStatic");
                break;
            }
            default:
                break;
        }
    }else {
        
        
    }
}





@end
