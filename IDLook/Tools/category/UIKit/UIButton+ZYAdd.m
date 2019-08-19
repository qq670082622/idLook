//
//  UIButton+ZYAdd.m
//  idolproject
//
//  Created by 刘毅 on 15/9/20.
//  Copyright (c) 2015年 上海泽佑网络科技有限公司. All rights reserved.
//

#import "UIButton+ZYAdd.h"

@implementation UIButton (ZYExtension)
// 修改xib创建的
//+ (void)load
//{
//    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
//    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
//    method_exchangeImplementations(imp, myImp);
//}
//
//- (id)myInitWithCoder:(NSCoder*)aDecode
//{
//    [self myInitWithCoder:aDecode];
//    if (self) {
//        CGFloat fontSize = self.titleLabel.font.pointSize;
//        self.titleLabel.font = [UIFont fontWithName:@"" size:fontSize];
//    }
//    return self;
//}

- (void)setHighlightedTitle:(NSString *)highlightedTitle {
    [self setTitle:highlightedTitle forState:UIControlStateHighlighted];
}

- (NSString *)highlightedTitle {
    return nil;
}

- (void)setTitleColor:(UIColor *)titleColor {
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

- (UIColor *)titleColor {
    return nil;
}

- (void)setHighlightedTitleColor:(UIColor *)highlightedTitleColor {
    [self setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
}

- (UIColor *)highlightedTitleColor {
    return nil;
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
}

- (UIColor *)selectedTitleColor {
    return nil;
}

- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

- (NSString *)title {
    return [self titleForState:UIControlStateNormal];
}

- (void)setSelectedTitle:(NSString *)selectedTitle {
    [self setTitle:selectedTitle forState:UIControlStateSelected];
}

- (NSString *)selectedTitle {
    return [self titleForState:UIControlStateSelected];
}

- (void)setImageStr:(NSString *)imageStr {
    [self setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
}

- (NSString *)imageStr {
    return nil;
}
- (void)setImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
}
- (UIImage *)image {
    return self.currentImage;
}
- (void)setHighlightedImage:(NSString *)image {
    [self setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
}

- (NSString *)highlightedImage {
    return nil;
}

- (void)setSelectedImageStr:(NSString *)imageStr {
    [self setImage:[UIImage imageNamed:imageStr] forState:UIControlStateSelected];
}

- (NSString *)selectedImageStr {
    return nil;
}

- (void)setBgImage:(NSString *)image {
    [self setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
}

- (NSString *)bgImage {
    return nil;
}

- (void)setHighlightedBgImage:(NSString *)image {
    [self setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
}

- (NSString *)highlightedBgImage {
    return nil;
}

- (void)setSelectedBgImage:(NSString *)image {
    [self setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateSelected];
}

- (NSString *)selectedBgImage {
    return nil;
}
- (void)setBackgroundImage:(UIImage *)backgroundImage {
    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
}
- (UIImage *)backgroundImage {
    return self.currentBackgroundImage;
}

- (void)addTarget:(id)target action:(SEL)action {
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}




- (void)setFont:(CGFloat)font {
    self.titleLabel.font = [UIFont systemFontOfSize:font];
}
@end
