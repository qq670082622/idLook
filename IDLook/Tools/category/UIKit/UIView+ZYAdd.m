//
//  UIView+ZYAdd.m
//  idolproject
//
//  Created by 刘毅 on 16/2/25.
//  Copyright © 2016年 上海泽佑网络科技有限公司. All rights reserved.
//

#import "UIView+ZYAdd.h"

@implementation UIView (ZYAdd)

#pragma mark - Init
- (id)initWithSize:(CGSize)size {
    CGRect rect = (CGRect){CGPointZero, size};
    return [self initWithFrame:rect];
}


#pragma mark - Get Property
- (CGPoint)origin {
    return self.frame.origin;
}

- (CGFloat)x {
    return self.origin.x;
}

- (CGFloat)y {
    return self.origin.y;
}



- (CGSize)size {
    return self.frame.size;
}

- (CGFloat)height {
    return self.size.height;
}

- (CGFloat)width {
    return self.size.width;
}


#pragma mark - Set Origin
- (void)setOrigin:(CGPoint)origin {
    self.frame = (CGRect){origin, self.size};
}

- (void)setX:(CGFloat)x {
    [self setOrigin:CGPointMake(x, self.y)];
}

- (void)setY:(CGFloat)y {
    [self setOrigin:CGPointMake(self.x, y)];
}
- (CGFloat)right {
    return self.x + self.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.y + self.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


#pragma mark - Set Size
- (void)setSize:(CGSize)size {
    self.frame = (CGRect){self.origin, size};
}

- (void)setWidth:(CGFloat)width {
    [self setSize:CGSizeMake(width, self.height)];
}

- (void)setHeight:(CGFloat)height {
    [self setSize:CGSizeMake(self.width, height)];
}


#pragma mark - Set Anchor Point
- (void)setAnchorPoint:(CGPoint)anchorPoint {
    [self setPosition:self.origin atAnchorPoint:anchorPoint];
}

- (void)setPosition:(CGPoint)point atAnchorPoint:(CGPoint)anchorPoint {
    CGFloat x = point.x - anchorPoint.x * self.width;
    CGFloat y = point.y - anchorPoint.y * self.height;
    [self setOrigin:CGPointMake(x, y)];
}

#pragma mark - Set Center
- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}







- (BOOL)isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}
@end
