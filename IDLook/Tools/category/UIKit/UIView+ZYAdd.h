//
//  UIView+ZYAdd.h
//  idolproject
//
//  Created by 刘毅 on 16/2/25.
//  Copyright © 2016年 上海泽佑网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZYAdd)
- (id)initWithSize:(CGSize)size;

- (void)setAnchorPoint:(CGPoint)anchorPoint;
- (void)setPosition:(CGPoint)point atAnchorPoint:(CGPoint)anchorPoint;


- (void)setAutoFrame:(CGRect)autoFrame;
- (void)setAutoSize:(CGSize)autoSize;
- (void)setAutoOrigin:(CGPoint)autoOrigin;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;


- (BOOL)isShowingOnKeyWindow;
@end
