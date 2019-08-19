//
//  CALayer+ZYAdd.h
//  idolproject
//
//  Created by 刘毅 on 16/2/20.
//  Copyright © 2016年 上海泽佑网络科技有限公司. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, CALayerLineDirection) {
    CALayerLineDirectionVertical, // Default
    CALayerLineDirectionHorizontal,
    CALayerLineDirectionReverseVertical,
    CALayerLineDirectionReverseHorizontal
};

@interface CALayer (ZYAdd)
- (CALayer *)zy_createLineWithFrame:(CGRect)frame;
- (CALayer *)zy_createLineWithFrame:(CGRect)frame color:(UIColor *)color;
- (CALayer *)zy_createGradientLineWithFrame:(CGRect)frame;
- (CALayer *)zy_createGradientLineWithFrame:(CGRect)frame direction:(CALayerLineDirection)direction;
+ (CALayer *)zy_createGradientLineWithFrame:(CGRect)frame direction:(CALayerLineDirection)direction toLayer:(CALayer *)toLayer;
+ (CALayer *)zy_createCornerLayerWithSize:(CGSize)size radius:(CGFloat)radius color:(UIColor *)color;
- (CALayer *)zy_createCornerLayerWithSize:(CGSize)size radius:(CGFloat)radius color:(UIColor *)color;
+ (CALayer *)zy_createGradientViewWithFrame:(CGRect)frame direction:(CALayerLineDirection)direction color:(UIColor *)color toLayer:(CALayer *)toLayer;

@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGPoint center;      ///< Shortcut for center.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic, getter=frameSize, setter=setFrameSize:) CGSize  size; ///< Shortcut for frame.size.



@end
