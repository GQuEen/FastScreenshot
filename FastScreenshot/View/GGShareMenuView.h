//
//  GGShareMenuView.h
//  FastScreenshot
//
//  Created by GQuEen on 17/3/15.
//  Copyright © 2017年 GegeChen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,GGSocialPlatformType) {

    GGSocialPlatformType_Sina               = 0, //新浪
    GGSocialPlatformType_WechatSession      = 1, //微信聊天
    GGSocialPlatformType_WechatTimeLine     = 2,//微信朋友圈
    GGSocialPlatformType_WechatFavorite     = 3,//微信收藏
    GGSocialPlatformType_QQ                 = 4,//QQ聊天页面
    GGSocialPlatformType_Qzone              = 5,//qq空
    GGSocialPlatformType_Down              = 6,//down
    GGSocialPlatformType_More              = 7,//more
};

typedef void(^GGSocialSharePlatformSelectionBlock)(GGSocialPlatformType platformType);

@interface GGShareMenuView : UIView

@property (copy, nonatomic) GGSocialSharePlatformSelectionBlock sharePlatformSelectionBlock;

- (void)showShareMenuViewInWindowWithPlatformSelectionBlock:(GGSocialSharePlatformSelectionBlock)sharePlatformSelectionBlock;

@end
