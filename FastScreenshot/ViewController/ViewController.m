//
//  ViewController.m
//  FastScreenshot
//
//  Created by GQuEen on 17/2/28.
//  Copyright © 2017年 GegeChen. All rights reserved.
//

#import "ViewController.h"
#import "AboutViewController.h"
#import <Photos/Photos.h>

@interface ViewController ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIBarButtonItem *aboutBarButtonItem;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"测试";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.imageView];
    self.navigationItem.rightBarButtonItem = self.aboutBarButtonItem;
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
    NSLog(@"%@",assetsFetchResults);
    
    PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
    PHAsset *asset = assetsFetchResults[2];
    [imageManager requestImageForAsset:asset
                            targetSize:PHImageManagerMaximumSize
                           contentMode:PHImageContentModeAspectFill
                               options:nil
                         resultHandler:^(UIImage *result, NSDictionary *info) {
                             
                             // 得到一张 UIImage，展示到界面上
                             self.imageView.image = result;
                             
                         }];
    
    UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    im.backgroundColor = [UIColor redColor];
    [self.view addSubview:im];
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
//创建导航栏右按钮（关于）
- (UIBarButtonItem *)aboutBarButtonItem {
    if (!_aboutBarButtonItem) {
        UIButton *aboutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        aboutBtn.frame = CGRectMake(0, 0, 20, 20);
        [aboutBtn setImage:[UIImage imageNamed:@"nav_about"] forState:UIControlStateNormal];
        [aboutBtn addTarget:self action:@selector(clickRightBarButtonItem:) forControlEvents:UIControlEventTouchUpInside];
        _aboutBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:aboutBtn];
    }
    return _aboutBarButtonItem;
}
//点击关于按钮跳转页面
- (void)clickRightBarButtonItem:(UIButton *)sender {
    AboutViewController *avc = [[AboutViewController alloc]init];
    [self.navigationController pushViewController:avc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
