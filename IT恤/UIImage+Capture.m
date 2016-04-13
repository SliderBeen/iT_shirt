//
//  UIImage+Capture.m
//  IT恤
//
//  Created by 荣刚 on 16/4/7.
//  Copyright © 2016年 rg. All rights reserved.
//

#import "UIImage+Capture.h"

@implementation UIImage (Capture)

+ (instancetype)captureWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
