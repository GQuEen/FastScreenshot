//
//  UIImage+Tool.m
//  CQUPTLife
//
//  Created by GQuEen on 16/11/10.
//  Copyright © 2016年 GegeChen. All rights reserved.
//

#import "UIImage+Tool.h"

@implementation UIImage (Tool)

+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
