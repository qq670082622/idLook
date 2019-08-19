//
//  UIImage+ZYExtension.m
//  idolproject
//
//  Created by 刘毅 on 16/2/14.
//  Copyright © 2016年 上海泽佑网络科技有限公司. All rights reserved.
//

#import "UIImage+ZYAdd.h"
#import <AssetsLibrary/AssetsLibrary.h>
#define kIconPlaceholder @"默认图片"
#define kDefaultHead @"默认头像"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define ZYNormolColor [UIColor balckColor]
/** 长图*/
CGFloat const ZYNewHomeCellPictureMinScale = 3 / 8;
/** 宽图*/
CGFloat const ZYNewHomeCellPictureMaxScale = 8 / 3;

#define ZY_DEFAULT_COMPRESSION_QUALITY 1

@implementation UIImage (ZYAdd)
- (UIImage *)circleImageWithSide:(CGFloat)side {
    
    CGFloat imageWidth = self.size.width;
    CGFloat imageHeight = self.size.height;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(side, side), NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(0, 0, side, side);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    if (imageWidth == imageHeight) {
        [self drawInRect:rect];
        
    } else if (imageWidth < imageHeight) {
        imageHeight *= side / imageWidth;
        imageWidth = side;
        [self drawInRect:CGRectMake(0, -(imageHeight - imageWidth) / 2, imageWidth, imageHeight)];
        
    } else {
        imageWidth *= side / imageHeight;
        imageHeight = side;
        [self drawInRect:CGRectMake(-(imageWidth - imageHeight) / 2, 0, imageWidth, imageHeight)];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (UIImage *)circleImage {
    return [self circleImageOpaque:NO];
}

- (UIImage *)circleImageOpaque:(BOOL)opaque
{
    CGFloat imageWidth = self.size.width;
    CGFloat imageHeight = self.size.height;
    CGFloat width = imageWidth < imageHeight ? imageWidth : imageHeight;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, width), opaque, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (opaque) { // 画不透明白色背景
        [[UIColor whiteColor] set];
        UIRectFill(CGRectMake(0, 0, width, width));
    }
    
    CGRect rect = CGRectMake(0, 0, width, width);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);

    if (imageWidth == imageHeight) {
        [self drawInRect:rect];
        
    } else if (imageWidth < imageHeight) {
        [self drawInRect:CGRectMake(0, -(imageHeight - imageWidth) / 2, imageWidth, imageHeight)];
        
    } else {
        [self drawInRect:CGRectMake(-(imageWidth - imageHeight) / 2, 0, imageWidth, imageHeight)];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)circleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    CGFloat imageWidth = self.size.width + 2 * borderWidth;
    CGFloat imageHeight = self.size.height + 2 * borderWidth;
    CGFloat width = imageWidth < imageHeight ? imageWidth : imageHeight;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, width), NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageWidth * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    if (imageWidth == imageHeight) {
        [self drawInRect:CGRectMake(borderWidth, borderWidth, imageWidth, imageHeight)];
        
    } else if (imageWidth < imageHeight) {
        [self drawInRect:CGRectMake(borderWidth, -(imageHeight - imageWidth) / 2 + borderWidth, imageWidth, imageHeight)];
        
    } else {
        [self drawInRect:CGRectMake(-(imageWidth - imageHeight) / 2 + borderWidth, borderWidth, imageWidth, imageHeight)];
    }
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)zy_twoUpCornerImageWithWidth:(CGFloat)width CornerRadius:(CGFloat)radius Opaque:(BOOL)opaque
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, width), opaque, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (opaque) {
        [[UIColor whiteColor] set];
        UIRectFill(CGRectMake(0, 0, width, width));
    }

    // 划路径
    CGContextMoveToPoint(context, 0, radius);
    CGContextAddArc(context, radius, radius, radius, M_PI, 1.5 * M_PI, 0);
    CGContextAddLineToPoint(context, width - radius, 0);
    CGContextAddArc(context, width - radius, radius, radius, -0.5 * M_PI, 0.0, 0);
    CGContextAddLineToPoint(context, width, width);
    CGContextAddLineToPoint(context, 0, width);
    CGContextAddLineToPoint(context, 0, radius);
    CGContextClosePath(context);
    CGContextClip(context);

    // 画图
    CGFloat imageWidth = self.size.width;
    CGFloat imageHeight = self.size.height;
    CGFloat imageScale = imageWidth / imageHeight;
    if (imageScale < ZYNewHomeCellPictureMinScale) {
        [self drawInRect:CGRectMake(0, 0, width, width / imageWidth * imageHeight)];
    } else if (imageScale > ZYNewHomeCellPictureMaxScale) {
        [self drawInRect:CGRectMake(0, 0, width * imageWidth / imageHeight, width)];
    } else {
        if (imageScale <= 1) {
            CGFloat newImageHeight = width / imageWidth * imageHeight;
            [self drawInRect:CGRectMake(0, -(newImageHeight - width) / 2, width, newImageHeight)];
        } else {
            CGFloat newImageWidth = width * imageWidth / imageHeight;
            [self drawInRect:CGRectMake(-(newImageWidth - width) / 2, 0, newImageWidth, width)];
        }
    }
//    [self drawInRect:CGRectMake(0, 0, width, width / self.size.width * self.size.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



+ (UIImage *)createImageWithColor:(UIColor*)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



