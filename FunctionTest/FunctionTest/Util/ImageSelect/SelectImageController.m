//
//  SelectImageController.m
//  FunctionTest
//
//  Created by 勒俊 on 16/8/30.
//  Copyright © 2016年 勒俊. All rights reserved.
//

#import "SelectImageController.h"
#import "Masonry.h"
#import <Photos/Photos.h>

@interface SelectImageController ()


/** 相册 */
@property (nonatomic, strong) PHAssetCollection         *assetCollection;


@end

@implementation SelectImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self getAllFetchResult];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 子控件初始化

- (void)subViewConfigure {
    
    
}


- (void)naviConfigure {
    UIView *naviView = [[UIView alloc] init];
    [self.view addSubview:naviView];
    [naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(0);
        make.right.offset(0);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *rightBtn  = [[UIButton alloc] init];
    [naviView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.centerY.mas_equalTo(naviView.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(44);
    }];
    rightBtn.backgroundColor = [UIColor clearColor];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - 数据初始化






#pragma mark - set/get






#pragma mark - 点击事件

- (void)rightAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}






#pragma mark - 代理方法








#pragma mark - 私有方法
/** 获取相册中的所有结果图 */
- (void)test {
    
    //对相册中的结果进行排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *fetchRs = [PHAsset fetchAssetsInAssetCollection:self.assetCollection options:options];

    //遍历所有的结果图
    for (PHAsset *assert in fetchRs) {
        [[PHImageManager defaultManager] requestImageForAsset:assert targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSNumber *PHImageResultIsDegradedKey = [info valueForKey:@"PHImageResultIsDegradedKey"];
            if (PHImageResultIsDegradedKey.intValue == 0) {
                
            }
        }];
    }
}


/** 获得所有的相册，并获取所有相片的相册 */
- (void)getAllFetchResult {
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    int count = 0;
    
    for (int i = 0; i < smartAlbums.count; i++) {
        PHCollection *collection = smartAlbums[i];
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            
            //获取相册
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            
            //获取相册中所有的结果
            PHFetchResult *fetchRs = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
            
            if (count < fetchRs.count) {
                self.assetCollection = assetCollection;
            }
            
        }
    }
}



- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
