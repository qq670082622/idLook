//
//  CustomNavVC.h
//  IDLook
//
//  Created by HYH on 2018/3/7.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavVC : UINavigationController


//黑色标题
+(UILabel *)setDefaultNavgationItemTitle:(NSString *)title;

//富文本标题
+(UILabel *)setAttributeNavgationItemTitle1:(NSString *)title1 withTitle2:(NSString*)title2;

//白色标题
+(UILabel*)setWhiteNavgationItemTitle:(NSString*)title;

//黑色返回键
+ (UIButton *)getLeftDefaultButtonWithTarget:(id)target
                                      action:(SEL)sel;

//白色返回键
+ (UIButton *)getLeftDefaultWhiteButtonWithTarget:(id)target
                                      action:(SEL)sel;

//白色返回键(有背景圈)
+ (UIButton *)getLeftWhiteButtonWithTarget:(id)target
                                      action:(SEL)sel;

//右边文字按钮
+ (UIButton *)getRightDefaultButtionWithTitle:(NSString*)title
                                       Target:(id)target
                                        action:(SEL)sel;

//首页搜索栏
+(UIView*)getHomeSearchButtonWithTarget:(id)target
                                      action:(SEL)sel;

//搜索视图
+(UIView*)getSearchCustomViewWithTarget:(id)target
                        textfieldAction:(SEL)sel1
                          ButtionAction:(SEL)sel2;

//right buttonItem
+(UIButton *)getRightBarButtonItemWithTarget:(id)target
                                             action:(SEL)sel
                                          normalImg:(NSString *)imageN
                                         hilightImg:(NSString *)imageH;

//right buttonItem2
+(UIButton *)getRightBarButtonItem2WithTarget:(id)target
                                             action:(SEL)sel
                                          normalImg:(NSString *)imageN
                                         hilightImg:(NSString *)imageH;

@end
