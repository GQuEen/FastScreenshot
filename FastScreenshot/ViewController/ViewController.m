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

#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "WeiboSDK.h"

@interface ViewController ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonnull) UIImage *shareImage;
@property (strong, nonatomic) UIBarButtonItem *aboutBarButtonItem;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"快截图";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
//    [self.view addSubview:self.imageView];
    self.navigationItem.rightBarButtonItem = self.aboutBarButtonItem;
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
    NSLog(@"%@",assetsFetchResults);
    
    __weak typeof(self) weakSelf = self;
    PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
    PHAsset *asset = assetsFetchResults[2];
    [imageManager requestImageForAsset:asset
                            targetSize:PHImageManagerMaximumSize
                           contentMode:PHImageContentModeAspectFill
                               options:nil
                         resultHandler:^(UIImage *result, NSDictionary *info) {
                             
                             // 得到一张 UIImage，展示到界面上
//                             weakSelf.imageView.image = result;
                             weakSelf.shareImage = result;
                             
                         }];
    
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    testBtn.frame = CGRectMake(100, 200, 100, 30);
//    [testBtn setBackgroundColor:[UIColor redColor]];
    [testBtn setTitle:@"分享菜单" forState:UIControlStateNormal];
    [testBtn setTitleColor:IMAGE_COLOR forState:UIControlStateNormal];
    [testBtn sizeToFit];
    [testBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)clickBtn:(UIButton *)sender {

    GGShareMenuView *shareMenuView = [[GGShareMenuView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
    __weak typeof(self) weakSelf = self;
    [shareMenuView showShareMenuViewInWindowWithPlatformSelectionBlock:^(GGSocialPlatformType platformType) {
        [weakSelf shareToPlatformType:platformType];
    }];
    
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    NSString *message;
    
    if (!error) {
        
        message = @"成功保存到相册";
        
    }else {
        
        message = [error description];
        
    }
    
    NSLog(@"message is %@",message);
    
}
//分享操作接口

- (void)shareToPlatformType:(GGSocialPlatformType)platformType {
    if (platformType == GGSocialPlatformType_Sina) {
        NSLog(@"分享微博");
        //判断微博是否安装
        if ([WeiboSDK isWeiboAppInstalled]) {
            [self shareImageToPlatformType:0];
        }else {
            //未安装微博提示
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的设备没有安装微博" preferredStyle:UIAlertControllerStyleAlert];
            //为alert增加一个Action，
            UIAlertAction *okActin=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okActin];
            //显示
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else if (platformType == GGSocialPlatformType_WechatSession) {
        NSLog(@"分享微信");
        //判断微信是否安装
        if ([WXApi isWXAppInstalled]) {
            [self shareImageToPlatformType:1];
        }else {
            //未安装微信提示
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的设备没有安装微信" preferredStyle:UIAlertControllerStyleAlert];
            //为alert增加一个Action，
            UIAlertAction *okActin=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okActin];
            //显示
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else if (platformType == GGSocialPlatformType_WechatTimeLine) {
        NSLog(@"分享朋友圈");
        //判断微信是否安装
        if ([WXApi isWXAppInstalled]) {
            [self shareImageToPlatformType:2];
        }else {
            //未安装微信提示
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的设备没有安装微信" preferredStyle:UIAlertControllerStyleAlert];
            //为alert增加一个Action，
            UIAlertAction *okActin=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okActin];
            //显示
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else if (platformType == GGSocialPlatformType_QQ) {
        NSLog(@"分享QQ");
        //判断QQ是否安装
        if ([QQApiInterface isQQInstalled]) {
            [self shareImageToPlatformType:4];
        }else {
            //未安装QQ提示
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的设备没有安装QQ" preferredStyle:UIAlertControllerStyleAlert];
            //为alert增加一个Action，
            UIAlertAction *okActin=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okActin];
            //显示
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else if (platformType == GGSocialPlatformType_Down) {
        NSLog(@"保存本地");
        
        UIImageWriteToSavedPhotosAlbum(self.shareImage, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), NULL);
        
    }else if (platformType == GGSocialPlatformType_More) {
        NSLog(@"更多");
        //调用系统分享
        NSMutableArray *items = [[NSMutableArray alloc] init];
        [items addObject:@"分享图片"];
        [items addObject:self.shareImage];
        UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
        [self presentViewController:activityViewController animated:YES completion:nil];
    }

}

//分享操作
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
//    shareObject.thumbImage = [UIImage imageNamed:@"icon"];
    [shareObject setShareImage:self.shareImage];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
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
