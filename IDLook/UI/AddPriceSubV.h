//
//  AddPriceSubV.h
//  IDLook
//
//  Created by HYH on 2018/7/4.
//  Copyright © 2018年 HYH. All rights reserved.
//  报价通用item，button的功能

#import <UIKit/UIKit.h>

@interface AddPriceSubV : UIView

@property(nonatomic,copy)void(^clickWithTag)(NSInteger tag);


/**
 标题
 */
@property(nonatomic,strong)NSString *title;

/**
 价格，小标题
 */
@property(nonatomic,strong)NSString *price;

/**
 背景图片
 */
@property(nonatomic,strong)NSString *imageN;

/**
 标题字体的颜色
 */
@property(nonatomic,strong)UIColor *titleColor;

/**
 价格颜色
 */
@property(nonatomic,strong)UIColor *priceColor;


/**
 是否选中状态
 */
@property(nonatomic,assign)BOOL isSelect;

@end
