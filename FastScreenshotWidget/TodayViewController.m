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

@property (strong, nonatomic) UIImageView *screenshotImageView;//显示截图的imageView
@property (strong, nonatomic) UIScrollView *shareScorllView;//装分享按钮的scroll
@property (strong, nonatomic) UIButton *moreButton;//向右点击滑动的按钮

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.preferredContentSize = CGSizeMake(375, 110);
    
    _screenshotImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 75, 90)];
    _screenshotImageView.backgroundColor = [UIColor greenColor];
    _screenshotImageView.contentMode = UIViewContentModeScaleAspectFill;
    _screenshotImageView.layer.cornerRadius = 5;
    _screenshotImageView.layer.masksToBounds = YES;
    
    [self.view addSubview:_screenshotImageView];
    
    //按时间顺序排序并获取资源
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
    __weak typeof(self) weakSelf = self;
    //请求图片
    PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
    PHAsset *asset = assetsFetchResults[assetsFetchResults.count-2];
    [imageManager requestImageForAsset:asset
                            targetSize:PHImageManagerMaximumSize
                           contentMode:PHImageContentModeAspectFill
                               options:nil
                         resultHandler:^(UIImage *result, NSDictionary *info) {
                             
                             // 得到一张 UIImage，展示到界面上
                             weakSelf.screenshotImageView.image = result;
                             
                         }];
    [self setupScroll];
    [self setupMoreButton];
    [self setupShareButton];
}

- (void)setupScroll {
    _shareScorllView = [[UIScrollView alloc]initWithFrame:CGRectMake(105, 30, 375-75-30-41-15, 51)];
    _shareScorllView.showsVerticalScrollIndicator = NO;
    _shareScorllView.showsHorizontalScrollIndicator = NO;
    _shareScorllView.contentSize = CGSizeMake(self.shareScorllView.frame.size.width*2, self.shareScorllView.frame.size.height);
    _shareScorllView.pagingEnabled = YES;
    //_shareScorllView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.shareScorllView];
}

- (void)setupMoreButton {
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreButton.frame = CGRectMake(CGRectGetMaxX(self.shareScorllView.frame), 0, 26, 26);
    _moreButton.center = CGPointMake(CGRectGetMidX(self.moreButton.frame), self.view.frame.size.height/2);
    [_moreButton setImage:[UIImage imageNamed:@"wg_next"] forState:UIControlStateNormal];
    [self.view addSubview:self.moreButton];
}

- (void)setupShareButton {
    
    NSArray *imageDateArray = @[@"share_weibo",@"share_wechat",@"share_qq",@"share_moments"];
    for (int i = 0; i < imageDateArray.count; i ++) {
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.tag = i;
        shareBtn.frame = CGRectMake(i*71, 0, 51, 51);
        [shareBtn setImage:[UIImage imageNamed:imageDateArray[i]] forState:UIControlStateNormal];
        [_shareScorllView addSubview:shareBtn];
        [shareBtn addTarget:self action:@selector(clickShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)clickShareBtn:(UIButton *)sender {
    

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