+ (NSArray *)compressImageWithALAssets:(NSArray *)assets {
    NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < assets.count; i++) {
        ALAsset *asset = assets[i];
        // 获取资源图片的详细资源信息
        ALAssetRepresentation *representation = [asset defaultRepresentation];
        //        UIImage *imageNew = [UIImage imageWithCGImage:[representation fullResolutionImage] scale:[representation scale] orientation:UIImageOrientationUp];
        UIImage *imageNew = [UIImage imageWithCGImage:[representation fullResolutionImage] scale:[representation scale] orientation:(UIImageOrientation)representation.orientation];
        // 设置image的尺寸
        //        CGSize imagesize = imageNew.size;
        
        // 对图片大小进行压缩--
        //        imageNew = [self imageWithImage:imageNew scaledToSize:imagesize];
        //        NSData *imageData = UIImageJPEGRepresentation(imageNew,ZY_DEFAULT_COMPRESSION_QUALITY);
        
        //        [imageArr addObject:[UIImage imageWithData:imageData]];
        [imageArr addObject:imageNew];
    }
    return imageArr;
}

+ (UIImage *)compressImageWithImage:(UIImage *)image {
    CGSize imagesize = image.size;
    
    image = [self imageWithImage:image scaledToSize:imagesize];
    
    NSData *imageData = UIImageJPEGRepresentation(image, ZY_DEFAULT_COMPRESSION_QUALITY);
    
    return [UIImage imageWithData:imageData];
}

+ (UIImage *)thumbImageWithImage:(UIImage *)scImg limitSize:(CGSize)limitSize {
    if (scImg.size.width <= limitSize.width && scImg.size.height <= limitSize.height) {
        return scImg;
    }
    CGSize thumbSize;
    if (scImg.size.width / scImg.size.height > limitSize.width / limitSize.height) {
        thumbSize.width = limitSize.width;
        thumbSize.height = limitSize.width / scImg.size.width * scImg.size.height;
    }
    else {
        thumbSize.height = limitSize.height;
        thumbSize.width = limitSize.height / scImg.size.height * scImg.size.width;
    }
    UIGraphicsBeginImageContext(thumbSize);
    [scImg drawInRect:(CGRect){CGPointZero,thumbSize}];
    UIImage *thumbImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbImg;
}

+ (UIImage *)imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock {
    if (!drawBlock) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    drawBlock(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)defaultHead {
    static UIImage *img;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        img = [UIImage imageNamed:kDefaultHead];
    });
    return img;
}

+ (UIImage *)placeholder {
    static UIImage *img;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIImage *placeholder = [UIImage imageNamed:kIconPlaceholder];
        CGFloat imageWidth = placeholder.size.width;
        CGFloat imageHeight = placeholder.size.height;
        CGFloat side = kScreenWidth;
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(side, side), NO, 0.0);
        [[UIColor grayColor] set];
        UIRectFill(CGRectMake(0, 0, side, side));
        CGRect rect = {{(side - imageWidth) / 2, (side - imageHeight) / 2}, placeholder.size};
        [placeholder drawInRect:rect];
        img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    });
    return img;
}

+ (UIImage *)homeCellPlaceholder {
    static UIImage *img;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIImage *placeholder = [UIImage imageNamed:kIconPlaceholder];
        CGFloat imageWidth = placeholder.size.width;
        CGFloat imageHeight = placeholder.size.height;
        CGFloat side = kScreenWidth / 2;
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(side, side), NO, 0.0);
        [[UIColor grayColor] set];
        UIRectFill(CGRectMake(0, 0, side, side));
        CGRect rect = {{(side - imageWidth) / 2, (side - imageHeight) / 2}, placeholder.size};
        [placeholder drawInRect:rect];
        img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    });
    return img;
}

+ (UIImage *)placeholderSmall {
    static UIImage *img;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        img = [UIImage imageNamed:kIconPlaceholder];
    });
    return img;
}

+ (UIImage *)placeholderWithSize:(CGSize)size {
    UIImage *placeholder = [UIImage imageWithSize:size drawBlock:^(CGContextRef context) {
        [[UIColor grayColor] set];
        UIRectFill((CGRect){CGPointZero, size});
        CGFloat imgX = (size.width - [UIImage placeholder].size.width) / 2;
        CGFloat imgY = (size.height - [UIImage placeholder].size.height) / 2;
        [[UIImage placeholder] drawInRect:(CGRect){CGPointMake(imgX, imgY), [UIImage placeholder].size}];
    }];
    return placeholder;
}

+ (UIImage *)attentionImage {
    static UIImage *img;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        img = [UIImage imageNamed:@"attention_icon_guanzhu"];
    });
    return img;
}

+ (UIImage *)attentionSelectedImage {
    static UIImage *img;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        img = [UIImage imageNamed:@"attention_icon_yiguanzhu"];
    });
    return img;
}

+ (UIImage *)topShadowImage {
    static UIImage *img;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        img = [UIImage imageNamed:@"shadow_s_ver"];
    });
    return img;
}

+ (UIImage *)bottomShadowImage {
    static UIImage *img;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        img = [UIImage imageNamed:@"shadow_s"];
    });
    return img;
}






// ImageZipUtils
+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    if(width<targetWidth && height < targetHeight){
        return sourceImage;
    }
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

+ (CGSize)sacleImageSize:(UIImage *)image {
    double maxWidth = 320;
    double maxHeight = 568;
    
    int h = image.size.height;
    
    int w = image.size.width;
    
    float b = (float)maxWidth/w > (float)maxHeight/h ? (float)maxWidth/w : (float)maxHeight/h;
    
    CGSize itemSize = CGSizeMake(b*w, b*h);
    return itemSize;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (NSData*)imageToData:(UIImage *)img{
    return UIImageJPEGRepresentation(img, 0.7);
}

@end
