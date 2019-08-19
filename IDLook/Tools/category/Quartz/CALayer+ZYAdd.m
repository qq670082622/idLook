//
//  CALayer+ZYAdd.m
//  idolproject
//
//  Created by 刘毅 on 16/2/20.
//  Copyright © 2016年 上海泽佑网络科技有限公司. All rights reserved.
//

#import "CALayer+ZYAdd.h"
#define ZYLineColor  [UIColor blackColor]
@implementation CALayer (ZYAdd)
- (CALayer *)zy_createLineWithFrame:(CGRect)frame {
    return [self zy_createLineWithFrame:frame color:nil];
}

- (CALayer *)zy_createLineWithFrame:(CGRect)frame color:(UIColor *)color {
    CALayer *line = [CALayer layer];
    line.frame = frame;
   
    line.backgroundColor = color ? color.CGColor : ZYLineColor.CGColor;
    [self addSublayer:line];
    return line;
}

- (CALayer *)zy_createGradientLineWithFrame:(CGRect)frame {
    return [self zy_createGradientLineWithFrame:frame direction:CALayerLineDirectionVertical];
}

- (CALayer *)zy_createGradientLineWithFrame:(CGRect)frame direction:(CALayerLineDirection)direction {
    return [CALayer zy_createGradientLineWithFrame:frame direction:direction toLayer:self];
}

+ (CALayer *)zy_createGradientLineWithFrame:(CGRect)frame direction:(CALayerLineDirection)direction toLayer:(CALayer *)toLayer {
    UIColor *dark = [UIColor colorWithWhite:0 alpha:0.2];
    UIColor *clear = [UIColor colorWithWhite:0 alpha:0];
    NSArray *colors = @[(id)clear.CGColor,(id)dark.CGColor, (id)clear.CGColor];
    NSArray *locations = @[@0.2, @0.5, @0.8];
    
    CAGradientLayer *line = [CAGradientLayer layer];
    line.colors = colors;
    line.locations = locations;
    line.startPoint = CGPointMake(0, 0);
    line.endPoint = direction == CALayerLineDirectionVertical ? CGPointMake(0, 1) : CGPointMake(1, 0);
    line.frame = frame;
    [toLayer addSublayer:line];
    return line;
}
+ (CALayer *)zy_createGradientViewWithFrame:(CGRect)frame direction:(CALayerLineDirection)direction color:(UIColor *)color toLayer:(CALayer *)toLayer {
    UIColor *color1 = [color colorWithAlphaComponent:0.8];
    UIColor *color2 = [color colorWithAlphaComponent:0.3];
    UIColor *color3 = [color colorWithAlphaComponent:0];
    
    NSArray *colors = (direction == CALayerLineDirectionReverseHorizontal || direction == CALayerLineDirectionReverseVertical) ? @[(id)color3.CGColor, (id)color2.CGColor, (id)color1.CGColor] : @[(id)color1.CGColor, (id)color2.CGColor, (id)color3.CGColor];
    NSArray *locations = @[@0, @0.5, @1];
    
    CAGradientLayer *line = [CAGradientLayer layer];
    line.colors = colors;
    line.locations = locations;
    line.startPoint = CGPointMake(0, 0);
    line.endPoint = (direction == CALayerLineDirectionVertical || direction == CALayerLineDirectionReverseVertical) ? CGPointMake(0, 1) : CGPointMake(1, 0);
    line.frame = frame;
    [toLayer addSublayer:line];
    return line;
}

- (CALayer *)zy_createCornerLayerWithSize:(CGSize)size radius:(CGFloat)radius color:(UIColor *)color {
    CALayer *layer = [CALayer zy_createCornerLayerWithSize:size radius:radius color:color];
    [self addSublayer:layer];
    return layer;
}

+ (CALayer *)zy_createCornerLayerWithSize:(CGSize)size radius:(CGFloat)radius color:(UIColor *)color {
    CGFloat width = size.width;
    CGFloat height = size.height;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, radius)];
    [path addArcWithCenter:CGPointMake(radius, radius) radius:radius startAngle:M_PI endAngle:1.5 * M_PI clockwise:YES];
    [path addLineToPoint:CGPointMake(width - radius, 0)];
    [path addArcWithCenter:CGPointMake(width - radius, radius) radius:radius startAngle:-0.5 * M_PI endAngle:0 clockwise:YES];
    [path addLineToPoint:CGPointMake(width, height - radius)];
    [path addArcWithCenter:CGPointMake(width - radius, height - radius) radius:radius startAngle:0 endAngle:0.5 * M_PI clockwise:YES];
    [path addLineToPoint:CGPointMake(radius, height)];
    [path addArcWithCenter:CGPointMake(radius, height - radius) radius:radius startAngle:0.5 * M_PI endAngle:M_PI clockwise:YES];
    [path addLineToPoint:CGPointMake(0, radius)];
    [path closePath];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path =path.CGPath;
    layer.frame = CGRectMake(0, 0, width, height);
    layer.fillColor = color.CGColor;
    layer.strokeColor = [UIColor clearColor].CGColor;
    layer.lineCap = kCALineCapRound;
    [self.layer addSublayer:layer];
    return layer;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)center {
    return CGPointMake(self.frame.origin.x + self.frame.size.width * 0.5,
                       self.frame.origin.y + self.frame.size.height * 0.5);
}

- (void)setCenter:(CGPoint)center {
    CGRect frame = self.frame;
    frame.origin.x = center.x - frame.size.width * 0.5;
    frame.origin.y = center.y - frame.size.height * 0.5;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.frame.origin.x + self.frame.size.width * 0.5;
}

- (void)setCenterX:(CGFloat)centerX {
    CGRect frame = self.frame;
    frame.origin.x = centerX - frame.size.width * 0.5;
    self.frame = frame;
}

- (CGFloat)centerY {
    return self.frame.origin.y + self.frame.size.height * 0.5;
}

- (void)setCenterY:(CGFloat)centerY {
    CGRect frame = self.frame;
    frame.origin.y = centerY - frame.size.height * 0.5;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)frameSize {
    return self.frame.size;
}

- (void)setFrameSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


@end
