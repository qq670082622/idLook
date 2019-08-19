//
//  Public.h
//  Alicall
//
//  Created by Fire on 23/11/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef _APP_PUBLIC_
#define _APP_PUBLIC_


unsigned long long GetFileSize(NSString * localFile);

BOOL IsCorrectPhoneNumber(NSString *number);    //手机号

BOOL IsCorrectFixedTelephoneNumber(NSString *number);   //固话

NSString * MD5Str(NSString *inputText);

BOOL IsBankCardNumber (NSString *cardNumber);  //银行卡号校验

NSString * GetLocalAddress(void);  //获取ip地址

NSObject *  safeObjectForKey(NSObject *dic, id key);

BOOL IsBoldSize(void);   //是否粗体文本

#endif
