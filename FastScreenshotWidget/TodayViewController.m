//
//  TodayViewController.m
//  FastScreenshotWidget
//
//  Created by GQuEen on 17/3/6.
//  Copyright © 2017年 GegeChen. All rights reserved.
//

#import "TodayViewController.h"
#import <Photos/Photos.h>
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.preferredContentSize = CGSizeMake(0, 110);
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 75, 90)];
    imageView1.backgroundColor = [UIColor greenColor];
    imageView1.contentMode = UIViewContentModeScaleAspectFill;
    imageView1.layer.cornerRadius = 5;
    imageView1.layer.masksToBounds = YES;
    
    NSLog(@"2121");
    
    [self.view addSubview:imageView1];
    
    //按时间顺序排序并获取资源
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
    //请求图片
    PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
    PHAsset *asset = assetsFetchResults[assetsFetchResults.count-2];
    [imageManager requestImageForAsset:asset
                            targetSize:PHImageManagerMaximumSize
                           contentMode:PHImageContentModeAspectFill
                               options:nil
                         resultHandler:^(UIImage *result, NSDictionary *info) {
                             
                             // 得到一张 UIImage，展示到界面上
                             imageView1.image = result;
                             
                         }];

}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsZero;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
