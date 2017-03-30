//
//  GGShareMenuView.m
//  FastScreenshot
//
//  Created by GQuEen on 17/3/15.
//  Copyright © 2017年 GegeChen. All rights reserved.
//

#import "GGShareMenuView.h"

#define kItemWidth 53

@interface GGShareMenuView ()

@property (strong, nonatomic) UIView *maskView;//背景蒙版

@property (strong, nonatomic) UIView *shareMenuBackView;//分享菜单父view

@end

@implementation GGShareMenuView

- (void)showShareMenuViewInWindowWithPlatformSelectionBlock:(GGSocialSharePlatformSelectionBlock)sharePlatformSelectionBlock {
    
//    GGShareMenuView *shareMenuView = [[GGShareMenuView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
    [self creatShareMenuView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    GGWeak;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.maskView.alpha = 0.5;
        weakSelf.shareMenuBackView.frame = CGRectMake(0, MAIN_SCREEN_HEIGHT-238, MAIN_SCREEN_WIDTH, 232);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            
            weakSelf.shareMenuBackView.frame = CGRectMake(0, MAIN_SCREEN_HEIGHT-230, MAIN_SCREEN_WIDTH, 232);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                
                weakSelf.shareMenuBackView.frame = CGRectMake(0, MAIN_SCREEN_HEIGHT-232, MAIN_SCREEN_WIDTH, 232);
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];

    self.sharePlatformSelectionBlock = sharePlatformSelectionBlock;
}
//创建分享菜单界面
- (void)creatShareMenuView {
    
    //创建蒙版
    _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = 0;
    _maskView.userInteractionEnabled = YES;
    [_maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissShareMenuView)]];
   
    _shareMenuBackView = [[UIView alloc]initWithFrame:CGRectMake(0, MAIN_SCREEN_HEIGHT, MAIN_SCREEN_WIDTH, 238)];
   
    UIView *shareMenuItemView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 182)];
    shareMenuItemView.backgroundColor = [UIColor whiteColor];
    
    
    /*创建shareItem */
    
    NSArray *imageDateArray = @[@"share_weibo.png",@"share_wechat.png",@"share_moments.png",@"share_qq.png",@"share_down.png",@"share_more.png"];
    
    //item之间的间距
    CGFloat magringOfItem = (MAIN_SCREEN_WIDTH - 3*kItemWidth)/4;
    
    for (int i = 0; i < 6; i ++) {
        NSInteger colunm = i % 3;
        NSInteger row = i / 3;
        NSInteger itemY;
        if (row == 0) {
            itemY = 28.5;
        }else if (row == 1) {
            itemY = 28.5 + kItemWidth + 20;
        }
        
        UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn.frame = (CGRect){{magringOfItem + colunm * (kItemWidth+magringOfItem),itemY},{53,53}};
        [itemBtn setBackgroundImage:[UIImage imageNamed:imageDateArray[i]] forState:UIControlStateNormal];
        [itemBtn addTarget:self action:@selector(clickShareItemBtn:) forControlEvents:UIControlEventTouchUpInside];
        itemBtn.tag = i;
        [shareMenuItemView addSubview:itemBtn];
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 182, MAIN_SCREEN_WIDTH-30, 1)];
    line.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 182, MAIN_SCREEN_WIDTH, 56);
//    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [cancelBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1]] forState:UIControlStateHighlighted];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:MAIN_FONT_COLOR forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelHandlel) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:self.maskView];
    [self addSubview:self.shareMenuBackView];
    [_shareMenuBackView addSubview:shareMenuItemView];
    [_shareMenuBackView addSubview:cancelBtn];
    [_shareMenuBackView addSubview:line];
    
}

- (void)clickShareItemBtn:(UIButton *)sender {
    NSLog(@"点击item : %ld",sender.tag);
    if (self.sharePlatformSelectionBlock) {
        if (sender.tag == 0) {
            self.sharePlatformSelectionBlock(UMSocialPlatformType_Sina);
        }else if (sender.tag == 1) {
            self.sharePlatformSelectionBlock(UMSocialPlatformType_WechatSession);
        }else if (sender.tag == 2) {
            self.sharePlatformSelectionBlock(UMSocialPlatformType_WechatTimeLine);
        }else if (sender.tag == 3) {
            self.sharePlatformSelectionBlock(UMSocialPlatformType_QQ);
        }else if (sender.tag == 4) {
            self.sharePlatformSelectionBlock(UMSocialPlatformType_UserDefine_Begin+1);
        }else if (sender.tag == 5) {
            self.sharePlatformSelectionBlock(UMSocialPlatformType_UserDefine_Begin+2);
        }
    }
    [self shareMenuViewRemoveFormSuperview];
}

- (void)cancelHandlel {
    NSLog(@"点击取消消失");
    
    [self shareMenuViewRemoveFormSuperview];
    
}

- (void)dismissShareMenuView {
    NSLog(@"点击蒙版消失");
    [self shareMenuViewRemoveFormSuperview];
}

- (void)shareMenuViewRemoveFormSuperview {
    GGWeak;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.maskView.alpha = 0;
        weakSelf.shareMenuBackView.frame = CGRectMake(0, MAIN_SCREEN_HEIGHT, MAIN_SCREEN_WIDTH, 232);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

@end
