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

@property (strong, nonatomic) UIView *shareMenuBackView;//分享菜单父view

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
   
    _shareMenuBackView = [[UIView alloc]initWithFrame:CGRectMake(0, MAIN_SCREEN_HEIGHT-232, MAIN_SCREEN_WIDTH, 232)];
   
    UIView *shareMenuItemView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 182)];
    shareMenuItemView.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 181, MAIN_SCREEN_WIDTH-30, 1)];
    line.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 182, MAIN_SCREEN_WIDTH, 50);
//    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [cancelBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1]] forState:UIControlStateHighlighted];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:MAIN_FONT_COLOR forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelHandlel) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:self.maskView];
    [self addSubview:self.shareMenuBackView];
    [_shareMenuBackView addSubview:shareMenuItemView];
    [_shareMenuBackView addSubview:line];
    [_shareMenuBackView addSubview:cancelBtn];
    
}

- (void)cancelHandlel {
    NSLog(@"点击取消消失");
    [self removeFromSuperview];
}

- (void)dismissShareMenuView {
    NSLog(@"点击蒙版消失");
    [self removeFromSuperview];
}

@end
