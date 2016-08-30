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
#import "SelectImageCell.h"

#define ImageWidth          (Screen_Width - 40) / 3



@interface SelectImageController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (nonatomic, weak) UICollectionView            *collectionView;

/** 相册 */
@property (nonatomic, strong) PHAssetCollection         *assetCollection;

@property (nonatomic, strong) PHFetchResult             *fetchRs;


@property (nonatomic, copy) CompletionBlock             completion;

@end

@implementation SelectImageController


+ (instancetype)selectImageWithCompletion:(CompletionBlock)completion
{
    SelectImageController *selectVC = [[SelectImageController alloc] init];
    
    selectVC.completion = completion;
    
    return selectVC;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self subViewConfigure];
    
    [self dataConfigure];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 子控件初始化

- (void)subViewConfigure {
    
    [self naviConfigure];
    
    [self collectionViewconfigure];
    
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
    
    [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)collectionViewconfigure {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize = CGSizeMake(ImageWidth, ImageWidth);
    
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;

    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, Screen_Width, Screen_Height - 44) collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[SelectImageCell class] forCellWithReuseIdentifier:@"SelectImageCell"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}




#pragma mark - 数据初始化

- (void)dataConfigure {
    
    [self getAllFetchResult];

    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *fetchRs = [PHAsset fetchAssetsInAssetCollection:self.assetCollection options:options];
    self.fetchRs = fetchRs;
    
}




#pragma mark - set/get






#pragma mark - 点击事件

- (void)rightAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}






#pragma mark - 代理方法


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (!self.fetchRs) {
        return 0;
    }
    return self.fetchRs.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectImageCell *selectCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectImageCell" forIndexPath:indexPath];
    
    PHAsset *assert = self.fetchRs[indexPath.row];
    [[PHImageManager defaultManager] requestImageForAsset:assert targetSize:CGSizeMake(300, 300) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        NSNumber *PHImageResultIsDegradedKey = [info valueForKey:@"PHImageResultIsDegradedKey"];
        if (PHImageResultIsDegradedKey.intValue == 1) {
            selectCell.selectImagView.image = result;
        }
    }];
    return selectCell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PHAsset *assert = self.fetchRs[indexPath.row];
    [[PHImageManager defaultManager] requestImageForAsset:assert targetSize:CGSizeMake(300, 300) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        NSNumber *PHImageResultIsDegradedKey = [info valueForKey:@"PHImageResultIsDegradedKey"];
        if (PHImageResultIsDegradedKey.intValue == 0) {
            if (self.completion) {
                if (result) {
                    self.completion(result, 1);
                }else {
                    self.completion(nil, -1);
                }
            }
        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 私有方法

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
