//
//  UIImage+ZYExtension.h
//  idolproject
//
//  Created by 刘毅 on 16/2/14.
//  Copyright © 2016年 上海泽佑网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZYAdd)
/**
 *  获取圆形图片
 *
 *  @param side 图片边长
 *
 *  @return 返回圆形图
 */
- (UIImage *)circleImageWithSide:(CGFloat)side;

/**
 *  获取圆形图片
 *
 *  @param opaque 周边是否透明(YES->不透明)
 *  @return 返回圆形图
 */
//- (UIImage *)circleImageOpaque:(BOOL)opaque;
- (UIImage *)circleImage;

/**
 *  获取纯色图
 *
 *  @param color 颜色
 *
 *  @return 纯色图
 */
+ (UIImage*)createImageWithColor:(UIColor*)color;


+ (NSArray *)compressImageWithALAssets:(NSArray *)assets;
+ (UIImage *)compressImageWithImage:(UIImage *)image;
+ (UIImage *)thumbImageWithImage:(UIImage *)scImg limitSize:(CGSize)limitSize;
- (UIImage *)circleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  左右上角为圆角的图
 *
 *  @param radius 圆角半径
 *  @param opaque 是否透明
 *
 *  @return 两个圆角的图片
 */
- (UIImage *)zy_twoUpCornerImageWithWidth:(CGFloat)width CornerRadius:(CGFloat)radius Opaque:(BOOL)opaque;

/**
 *  默认头像, 全局用
 */
+ (UIImage *)defaultHead;
/**
 *  五角星占位图
 */
+ (UIImage *)placeholder;
+ (UIImage *)placeholderSmall;
+ (UIImage *)homeCellPlaceholder;
+ (UIImage *)placeholderWithSize:(CGSize)size;
/**
 *  未关注按钮图
 */
+ (UIImage *)attentionImage;
/**
 *  顶部阴影
 */
+ (UIImage *)topShadowImage;
/**
 *  底部阴影
 */
+ (UIImage *)bottomShadowImage;
/**
 *  已关注按钮图
 */
+ (UIImage *)attentionSelectedImage;
+ (UIImage *)imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock;



// ImageZipUtils
+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
+ (CGSize)sacleImageSize:(UIImage *)image;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (NSData*)imageToData:(UIImage *)img;
@end