//
//  ViewController.m
//  FastScreenshot
//
//  Created by GQuEen on 17/2/28.
//  Copyright © 2017年 GegeChen. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>

@interface ViewController ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
    
//    PHFetchResult *fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
//    NSLog(@"%@",fetchResult);
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
    NSLog(@"%@",assetsFetchResults);
    
    PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
    PHAsset *asset = assetsFetchResults[0];
    [imageManager requestImageForAsset:asset
                            targetSize:PHImageManagerMaximumSize
                           contentMode:PHImageContentModeAspectFill
                               options:nil
                         resultHandler:^(UIImage *result, NSDictionary *info) {
                             
                             // 得到一张 UIImage，展示到界面上
                             self.imageView.image = result;
                             
                         }];

    
//    for (NSInteger i = 0; i < fetchResult.count; i++) {
//            
//        //获取一个相册（PHAssetCollection）
//            
//        PHCollection *collection = fetchResult[i];
//            
//        if ([collection isKindOfClass:[PHAssetCollection class]]) {
//                
//            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
//                
//            //从每一个智能相册中获取到的 PHFetchResult 中包含的才是真正的资源（PHAsset）
//                
//            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
//            NSLog(@"1111%@",fetchResult);
//                
//        }else {
//                    
//            NSAssert(NO,@"Fetch collection not PHCollection: %@",collection);
//                    
//            
//                
//        }
//    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
        _imageView.backgroundColor = [UIColor greenColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
