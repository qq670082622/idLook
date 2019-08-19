//
//  NSString+ZYAdd.h
//  idolproject
//
//  Created by 刘毅 on 16/2/22.
//  Copyright © 2016年 上海泽佑网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (ZYAdd)
- (NSString *)convertNumText;
- (NSString *)convertNumTextWithPrefix:(NSString *)prefix;
- (NSString *)convertNumTextWithSuffix:(NSString *)suffix;
- (NSString *)convertNumTextWithPrefix:(NSString *)prefix suffix:(NSString *)suffix;

+ (CGSize)sizeFromString:(NSString *)str size:(CGSize)size font:(CGFloat)font;
+ (CGSize)sizeFromString:(NSString *)str size:(CGSize)size UIFont:(UIFont *)font;
- (CGSize)boundingRectWithSize:(CGSize)size font:(CGFloat)font;
- (CGSize)boundingRectWithSize:(CGSize)size UIFont:(UIFont *)font;

+ (NSString *) base64StringFromData:(NSData *)data length:(long)length;
@end
