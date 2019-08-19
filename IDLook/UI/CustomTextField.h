//
//  CustomTextField.h
//  IDLook
//
//  Created by HYH on 2018/5/18.
//  Copyright © 2018年 HYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextField : UITextField<UITextFieldDelegate>

@property(nonatomic,assign)BOOL isNormal;

/**
 是否数字键盘
 */
@property(nonatomic,assign)BOOL isNumber;

/**
 是否密码类型，密码类型只能输入数字和字母
 */
@property(nonatomic,assign)BOOL isPasswordType;

@end