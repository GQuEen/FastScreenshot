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
#import "GGShareMenuView.h"


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
    
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    testBtn.frame = CGRectMake(100, 300, 100, 30);
    [testBtn setBackgroundColor:[UIColor redColor]];
    [testBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)clickBtn:(UIButton *)sender {
    
//    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.isShow = NO;
//    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxItemIconWidth = 53;
//    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxItemIconHeight = 53;
//    
//    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxRowCountForLandscapeAndBottom = 2;
//    
//    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForLandscapeAndBottom = 3;
//    
//    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewBackgroundColor = [UIColor whiteColor];
//    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageBGColor = [UIColor whiteColor];
//    
//    [UMSocialShareUIConfig shareInstance].shareCancelControlConfig.shareCancelControlBackgroundColor = [UIColor whiteColor];
//    [UMSocialShareUIConfig shareInstance].shareCancelControlConfig.shareCancelControlText = @"取消";
    
//    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//        // 根据获取的platformType确定所选平台进行下一步操作
//        NSLog(@"%@",userInfo);
//        
//    }];
    NSLog(@"点击");
    GGShareMenuView *shareMenuView = [[GGShareMenuView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
    
    [shareMenuView showShareMenuViewInWindowWithPlatformSelectionBlock:^(GGSocialPlatformType platformType) {
        NSLog(@"wqdqw");
    }];
    
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
