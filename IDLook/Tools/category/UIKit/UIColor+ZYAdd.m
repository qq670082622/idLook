//
//  UIColor+ZYAdd.m
//  idolproject
//
//  Created by Joe on 16/5/7.
//  Copyright © 2016年 上海泽佑网络科技有限公司. All rights reserved.
//

#import "UIColor+ZYAdd.h"

@implementation UIColor (ZYAdd)


+ (UIColor *)colorWithHexString:(NSString *)string {
    return [UIColor hx_colorWithHexRGBAString:string];
}

+ (UIColor *)colorWithHexString:(NSString *)string alpha:(CGFloat)alpha {
    return [UIColor hx_colorWithHexRGBAString:string alpha:alpha];
}
@end
