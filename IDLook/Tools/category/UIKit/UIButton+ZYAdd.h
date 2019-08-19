//
//  UIButton+ZYAdd.h
//  idolproject
//
//  Created by 刘毅 on 15/9/20.
//  Copyright (c) 2015年 上海泽佑网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ZYExtension)
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *highlightedTitleColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *highlightedTitle;
@property (nonatomic, copy) NSString *selectedTitle;

@property (nonatomic, copy) NSString *imageStr;
@property (nonatomic, copy) NSString *highlightedImage;
@property (nonatomic, copy) NSString *selectedImageStr;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) NSString *bgImage;
@property (nonatomic, copy) NSString *highlightedBgImage;
@property (nonatomic, copy) NSString *selectedBgImage;
@property (nonatomic, strong) UIImage *backgroundImage;

@property (nonatomic, assign) CGFloat font;

- (void)setDefaultHead;
- (void)addTarget:(id)target action:(SEL)action;

/**
 *  换算单位
 *
 *  @param numText 数字
 */
- (void)setNumText:(NSString *)numText;
/**
 *  换算单位(前缀)
 *
 *  @param numText 数字
 *  @param prefix  前缀
 */
- (void)setNumText:(NSString *)numText prefix:(NSString *)prefix;
/**
 *  换算单位(后缀)
 *
 *  @param numText 数字
 *  @param suffix  后缀
 */
- (void)setNumText:(NSString *)numText suffix:(NSString *)suffix;
@end
