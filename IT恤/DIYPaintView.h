//
//  DIYPaintView.h
//  IT恤
//
//  Created by 荣刚 on 16/4/2.
//  Copyright © 2016年 rg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DIYPaintView : UIView
/**
 *  T恤样式图片
 */
@property (nonatomic, strong) UIImage *tShirtImage;

/**
 *  添加系统内置贴图
 */
- (void)addPasteImage:(UIImage *)image;

@end
