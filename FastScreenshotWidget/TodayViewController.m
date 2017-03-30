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

#define MAIN_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define MAIN_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface TodayViewController () <NCWidgetProviding>

@property (strong, nonatomic) UIImageView *screenshotImageView;//显示截图的imageView
@property (strong, nonatomic) UIScrollView *shareScorllView;//装分享按钮的scroll
@property (strong, nonatomic) UIButton *moreButton;//向右点击滑动的按钮

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    CGFloat kImageViewWidth,kImageViewHeight;
    
    if (MAIN_SCREEN_WIDTH == 320) {
        kImageViewWidth = 62;
        kImageViewHeight = 75;
    }else if (MAIN_SCREEN_WIDTH == 375 || MAIN_SCREEN_WIDTH == 414) {
        kImageViewWidth = 75;
        kImageViewHeight = 90;
    }
    
    self.preferredContentSize = CGSizeMake(MAIN_SCREEN_WIDTH, kImageViewHeight+20);
    
    _screenshotImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, kImageViewWidth, kImageViewHeight)];
    _screenshotImageView.contentMode = UIViewContentModeScaleAspectFill;
    _screenshotImageView.layer.cornerRadius = 5;
    _screenshotImageView.layer.masksToBounds = YES;
    
    [self.view addSubview:_screenshotImageView];
    
    //获取相机胶卷
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    
    //按时间顺序排序并获取资源
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
//    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsInAssetCollection:smartAlbums[0] options:options];
    
    __weak typeof(self) weakSelf = self;
    //请求图片
    PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
    PHAsset *asset = assetsFetchResults[assetsFetchResults.count-1];
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
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void)setupScroll {
    
    CGFloat kScrollViewY,kShareItemWidth,margin;
    if (MAIN_SCREEN_WIDTH == 320) {
        kScrollViewY = 25;
        kShareItemWidth = 45;
    }else if (MAIN_SCREEN_WIDTH == 375 || MAIN_SCREEN_WIDTH == 414) {
        kScrollViewY = 30;
        kShareItemWidth = 50;
    }
    
    margin = (MAIN_SCREEN_WIDTH-72-self.screenshotImageView.frame.size.width - kShareItemWidth*3)/4;
    
    _shareScorllView = [[UIScrollView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.screenshotImageView.frame)+margin, kScrollViewY, MAIN_SCREEN_WIDTH-72-self.screenshotImageView.frame.size.width-margin, kShareItemWidth)];
    _shareScorllView.showsVerticalScrollIndicator = NO;
    _shareScorllView.showsHorizontalScrollIndicator = NO;
    _shareScorllView.contentSize = CGSizeMake(self.shareScorllView.frame.size.width*2, self.shareScorllView.frame.size.height);
    _shareScorllView.pagingEnabled = YES;
    [self.view addSubview:self.shareScorllView];
}

- (void)setupMoreButton {
    
    CGFloat kBtnY;
    if (MAIN_SCREEN_WIDTH == 320) {
        kBtnY = (95-26)/2;
    }else if (MAIN_SCREEN_WIDTH == 375 || MAIN_SCREEN_WIDTH == 414) {
        kBtnY = (110-26)/2;
    }
    
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreButton.frame = CGRectMake(CGRectGetMaxX(self.shareScorllView.frame), kBtnY, 26, 26);
    [_moreButton setImage:[UIImage imageNamed:@"wg_next"] forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(clickMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    _moreButton.selected = NO;
    [self.view addSubview:self.moreButton];
}

- (void)setupShareButton {
    
    CGFloat margin,kShareItemWidth = 0.0;
    if (MAIN_SCREEN_WIDTH == 320) {
        kShareItemWidth = 45;
    }else if (MAIN_SCREEN_WIDTH == 375 || MAIN_SCREEN_WIDTH == 414) {
        kShareItemWidth = 50;
    }
    margin = (MAIN_SCREEN_WIDTH-72-self.screenshotImageView.frame.size.width - kShareItemWidth*3)/4;
    
    NSArray *imageDateArray = @[@"wg_weibo",@"wg_wechat",@"wg_qq",@"wg_moments"];
    for (int i = 0; i < imageDateArray.count; i ++) {
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.tag = i;
        shareBtn.frame = CGRectMake(i*(margin+kShareItemWidth), 0, kShareItemWidth, kShareItemWidth);
        [shareBtn setImage:[UIImage imageNamed:imageDateArray[i]] forState:UIControlStateNormal];
        [_shareScorllView addSubview:shareBtn];
        [shareBtn addTarget:self action:@selector(clickShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)clickMoreBtn:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    if (sender.selected) {
        sender.selected = !sender.selected;
        [sender setImage:[UIImage imageNamed:@"wg_next"] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.shareScorllView.alpha = 0.5;
        } completion:^(BOOL finished) {
            weakSelf.shareScorllView.contentOffset = CGPointMake(0, 0);
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.shareScorllView.alpha = 1;
            } completion:nil];
        }];
    }else {
        sender.selected = !sender.selected;
        [sender setImage:[UIImage imageNamed:@"wg_pre"] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.shareScorllView.alpha = 0.5;
        } completion:^(BOOL finished) {
            weakSelf.shareScorllView.contentOffset = CGPointMake(self.shareScorllView.frame.size.width, 0);
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.shareScorllView.alpha = 1;
            } completion:nil];
        }];
    }
}

- (void)clickShareBtn:(UIButton *)sender {
    //0:微博 1:微信 2:qq 3:朋友圈
    
    NSURL *url;
    if (sender.tag == 0) {
        url = [NSURL URLWithString:@"widget://weibo"];
        
        [self.extensionContext openURL:url completionHandler:^(BOOL success) {
            
            NSLog(@"isSuccessed %d",success);
        }];
    }else if (sender.tag == 1) {
        url = [NSURL URLWithString:@"widget://weixin"];
        
        [self.extensionContext openURL:url completionHandler:^(BOOL success) {
            
            NSLog(@"isSuccessed %d",success);
        }];
    }else if (sender.tag == 2) {
        url = [NSURL URLWithString:@"widget://QQ"];
        
        [self.extensionContext openURL:url completionHandler:^(BOOL success) {
            
            NSLog(@"isSuccessed %d",success);
        }];
    }else if (sender.tag == 3) {
        url = [NSURL URLWithString:@"widget://moment"];
        
        [self.extensionContext openURL:url completionHandler:^(BOOL success) {
            
            NSLog(@"isSuccessed %d",success);
        }];
    }
}

//- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
//    return UIEdgeInsetsZero;
//}

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
