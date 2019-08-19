//
//  UIImage+cate.h
//  IDLook
//
//  Created by HYH on 2018/3/7.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (cate)

+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;

- (UIImage *)imageWithColor:(UIColor *)color;

//图片方向旋转
+ (UIImage *)fixOrientation:(UIImage *)aImage;

//去除图片的白色背景
+ (UIImage *) imageToTransparent:(UIImage*) image;

/**
 *  压缩图片到指定尺寸大小
 *
 *  @param image 原始图片
 *  @param size  目标大小
 *
 *  @return 生成图片
 */
+(UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;


/**
 图片虚化
 @param image 图片
 @param blur 虚化值
 @return 图片
 */
+ (UIImage *)blurryImage:(UIImage*)image
           withBlurLevel:(CGFloat)blur;

@end