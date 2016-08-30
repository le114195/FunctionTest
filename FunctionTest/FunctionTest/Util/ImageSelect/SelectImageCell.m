//
//  SelectImageCell.m
//  FunctionTest
//
//  Created by 勒俊 on 16/8/30.
//  Copyright © 2016年 勒俊. All rights reserved.
//

#import "SelectImageCell.h"

@implementation SelectImageCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        
        UIImageView *selectImagView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.selectImagView = selectImagView;
        
        selectImagView.contentMode = UIViewContentModeScaleAspectFit;
        
        selectImagView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
        
        [self.contentView addSubview:selectImagView];
        
    }
    return self;
}


@end
