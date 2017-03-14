//
//  GGShareMenuView.m
//  FastScreenshot
//
//  Created by GQuEen on 17/3/15.
//  Copyright © 2017年 GegeChen. All rights reserved.
//

#import "GGShareMenuView.h"

@interface GGShareMenuView ()

@property (strong, nonatomic) UIView *maskView;//背景蒙版

@end

@implementation GGShareMenuView

- (void)showShareMenuViewInWindowWithPlatformSelectionBlock:(GGSocialSharePlatformSelectionBlock)sharePlatformSelectionBlock {
    
//    GGShareMenuView *shareMenuView = [[GGShareMenuView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
    [self creatShareMenuView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];

    if (sharePlatformSelectionBlock) {
        sharePlatformSelectionBlock(0);
    }
}
//创建分享菜单界面
- (void)creatShareMenuView {
    
    //创建蒙版
    _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = 0.3;
    _maskView.userInteractionEnabled = YES;
    [_maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissShareMenuView)]];
    [self addSubview:self.maskView];
    
    
}

- (void)dismissShareMenuView {
    NSLog(@"小时");
    [self removeFromSuperview];
}

@end
